//
//  
//  HealthyCategoryInteractorInput.swift
//  1SK
//
//  Created by TrungDN on 16/09/2022.
//
//

import UIKit

// MARK: - Interactor Input Protocol
protocol HealthyCategoryInteractorInputProtocol {
    func getHealthyPosts(of type: HealthyLivingFilterType, page: Int, perPage: Int)
    func getHealthyPopularPosts()
}

// MARK: - Interactor Output Protocol
protocol HealthyCategoryInteractorOutputProtocol: AnyObject {
    func onGetHealthyPostFinished(with result: Result<[PostHealthModel], APIError>, page: Int)
    func onGetHealthyPopularPostsFinished(with result: Result<[PostHealthModel], APIError>)
}

// MARK: - HealthyCategory InteractorInput
class HealthyCategoryInteractorInput {
    weak var output: HealthyCategoryInteractorOutputProtocol?
    var service: WorkPressServiceProtocol!
}

// MARK: - HealthyCategory InteractorInputProtocol
extension HealthyCategoryInteractorInput: HealthyCategoryInteractorInputProtocol {
    func getHealthyPosts(of type: HealthyLivingFilterType, page: Int, perPage: Int) {
        self.service.getHealthyLivingPosts(of: type, page: page, perPage: perPage) { result in
            self.output?.onGetHealthyPostFinished(with: result.unwrapSuccessModelWP(), page: page)
        }
    }
    
    func getHealthyPopularPosts() {
        self.service.getHealthyLivingPopularPosts { [weak self] result in
            self?.output?.onGetHealthyPopularPostsFinished(with: result.unwrapSuccessModelWP())
        }
    }
}
