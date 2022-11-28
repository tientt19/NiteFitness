//
//  
//  HomeHealthyRouter.swift
//  1SK
//
//  Created by TrungDN on 16/09/2022.
//
//

import UIKit

// MARK: - RouterProtocol
protocol HomeHealthyRouterProtocol {

}

// MARK: - HomeHealthy Router
class HomeHealthyRouter {
    weak var viewController: HomeHealthyViewController?
    
    static func setupModule() -> HomeHealthyViewController {
        let viewController = HomeHealthyViewController()
        let router = HomeHealthyRouter()
        let interactorInput = HomeHealthyInteractorInput()
        let viewModel = HomeHealthyViewModel(interactor: interactorInput)
        
        viewController.viewModel = viewModel
        viewController.router = router
        viewModel.view = viewController
        interactorInput.output = viewModel
        router.viewController = viewController
        
        return viewController
    }
}

// MARK: - HomeHealthy RouterProtocol
extension HomeHealthyRouter: HomeHealthyRouterProtocol {
    
}
