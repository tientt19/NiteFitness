//
//  
//  CategoryVideoFitInteractorInput.swift
//  1SK
//
//  Created by Valerian on 23/06/2022.
//
//

import UIKit

// MARK: - Interactor Input Protocol
protocol CategoryVideoFitInteractorInputProtocol {
    func getCategoryFit()
    func getVideoFit(categoryId: Int, page: Int)
}

// MARK: - Interactor Output Protocol
protocol CategoryVideoFitInteractorOutputProtocol: AnyObject {
    func onGetCategoryFitFinished(with result: Result<CategoriesModel, APIError>)
    func onGetVideoFitFinished(with result: Result<[VideoModel], APIError>, totalPages: Int)
}

// MARK: - CategoryVideoFit InteractorInput
class CategoryVideoFitInteractorInput {
    weak var output: CategoryVideoFitInteractorOutputProtocol?
    var fitVideoSevice: FitVideoSeviceProtocol?
}

// MARK: - CategoryVideoFit InteractorInputProtocol
extension CategoryVideoFitInteractorInput: CategoryVideoFitInteractorInputProtocol {
    func getCategoryFit() {
        self.fitVideoSevice?.getCategoriesVideo(completion: { [weak self] result in
            self?.output?.onGetCategoryFitFinished(with: result.unwrapSuccessModel())
        })
    }
    
    func getVideoFit(categoryId: Int, page: Int) {
        self.fitVideoSevice?.getVideoByCategory(categoryId: categoryId, completion: { [weak self] result in
            let totalPages = result.getMeta()?.pagination?.totalPages
            self?.output?.onGetVideoFitFinished(with: result.unwrapSuccessModel(), totalPages: 1)
        })
    }
}
