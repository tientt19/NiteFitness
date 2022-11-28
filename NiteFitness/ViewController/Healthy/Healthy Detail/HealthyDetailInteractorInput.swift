//
//  
//  HealthyDetailInteractorInput.swift
//  1SK
//
//  Created by TrungDN on 22/09/2022.
//
//

import UIKit

// MARK: - Interactor Input Protocol
protocol HealthyDetailInteractorInputProtocol {
    func getPostDetail(with postId: Int)
}

// MARK: - Interactor Output Protocol
protocol HealthyDetailInteractorOutputProtocol: AnyObject {
    func onGetPostDetailFinished(with result: Result<PostHealthModel, APIError>)
}

// MARK: - HealthyDetail InteractorInput
class HealthyDetailInteractorInput {
    weak var output: HealthyDetailInteractorOutputProtocol?
    var service: WorkPressServiceProtocol!
}

// MARK: - HealthyDetail InteractorInputProtocol
extension HealthyDetailInteractorInput: HealthyDetailInteractorInputProtocol {
    
    func getPostDetail(with postId: Int) {
        self.service.getHealthyLiving(with: postId) { [weak self] result in
            guard let `self` = self else { return }
            self.output?.onGetPostDetailFinished(with: result)
        }
    }
}
