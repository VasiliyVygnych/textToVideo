

import UIKit

class MainViewModel: MainViewModelProtocol {
    
    var coordinator: MainCoordinatorProtocol?
    var coreData: CoreManagerProtocol?
    var network: NetworkServiceProtocol?
    var subscription: SubscriptionManagerProtocol?
    var access = Bool()
    var modeSubscription = SubscriptionMode.none
    
    
//MARK: - Network
    
    func requestExampVideo() {
        Task {
            do {
                let response = try await network?.requestExampVideo()
                response?.forEach({ data in
                    if let url = URL(string: data.videoURL) {
                            network?.downloadVideo(url,
                                                   completion: { docUrl in
                            DispatchQueue.main.async { [weak self] in
                                self?.coreData?.addExampData(model: data,
                                                             url: docUrl?.absoluteString)
                            }
                        })
                    }
                })
            } catch {
                print("Failed to perform request: \(error.localizedDescription)")
            }
        }
    }

//MARK: - CoreData
    
    func removeAll() {
        coreData?.removaAll()
    }
    func setData(mode: SubscriptionMode) {
        let data = coreData?.getAppData()
        if data?.isEmpty == true {
            coreData?.setMainModel(mode: mode)
        } else {
            coreData?.addSubscride(mode: mode)
        }
    }
    func getAppData() -> [AppData]? {
        coreData?.getAppData()
    }
    func setMainModel(_ mode: SubscriptionMode) {
        coreData?.setMainModel(mode: mode)
    }
    func removeExampData() {
        coreData?.removeExampData()
    }
    
//MARK: - Coordinator
    
    func openTabBarController() {
        if access == true {
            coordinator?.createTabBarController()
        } else {
            coordinator?.createPaywallController()
        }
    }
    func openTabBar() {
        coordinator?.createTabBarController()
    }
    func openPaywallController() {
        coordinator?.createPaywallController()
    }
    func openWebViewController(title: String,
                               mode: SettingsWebView) {
        coordinator?.createWebViewController(title: title,
                                             mode: mode)
    }
    
//MARK: - View
    
    func viewAnimate(view: UIView,
                     duration: Double,
                     scale: Double) {
        UIView.animate(withDuration: duration,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: {
            view.transform = CGAffineTransform(scaleX: scale,
                                               y: scale)
        }, completion: { finished in
            UIView.animate(withDuration: duration,
                           delay: 0,
                           options: .curveEaseOut,
                           animations: {
                view.transform = CGAffineTransform(scaleX: 1,
                                                   y: 1)
            })
        })
    }
    func currencPrice(from input: String) -> String {
        let сharacters = CharacterSet(charactersIn: "0123456789.,")
        let filtered = input.unicodeScalars.filter { !сharacters.contains($0) }
        return String(filtered)
    }
    
//MARK: - Subscription
    
    func delegate(_ delegate: SubscriptionDelegate) {
        subscription?.delegate = delegate
    }
    func loadProducts() {
        Task {
            try await subscription?.loadProducts()
            checkSubscription()
            DispatchQueue.main.async { [weak self] in
                self?.subscriptionData()
            }
        }
    }
    func restoreSubscription() {
        Task {
            try await subscription?.restorePurchases()
        }
    }
    func setupSubscription(_ mode: SubscriptionMode) {
        Task {
            try await self.subscription?.purchase(mode)
        }
    }

    func subscriptionData() {
        var price: [String] = []
        subscription?.myProducts.forEach({ product in
            price.append(product.displayPrice)
        })
        subscription?.delegate?.getSubscriptionData(price)
    }
    func checkSubscription() {
        let data = coreData?.getAppData()
        data?.forEach({ model in
            checkingFreeAccess(model)
            checkingPlusAssets(model)
            checkingUltraAssets(model)
        })
    }
    func checkingFreeAccess(_ model: AppData) {
        if model.subscripeType == SubscriptionType.free {
            access = model.freeAccess
            print("подписка free активна")
            
            let interval = daysBetween(start: model.freeUpdateDate,
                                       end: Date())
            if interval > daysPerMonth() ?? 0 {
                coreData?.activationFreeAccess()
            }
            if interval > 7 {
                coreData?.updateFreeAITime()
            }
        }
    }
    func checkingPlusAssets(_ model: AppData) {
        if model.subscripeType == SubscriptionType.plus {
            access = model.isSubscripe
            print("активна подписка - \(String(describing: model.subscripeID))")
            let interval = daysBetween(start: model.plusUpdateDate,
                                       end: Date())
            if model.subscripeID == "monthlyPlus" {
                if interval > daysPerMonth() ?? 0 {
                    coreData?.activationPlusAccess()
                }
            }
            if model.subscripeID == "yearlyPlus" {
                if interval > daysPerYear() {
                    coreData?.activationPlusAccess()
                }
            }
            if interval > 7 {
                coreData?.updatePlusAITime()
            }
        }
    }
    func checkingUltraAssets(_ model: AppData) {
        if model.subscripeType == SubscriptionType.Ultra {
            access = model.isSubscripe
            print("активна подписка - \(String(describing: model.subscripeID))")
            let interval = daysBetween(start: model.ultraUpdateDate,
                                       end: Date())
            if model.subscripeID == "monthlyUltra" {
                if interval > daysPerMonth() ?? 0 {
                    coreData?.activationUltraAccess()
                }
            }
            if model.subscripeID == "yearlyUltra" {
                if interval > daysPerYear() {
                    coreData?.activationUltraAccess()
                }
            }
        }
//        coreData?.editUltra(false) // отключить ultra подписку
    }
    func daysPerYear() -> Int {
        var year = Int()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        year = Int(formatter.string(from: Date())) ?? 0
        let isLeapYear = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
        return isLeapYear ? 366 : 365
    }
    func daysBetween(start: Date,
                     end: Date) -> Int {
        let calendar = Calendar.current
        let startOfDay1 = calendar.startOfDay(for: start)
        let startOfDay2 = calendar.startOfDay(for: end)
        let components = calendar.dateComponents([.day],
                                                 from: startOfDay1,
                                                 to: startOfDay2)
        return components.day ?? 0
    }
    func daysPerMonth() -> Int? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let year = Int(formatter.string(from: Date())) ?? 0
        formatter.dateFormat = "M"
        let month = Int(formatter.string(from: Date())) ?? 0
        guard month >= 1 && month <= 12 else {
            return nil
        }
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = 1
        let calendar = Calendar.current
        if let date = calendar.date(from: components) {
            let range = calendar.range(of: .day,
                                       in: .month,
                                       for: date)
            return range?.count
        }
        return nil
    }
    func minutesBetween(startDate: Date,
                        endDate: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.minute],
                                                 from: startDate,
                                                 to: endDate)
        return Int(components.hour ?? 0)
    }
}
