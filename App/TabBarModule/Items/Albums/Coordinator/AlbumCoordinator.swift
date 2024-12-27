//
//  AlbumCoordinator.swift
//  CreateAIVideo
//
//  Created by Vasiliy Vygnych on 16.10.2024.
//

import UIKit

class AlbumCoordinator: AlbumCoordinatorProtocol {
    
    var navigationController: UINavigationController?
    var assembler: AlbumBuilderProtocol
    
    init(navigationController: UINavigationController?,
         assembler: AlbumBuilderProtocol = AlbumBuilder()) {
        self.navigationController = navigationController
        self.assembler = assembler
    }

    func createAddAlbumController(delegate: AlbumCreateDelegate?) {
        if let navigationController = navigationController {
            let controller = assembler.createAddAlbumController(coordinator: self,
                                                                delegate: delegate)
            navigationController.present(controller,
                                         animated: true)
        }
    }
    func createSavedVideoController(view: UIViewController,
                                    delegate: AddVideoDelegate?,
                                    albumData: AlbumsData?) {
        let controller = assembler.createSavedVideoController(coordinator: self,
                                                              delegate: delegate,
                                                              albumData: albumData)
        view.present(controller,
                     animated: true)
    }
    func createPaywallController() {
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
    func createDetailAlbumController(model: AlbumsData?) {
        if let navigationController = navigationController {
            let controller = assembler.createDetailAlbumController(coordinator: self,
                                                                   model: model)
            navigationController.pushViewController(controller,
                                                    animated: false)
        }
    }
    func createDetailVideoController(savedVideos: SavedVideos?,
                                     albumContents: AlbumContents?) {
        if let navigationController = navigationController {
            let controller = assembler.createDetailVideoController(navigation: navigationController,
                                                                   savedVideos: savedVideos,
                                                                   albumContents: albumContents)
            navigationController.pushViewController(controller,
                                                    animated: false)
        }
    }
    
    
    func createBaseVideoController(model: BaseData?,
                                   recentActivity: IncompleteData?) {
        if let navigationController = navigationController {
            let controller = assembler.createBaseVideoController(navigation: navigationController,
                                                                 model: model,
                                                                 recentActivity: recentActivity)
            navigationController.pushViewController(controller,
                                                    animated: false)
        }
    }
    func createTextToImageController() {
        if let navigationController = navigationController {
            let controller = assembler.createTextToImageController(navigation: navigationController)
//            controller.modalPresentationStyle = .fullScreen
//            navigationController.present(controller,
//                                         animated: false)
            navigationController.pushViewController(controller,
                                                    animated: false)
        }
    }
    func createVideoToVideoController() {
        if let navigationController = navigationController {
            let controller = assembler.createVideoToVideoController(navigation: navigationController)
            navigationController.pushViewController(controller,
                                                    animated: false)
        }
    }
    func createHistoryController() {
        if let navigationController = navigationController {
            let controller = assembler.createHistoryController(navigation: navigationController)
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
