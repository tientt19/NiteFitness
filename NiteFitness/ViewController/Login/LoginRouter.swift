//
//  
//  LoginRouter.swift
//  NiteFitness
//
//  Created by Tiến Trần on 31/10/2022.
//
//

import UIKit

// MARK: - RouterProtocol
protocol LoginRouterProtocol {

}

// MARK: - Login Router
class LoginRouter {
    weak var viewController: LoginViewController?
    
    static func setupModule() -> LoginViewController {
        let viewController = LoginViewController()
        let router = LoginRouter()
        let interactorInput = LoginInteractorInput()
        let viewModel = LoginViewModel(interactor: interactorInput)
        
        viewController.viewModel = viewModel
        viewController.router = router
        viewModel.view = viewController
        interactorInput.output = viewModel
        router.viewController = viewController
        
        return viewController
    }
}

// MARK: - Login RouterProtocol
extension LoginRouter: LoginRouterProtocol {
    
}
