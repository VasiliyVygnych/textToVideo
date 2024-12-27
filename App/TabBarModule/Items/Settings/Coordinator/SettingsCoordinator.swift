//
//  SettingsCoordinator.swift
//  CreateAIVideo
//
//  Created by Vasiliy Vygnych on 16.10.2024.
//

import UIKit

class SettingsCoordinator: SettingsCoordinatorProtocol {
    
    var navigationController: UINavigationController?
    var assembler: SettingsBuilderProtocol
    
    init(navigationController: UINavigationController?,
         assembler: SettingsBuilderProtocol = SettingsBuilder()) {
        self.navigationController = navigationController
        self.assembler = assembler
    }
    
    func createPaywallController()  {
        if let navigationController = navigationController {
            if isDeviceOld() {
                let controller = assembler.createPaywallForOldIphone(navigation: navigationController)
                navigationController.pushViewController(controller,
                                                        animated: false)
            } else {
                let controller = assembler.createPaywallController(navigation: navigationController)
                navigationController.pushViewController(controller,
                                                        animated: false)
            }
        }
    }
    func presentView(view: UIViewController) {
        if let navigationController = navigationController {
            navigationController.present(view,
                                         animated: true)
        }
    }
    func createWebViewController(title: String,
                                 mode: SettingsWebView) {
        if let navigationController = navigationController {
            let controller = assembler.createWebViewController(navigation: navigationController,
                                                               title: title,
                                                               mode: mode)
            navigationController.pushViewController(controller,
                                                    animated: false)
        }
    }
    func isDeviceOld() -> Bool {
        let device = UIDevice.current
        let model = device.model
        let systemVersion = device.systemVersion
        let oldDevices = [
            "iPhone SE",
            "iPhone 5s",
            "iPhone 5c",
            "iPhone 5",
            "iPad (4th generation)",
            "iPad mini (1st generation)",
            "iPad Air (1st generation)",
            "iPad mini 2",
            "iPad mini 3",
            "iPad Air 2"
        ]
        if oldDevices.contains(model) {
            return false
        }
        if model.contains("iPad") {
            if let version = Int(systemVersion.split(separator: ".").first ?? "0"),
                version < 12 {
                return false
            }
        }
        return true
    }
}
