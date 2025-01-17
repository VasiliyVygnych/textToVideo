//
//  SettingsViewModel.swift
//  CreateAIVideo
//
//  Created by Vasiliy Vygnych on 16.10.2024.
//

import UIKit

class SettingsViewModel: SettingsViewModelProtocol {
    
    var coordinator: SettingsCoordinatorProtocol?
    var coreData: CoreManagerProtocol?
    var subscription: SubscriptionManagerProtocol?
    
//MARK: - Coordinator
    
    
    
    func openPaywallController() {
        coordinator?.createPaywallController()
    }
    func presentView(view: UIViewController) {
        coordinator?.presentView(view: view)
    }
    func openWebViewController(title: String,
                               mode: SettingsWebView) {
        coordinator?.createWebViewController(title: title,
                                             mode: mode)
    }
    

//MARK: - Core Data
    
    func getAppData() -> [AppData]? {
        coreData?.getAppData()
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
}

