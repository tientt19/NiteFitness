//
//  
//  HealthyDetailRouter.swift
//  1SK
//
//  Created by TrungDN on 22/09/2022.
//
//

import UIKit

// MARK: - RouterProtocol
protocol HealthyDetailRouterProtocol {

}

// MARK: - HealthyDetail Router
class HealthyDetailRouter {
    weak var viewController: HealthyDetailViewController?
    
    static func setupModule(with postId: Int) -> HealthyDetailViewController {
        let viewController = HealthyDetailViewController()
        let router = HealthyDetailRouter()
        let interactorInput = HealthyDetailInteractorInput()
        let viewModel = HealthyDetailViewModel(interactor: interactorInput, postId: postId)
        
        viewController.viewModel = viewModel
        viewController.router = router
        viewController.hidesBottomBarWhenPushed = true
        viewModel.view = viewController
        interactorInput.output = viewModel
        interactorInput.service = WorkPressService()
        router.viewController = viewController
        
        return viewController
    }
}

// MARK: - HealthyDetail RouterProtocol
extension HealthyDetailRouter: HealthyDetailRouterProtocol {
    
}
