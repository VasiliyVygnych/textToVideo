//
//  SettingsBuilder.swift
//  CreateAIVideo
//
//  Created by Vasiliy Vygnych on 16.10.2024.
//

import UIKit

class SettingsBuilder: SettingsBuilderProtocol {

    func createPaywallForOldIphone(navigation: UINavigationController) -> UIViewController {
        let controller = PaywallForOldIphone()
        var viewModel: MainViewModelProtocol = MainViewModel()
        let coreData: CoreManagerProtocol = CoreManager()
        let subscription: SubscriptionManagerProtocol = SubscriptionManager()
        let coordinator: MainCoordinatorProtocol = MainCoordinator(navigationController: navigation)
        viewModel.coreData = coreData
        viewModel.subscription = subscription
        viewModel.coordinator = coordinator
        controller.viewModel = viewModel
        controller.isFirst = true
        return controller
    }
    func createPaywallController(navigation: UINavigationController) -> UIViewController {
        let controller = PaywallController()
        var viewModel: MainViewModelProtocol = MainViewModel()
        let coreData: CoreManagerProtocol = CoreManager()
        let coordinator: MainCoordinatorProtocol = MainCoordinator(navigationController: navigation)
        let subscription: SubscriptionManagerProtocol = SubscriptionManager()
        viewModel.subscription = subscription
        viewModel.coordinator = coordinator
        controller.viewModel = viewModel
        controller.isFirst = false
        viewModel.coreData = coreData
        return controller
    }
    func createWebViewController(navigation: UINavigationController,
                                 title: String,
                                 mode: SettingsWebView) -> UIViewController {
        let controller = WebViewController()
        var viewModel: MainViewModelProtocol = MainViewModel()
        let coreData: CoreManagerProtocol = CoreManager()
        let subscription: SubscriptionManagerProtocol = SubscriptionManager()
        let coordinator: MainCoordinatorProtocol = MainCoordinator(navigationController: navigation)
        viewModel.subscription = subscription
        viewModel.coordinator = coordinator
        viewModel.coreData = coreData
        controller.viewModel = viewModel
        controller.navTitle = title
        controller.mode = mode
        return controller
    }
}
