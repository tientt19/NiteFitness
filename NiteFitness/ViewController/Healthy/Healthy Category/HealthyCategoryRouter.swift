//
//  
//  HealthyCategoryRouter.swift
//  1SK
//
//  Created by TrungDN on 16/09/2022.
//
//

import UIKit

// MARK: - RouterProtocol
protocol HealthyCategoryRouterProtocol: BaseRouterProtocol {
    func onPresentHealthyWebView(url: URL)
}

// MARK: - HealthyCategory Router
class HealthyCategoryRouter: BaseRouter {
    static func setupModule(with filterType: HealthyLivingFilterType) -> HealthyCategoryViewController {
        let viewController = HealthyCategoryViewController()
        let router = HealthyCategoryRouter()
        let interactorInput = HealthyCategoryInteractorInput()
        let viewModel = HealthyCategoryViewModel(interactor: interactorInput, filterType: filterType)
        
        viewController.viewModel = viewModel
        viewController.router = router
        viewModel.view = viewController
        interactorInput.output = viewModel
        interactorInput.service = WorkPressService()
        router.viewController = viewController
        
        return viewController
    }
}

// MARK: - HealthyCategory RouterProtocol
extension HealthyCategoryRouter: HealthyCategoryRouterProtocol {
    func onPresentHealthyWebView(url: URL) {
        self.showHud()
        let wvc = HealthDetailWebView(nibName: "HealthDetailWebView", bundle: nil)
        wvc.modalPresentationStyle = .pageSheet
        wvc.loadWebView(url: url) {
            self.hideHud()
            self.viewController?.present(wvc, animated: true, completion: nil)
        }
    }
}
