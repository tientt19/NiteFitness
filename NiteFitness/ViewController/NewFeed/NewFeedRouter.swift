//
//  
//  NewFeedRouter.swift
//  NiteFitness
//
//  Created by Tiến Trần on 31/10/2022.
//
//

import UIKit

// MARK: - RouterProtocol
protocol NewFeedRouterProtocol {

}

// MARK: - NewFeed Router
class NewFeedRouter {
    weak var viewController: NewFeedViewController?
    
    static func setupModule() -> NewFeedViewController {
        let viewController = NewFeedViewController()
        let router = NewFeedRouter()
        let interactorInput = NewFeedInteractorInput()
        let viewModel = NewFeedViewModel(interactor: interactorInput)
        
        viewController.viewModel = viewModel
        viewController.router = router
        viewModel.view = viewController
        interactorInput.output = viewModel
        router.viewController = viewController
        
        return viewController
    }
}

// MARK: - NewFeed RouterProtocol
extension NewFeedRouter: NewFeedRouterProtocol {
    
}
