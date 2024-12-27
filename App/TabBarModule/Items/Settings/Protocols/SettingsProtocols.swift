//
//  SettingsProtocols.swift
//  CreateAIVideo
//
//  Created by Vasiliy Vygnych on 16.10.2024.
//

import UIKit

protocol SettingsViewModelProtocol {
    
    var coordinator: SettingsCoordinatorProtocol? { get set }
    var coreData: CoreManagerProtocol? { get set }
    var subscription: SubscriptionManagerProtocol? { get set }
    
//MARK: - Coordinator
    
    
    func openPaywallController()
    func presentView(view: UIViewController)
    func openWebViewController(title: String,
                               mode: SettingsWebView)
    
//MARK: - Core Data
    
    func getAppData() -> [AppData]? 
    
//MARK: - View
    
    func viewAnimate(view: UIView,
                     duration: Double,
                     scale: Double)
}

protocol SettingsBuilderProtocol {

    
    func createPaywallForOldIphone(navigation: UINavigationController) -> UIViewController
    func createPaywallController(navigation: UINavigationController) -> UIViewController
    func createWebViewController(navigation: UINavigationController,
                                 title: String,
                                 mode: SettingsWebView) -> UIViewController
}

protocol SettingsCoordinatorProtocol {
    func createPaywallController() 
    func presentView(view: UIViewController)
    func createWebViewController(title: String,
                                 mode: SettingsWebView)
}
