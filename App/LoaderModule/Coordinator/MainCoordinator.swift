

import UIKit

class MainCoordinator: MainCoordinatorProtocol {
    
    var navigationController: UINavigationController?
    var assembler: MainBuilderProtocol
    
    init(navigationController: UINavigationController?,
         assembler: MainBuilderProtocol = MainBuilder()) {
        self.navigationController = navigationController
        self.assembler = assembler
    }
    
    func initial() {
        if let navigationController = navigationController {
            let controller = assembler.createLoaderController(coordinator: self)
            navigationController.viewControllers = [controller]
        }
    }
    func createPaywallController() {
        if let navigationController = navigationController {
            if isDeviceOld() {
                print("Устройство с маленьким экраном (iPhone SE или меньше)")
                let controller = assembler.createPaywallForOldIphone(coordinator: self)
                navigationController.pushViewController(controller,
                                                        animated: false)
            } else {
                print("Устройство с большим экраном")
                let controller = assembler.createPaywallController(coordinator: self)
                navigationController.pushViewController(controller,
                                                        animated: false)
            }
        }
    }
    func createWebViewController(title: String,
                                 mode: SettingsWebView) {
        if let navigationController = navigationController {
            let controller = assembler.createWebViewController(coordinator: self,
                                                               title: title,
                                                               mode: mode)
            navigationController.pushViewController(controller,
                                                    animated: false)
        }
    }
    func createTabBarController() {
        if let navigationController = navigationController {
            let controller = assembler.createTabBarController()
            navigationController.viewControllers.removeAll()
            navigationController.viewControllers = [controller]
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
