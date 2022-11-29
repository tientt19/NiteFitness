//
//  
//  HistoryVideosFitRouter.swift
//  1SK
//
//  Created by Valerian on 24/06/2022.
//
//

import UIKit

// MARK: - RouterProtocol
protocol HistoryVideosFitRouterProtocol {
    func showVideoFitDetailPlayerRouter(video: VideoModel)
}

// MARK: - HistoryVideosFit Router
class HistoryVideosFitRouter {
    weak var viewController: HistoryVideosFitViewController?
    
    static func setupModule() -> HistoryVideosFitViewController {
        let viewController = HistoryVideosFitViewController()
        let router = HistoryVideosFitRouter()
        let interactorInput = HistoryVideosFitInteractorInput()
        let viewModel = HistoryVideosFitViewModel(interactor: interactorInput)
        
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

// MARK: - HistoryVideosFit RouterProtocol
extension HistoryVideosFitRouter: HistoryVideosFitRouterProtocol {
    func showVideoFitDetailPlayerRouter(video: VideoModel) {
        let controller = VideoFitDetailPlayerRouter.setupModule(video: video)
        self.viewController?.navigationController?.show(controller, sender: nil)
    }
}
