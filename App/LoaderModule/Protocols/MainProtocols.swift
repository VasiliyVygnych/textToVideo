

import UIKit

protocol SubscriptionDelegalate: AnyObject {
    func subscriptionSelected(_ subscription: SubscriptionMode)
    func activeButton()
}

protocol MainViewModelProtocol {
    
    var coordinator: MainCoordinatorProtocol? { get set }
    var coreData: CoreManagerProtocol? { get set }
    var subscription: SubscriptionManagerProtocol? { get set }
    var network: NetworkServiceProtocol? { get set }
    
//MARK: - Network
    
    func requestExampVideo()
    
//MARK: - Core Data
    
    func removeAll()
    func setData(mode: SubscriptionMode)
    func getAppData() -> [AppData]?
    func setMainModel(_ mode: SubscriptionMode)
    func removeExampData()
    
//MARK: - Coordinator
    
    func openTabBarController()
    func openTabBar()
    func openPaywallController()
    func openWebViewController(title: String,
                               mode: SettingsWebView)
    
//MARK: - View
    
    func viewAnimate(view: UIView,
                     duration: Double,
                     scale: Double)
    func currencPrice(from input: String) -> String
    
//MARK: - Subscription
    
    func delegate(_ delegate: SubscriptionDelegate)
    func loadProducts()
    func setupSubscription(_ mode: SubscriptionMode)
    func checkSubscription()
    func restoreSubscription()
    
}

protocol MainBuilderProtocol {
    func createLoaderController(coordinator: MainCoordinatorProtocol) -> UIViewController
    func createPaywallController(coordinator: MainCoordinatorProtocol) -> UIViewController
    func createPaywallForOldIphone(coordinator: MainCoordinatorProtocol) -> UIViewController
    func createWebViewController(coordinator: MainCoordinatorProtocol,
                                 title: String,
                                 mode: SettingsWebView) -> UIViewController
    func createTabBarController() -> UIViewController
}

protocol MainCoordinatorProtocol {
    func initial()
    func createPaywallController()
    func createWebViewController(title: String,
                                 mode: SettingsWebView)
    func createTabBarController()
}
