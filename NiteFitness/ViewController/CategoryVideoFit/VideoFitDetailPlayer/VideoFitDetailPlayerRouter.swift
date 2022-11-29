//
//  
//  VideoFitDetailPlayerRouter.swift
//  1SK
//
//  Created by Valerian on 28/06/2022.
//
//

import UIKit

// MARK: - RouterProtocol
protocol VideoFitDetailPlayerRouterProtocol {
    func showShareViewController(with shareItem: [Any], sourceView: UIView)
}

// MARK: - VideoExerciseDetail Router
class VideoFitDetailPlayerRouter {
    weak var viewController: VideoFitDetailPlayerViewController?
    
    static func setupModule(video: VideoModel) -> VideoFitDetailPlayerViewController {
        let viewController = VideoFitDetailPlayerViewController()
        let router = VideoFitDetailPlayerRouter()
        let interactorInput = VideoFitDetailPlayerInteractorInput()
        let viewModel = VideoFitDetailPlayerViewModel(interactor: interactorInput)
        
        viewController.viewModel = viewModel
        viewController.router = router
        viewController.hidesBottomBarWhenPushed = true
        viewModel.view = viewController
        viewModel.video = video
        interactorInput.output = viewModel
        interactorInput.fitVideoSevice = FitVideoService()
        router.viewController = viewController
        
        return viewController
    }
}

// MARK: - VideoExerciseDetail RouterProtocol
extension VideoFitDetailPlayerRouter: VideoFitDetailPlayerRouterProtocol {
    func showShareViewController(with shareItem: [Any], sourceView: UIView) {
        let controller = UIActivityViewController(activityItems: shareItem, applicationActivities: nil)
        controller.popoverPresentationController?.sourceView = sourceView
        controller.popoverPresentationController?.sourceRect = sourceView.bounds
        self.viewController?.present(controller, animated: true, completion: nil)
    }
}
