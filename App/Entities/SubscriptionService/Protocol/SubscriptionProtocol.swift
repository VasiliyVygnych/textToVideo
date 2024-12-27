//
//  SubscriptionProtocol.swift
//  CreateAIVideo
//
//  Created by Vasiliy Vygnych on 16.10.2024.
//

import UIKit
import StoreKit

protocol SubscriptionDelegate: AnyObject {
    func update()
    func getSubscriptionData(_ data: [String])
}

protocol SubscriptionManagerProtocol {
    
    var delegate: SubscriptionDelegate? { get set }
    func updatePurchasedProducts() async
    var hasDidUnlocked: Bool { get }
    var myProductIds: [String] { get set }
    var myProducts: [Product] { get set }
    var subscriptionID: String? { get set }
    @MainActor
    func loadProducts() async throws
    func purchase(_ choice: SubscriptionMode) async throws
    func restorePurchases() async throws
    
}
