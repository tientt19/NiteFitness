//
//  
//  HealthyCategoryViewModel.swift
//  1SK
//
//  Created by TrungDN on 16/09/2022.
//
//

import UIKit

// MARK: - ViewModelProtocol
protocol HealthyCategoryViewModelProtocol {
    func onViewDidLoad()
    
    func onRefreshAction()
    func onLoadMoreAction()
    var filterTypeValue: HealthyLivingFilterType { get }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> PostHealthModel
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    func onGetListPopularPosts() -> [PostHealthModel]
}

// MARK: - HealthyCategory ViewModel
class HealthyCategoryViewModel {
    weak var view: HealthyCategoryViewProtocol?
    private var interactor: HealthyCategoryInteractorInputProtocol
    
    private var filterType: HealthyLivingFilterType!
    
    // Loadmore
    private var total = 0
    private var page = 1
    private let perPage = 10
    private var isOutOfData = false
    
    private var HealthyModels: [PostHealthModel] = []
    private var HealthyPopularPosts: [PostHealthModel] = []

    init(interactor: HealthyCategoryInteractorInputProtocol, filterType: HealthyLivingFilterType) {
        self.filterType = filterType
        self.interactor = interactor
    }

    func getData(page: Int) {
        self.view?.showHud()
        
        if page == 1 {
            self.isOutOfData = false
        }
    
        self.interactor.getHealthyPosts(of: self.filterType, page: page, perPage: self.perPage)
    }
}

// MARK: - HealthyCategory ViewModelProtocol
extension HealthyCategoryViewModel: HealthyCategoryViewModelProtocol {

    
    var filterTypeValue: HealthyLivingFilterType {
        return self.filterType
    }
    
    func onViewDidLoad() {
        self.view?.showHud()
        
        if self.filterType == .all {
            self.interactor.getHealthyPopularPosts()
        }
        
        self.getData(page: 1)
    }
    
    func onRefreshAction() {
        self.page = 1
        self.getData(page: self.page)
    }
    
    func onLoadMoreAction() {
        if self.HealthyModels.count >= self.perPage && !self.isOutOfData {
            self.getData(page: self.page + 1)
            
        } else {
            SKToast.shared.showToast(content: "Đã tải hết dữ liệu")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.HealthyModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> PostHealthModel {
        return self.HealthyModels[indexPath.item]
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
    
    func onGetListPopularPosts() -> [PostHealthModel] {
        return self.HealthyPopularPosts
    }
}

// MARK: - HealthyCategory InteractorOutputProtocol
extension HealthyCategoryViewModel: HealthyCategoryInteractorOutputProtocol {
    func onGetHealthyPostFinished(with result: Result<[PostHealthModel], APIError>, page: Int) {
        switch result {
        case .success(let model):
            if page <= 1 {
                self.HealthyModels = model
                self.view?.onReloadData()
            } else {
                for object in model {
                    self.HealthyModels.append(object)
                    self.view?.onInsertRow(at: self.HealthyModels.count - 1)
                }
            }
            
            self.page = page
            
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.view?.onLoadingSuccess()
            }
                        
        case .failure(let error):
            print(error.statusCode)
            if error.statusCode == 400 {
                self.isOutOfData = true
                SKToast.shared.showToast(content: "Đã tải hết dữ liệu")
                
            } else {
                SKToast.shared.showToast(content: error.message)
            }
        }

        self.view?.hideHud()
    }
    
    func onGetHealthyPopularPostsFinished(with result: Result<[PostHealthModel], APIError>) {
        switch result {
        case .success(let model):
            self.HealthyPopularPosts = model

        case .failure(let error):
            print(error.statusCode)
            if error.statusCode == 400 {
                self.isOutOfData = true
                SKToast.shared.showToast(content: "Đã tải hết dữ liệu")
                
            } else {
                SKToast.shared.showToast(content: error.message)
            }
        }
        
        self.view?.hideHud()
    }
}
