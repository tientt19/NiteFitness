//
//  
//  CategoryVideoFitRouter.swift
//  1SK
//
//  Created by Valerian on 23/06/2022.
//
// CategoryVideoFit

import UIKit

// MARK: - RouterProtocol
protocol CategoryVideoFitRouterProtocol {
    func showHistoryVideosFitRouter()
    func showFavouriteVideoFitRouter()
    func showVideoFitDetailPlayerRouter(video: VideoModel)
}

// MARK: - CategoryVideoFit Router
class CategoryVideoFitRouter {
    weak var viewController: CategoryVideoFitViewController?
    
    static func setupModule() -> CategoryVideoFitViewController {
        let viewController = CategoryVideoFitViewController()
        let router = CategoryVideoFitRouter()
        let interactorInput = CategoryVideoFitInteractorInput()
        let viewModel = CategoryVideoFitViewModel(interactor: interactorInput)
        
        viewController.viewModel = viewModel
        viewController.router = router
        viewModel.view = viewController
        interactorInput.output = viewModel
        interactorInput.fitVideoSevice = FitVideoService()
        router.viewController = viewController
        
        return viewController
    }
}

// MARK: - CategoryVideoFit RouterProtocol
extension CategoryVideoFitRouter: CategoryVideoFitRouterProtocol {
    func showHistoryVideosFitRouter() {
        let controller = HistoryVideosFitRouter.setupModule()
        self.viewController?.navigationController?.show(controller, sender: nil)
    }
    
    func showFavouriteVideoFitRouter() {
        let controller = FavouriteVideoFitRouter.setupModule()
        self.viewController?.navigationController?.show(controller, sender: nil)
    }
    
    func showVideoFitDetailPlayerRouter(video: VideoModel) {
        let controller = VideoFitDetailPlayerRouter.setupModule(video: video)
        self.viewController?.navigationController?.show(controller, sender: nil)
    }
}
