//
//  
//  HealthyDetailViewModel.swift
//  1SK
//
//  Created by TrungDN on 22/09/2022.
//
//

import UIKit

// MARK: - ViewModelProtocol
protocol HealthyDetailViewModelProtocol {
    func onViewDidLoad()
}

// MARK: - HealthyDetail ViewModel
class HealthyDetailViewModel {
    weak var view: HealthyDetailViewProtocol?
    
    private var postDetail: PostHealthModel? {
        didSet {
            self.view?.reloadData(with: self.postDetail)
        }
    }
    
    private var interactor: HealthyDetailInteractorInputProtocol
    private var postId: Int
    
    init(interactor: HealthyDetailInteractorInputProtocol, postId: Int) {
        self.interactor = interactor
        self.postId = postId
    }
}

// MARK: - HealthyDetail ViewModelProtocol
extension HealthyDetailViewModel: HealthyDetailViewModelProtocol {
    func onViewDidLoad() {
        self.view?.showHud()
        self.interactor.getPostDetail(with: self.postId)
    }
}

// MARK: - HealthyDetail InteractorOutputProtocol
extension HealthyDetailViewModel: HealthyDetailInteractorOutputProtocol {
    func onGetPostDetailFinished(with result: Result<PostHealthModel, APIError>) {
        switch result {
        case .success(let model):
            // Handle Data'
            self.postDetail = model
            
        case .failure(let error):
            if error.statusCode == 404 {
                SKToast.shared.showToast(content: "Không tìm thầy bài viết")
            } else {
                SKToast.shared.showToast(content: error.message)
            }
        }
        self.view?.hideHud()
    }
}
