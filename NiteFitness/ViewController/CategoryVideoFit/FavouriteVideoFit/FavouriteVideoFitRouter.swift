//
//  
//  FavouriteVideoFitRouter.swift
//  1SK
//
//  Created by Thaad on 08/07/2022.
//
//

import UIKit

// MARK: - RouterProtocol
protocol FavouriteVideoFitRouterProtocol {
    func showVideoFitDetailPlayerRouter(video: VideoModel)
}

// MARK: - FavouriteVideoFit Router
class FavouriteVideoFitRouter {
    weak var viewController: FavouriteVideoFitViewController?
    
    static func setupModule() -> FavouriteVideoFitViewController {
        let viewController = FavouriteVideoFitViewController()
        let router = FavouriteVideoFitRouter()
        let interactorInput = FavouriteVideoFitInteractorInput()
        let viewModel = FavouriteVideoFitViewModel(interactor: interactorInput)
        
        viewController.viewModel = viewModel
        viewController.router = router
        viewController.hidesBottomBarWhenPushed = true
        viewModel.view = viewController
        interactorInput.output = viewModel
        interactorInput.fitVideoSevice = FitVideoService()
        router.viewController = viewController
        
        return viewController
    }
}

// MARK: - FavouriteVideoFit RouterProtocol
extension FavouriteVideoFitRouter: FavouriteVideoFitRouterProtocol {
    func showVideoFitDetailPlayerRouter(video: VideoModel) {
        let controller = VideoFitDetailPlayerRouter.setupModule(video: video)
        self.viewController?.navigationController?.show(controller, sender: nil)
    }
}
