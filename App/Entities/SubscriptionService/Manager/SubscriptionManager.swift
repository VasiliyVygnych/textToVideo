//
//  SubscriptionManager.swift
//  CreateAIVideo
//
//  Created by Vasiliy Vygnych on 16.10.2024.
//

import UIKit
import StoreKit

class SubscriptionManager: SubscriptionManagerProtocol {
    
    weak var delegate: SubscriptionDelegate?
    
    private(set) var purchasedProductIDs = Set<String>()
    var myProductIds: [String] = []
    var myProducts: [Product] = []
    var hasDidUnlocked: Bool {
        return self.purchasedProductIDs.isEmpty
    }
    var subscriptionID: String?
    let productIds = [SubscriptionID.monthlyPlus,
                      SubscriptionID.monthlyUltra,
                      SubscriptionID.yearlyPlus,
                      SubscriptionID.yearlyUltra]
    
    func loadProducts() async throws {
        do {
            self.myProducts = try await Product.products(for: productIds)
                .sorted(by: { $0.id < $1.id })
        } catch {
            print("Error fetching products: \(error)")
            throw error
        }
    }
    func updatePurchasedProducts() async {
        for await result in Transaction.currentEntitlements {
            guard case .verified(let transaction) = result else {
                continue
            }
            if transaction.revocationDate == nil {
                self.purchasedProductIDs.insert(transaction.productID)
                self.myProductIds.append(transaction.productID)
                subscriptionID = transaction.productID
            } else {
                self.purchasedProductIDs.remove(transaction.productID)
                myProductIds.removeAll { $0 == transaction.productID }
            }
        }
    }
    func purchase(_ choice: SubscriptionMode) async throws {
        var result: Product.PurchaseResult?
        let sorted = myProducts.sorted { $0.id < $1.id }
        switch choice {
        case .monthlyPlus:
            result = try await sorted[0].purchase()
        case .monthlyUltra:
            result = try await sorted[1].purchase()
        case .yearlyPlus:
            result = try await sorted[2].purchase()
        case .yearlyUltra:
            result = try await sorted[3].purchase()
        case .none:
            break
        case .free:
            break
        }
        switch result {
        case let .success(.verified(transaction)):
            Task {
                await self.updatePurchasedProducts()
            }
            self.delegate?.update()
            await transaction.finish()
        case let .success(.unverified(_, error)):
            print("can't be verified")
            print(error)
        case .pending:
            print("pending")
        case .userCancelled:
            print("userCancelled")
        case .none:
            print("none")
        @unknown default:
            break
        }
    }
    @MainActor
    func restorePurchases() async throws {
        do {
            try await AppStore.sync()
            SKPaymentQueue.default().restoreCompletedTransactions()
            self.delegate?.update()
        } catch {
            print(error)
        }
    }
}
