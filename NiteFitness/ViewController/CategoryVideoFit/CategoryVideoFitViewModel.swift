//
//  
//  ListVideoExerciseViewModel.swift
//  1SK
//
//  Created by Valerian on 23/06/2022.
//
//

import UIKit

// MARK: - ViewModelProtocol
protocol CategoryVideoFitViewModelProtocol {
    func onViewDidLoad()
    
    // UITableView
    func numberOfListCategoryVideoExercise() -> Int
    func numberOfListVideoExercise() -> Int
    
    func listVideoExerciseCellForRow(at indexPath: IndexPath) -> VideoModel?
    func listCategoryExerciseCellForRow(at indexPath: IndexPath) -> Children?
    
    func didSelectCategoryExerciseRow(at indexPath: IndexPath)
    
    // Value
    var listCategory: [Children] { get set }
    var listVideo: [VideoModel] { get set }
}

// MARK: - ListVideoExercise ViewModel
class CategoryVideoFitViewModel {
    weak var view: CategoryVideoFitViewProtocol?
    private var interactor: CategoryVideoFitInteractorInputProtocol
    
    init(interactor: CategoryVideoFitInteractorInputProtocol) {
        self.interactor = interactor
    }
    
    var listCategory: [Children] = []
    var listVideo: [VideoModel] = []
    
}

// MARK: - CategoryVideoFit ViewModelProtocol
extension CategoryVideoFitViewModel: CategoryVideoFitViewModelProtocol {
    func onViewDidLoad() {
        self.view?.showHud()
        self.interactor.getCategoryFit()
    }
    
    func numberOfListCategoryVideoExercise() -> Int {
        return self.listCategory.count
    }
    
    func numberOfListVideoExercise() -> Int {
        return self.listVideo.count
    }
    
    func listVideoExerciseCellForRow(at indexPath: IndexPath) -> VideoModel? {
        return self.listVideo[indexPath.row]
    }
    
    func listCategoryExerciseCellForRow(at indexPath: IndexPath) -> Children? {
        return self.listCategory[indexPath.row]
    }
    
    func didSelectCategoryExerciseRow(at indexPath: IndexPath) {
        guard let categoryId = self.listCategory[indexPath.row].id else {
            return
        }
        self.view?.showHud()
        self.interactor.getVideoFit(categoryId: categoryId, page: 1)
    }
}

// MARK: - CategoryVideoFit InteractorOutputProtocol
extension CategoryVideoFitViewModel: CategoryVideoFitInteractorOutputProtocol {
    func onGetVideoFitFinished(with result: Result<[VideoModel], APIError>, totalPages: Int) {
        switch result {
        case .success(let model):
            self.listVideo = model
            self.view?.onReloadVideoFit()
            
        case .failure(let error):
            debugPrint(error)
        }
        self.view?.hideHud()
    }
    
    func onGetCategoryFitFinished(with result: Result<CategoriesModel, APIError>) {
        switch result {
        case .success(let model):
            if let listCategoires = model.children {
                self.listCategory = listCategoires
                self.view?.onReloadDataCategory()
                if let categoryId = self.listCategory.first?.id {
                    self.interactor.getVideoFit(categoryId: categoryId, page: 1)
                }
            }
            
        case .failure(let error):
            debugPrint(error)
        }
        self.view?.hideHud()
    }
}
