//
//  
//  HomeHealthyViewModel.swift
//  1SK
//
//  Created by TrungDN on 16/09/2022.
//
//

import UIKit

// MARK: - ViewModelProtocol
protocol HomeHealthyViewModelProtocol {
    func onViewDidLoad()
    
    // collection view
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> String
}

// MARK: - HomeHealthy ViewModel
class HomeHealthyViewModel {
    weak var view: HomeHealthyViewProtocol?
    private var interactor: HomeHealthyInteractorInputProtocol

    private var currentFilterType: HealthyLivingFilterType = .all
    
    init(interactor: HomeHealthyInteractorInputProtocol) {
        self.interactor = interactor
    }
    
}

// MARK: - HomeHealthy ViewModelProtocol
extension HomeHealthyViewModel: HomeHealthyViewModelProtocol {
    func onViewDidLoad() {
        self.view?.updateView(with: .all)
    }
    
    // MARK: -- CollectionView
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        if self.currentFilterType == HealthyLivingFilterType.getMenuItems()[indexPath.item] {
            return
        }
        self.currentFilterType = HealthyLivingFilterType.getMenuItems()[indexPath.item]
        self.view?.updateView(with: self.currentFilterType)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HealthyLivingFilterType.getMenuItems().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> String {
        return HealthyLivingFilterType.getMenuItems()[indexPath.item].description
    }
}

// MARK: - HomeHealthy InteractorOutputProtocol
extension HomeHealthyViewModel: HomeHealthyInteractorOutputProtocol {
    
}

// MARK: HealthyLivingFilterType
enum HealthyLivingFilterType: Int, CaseIterable {
    case all = 0
//    case exercise = 94
    case nutrition = 95
    case mentalhealth = 96
    case technology = 97
    
    var description: String {
        switch self {
        case .all:
            return "Tất cả"
            
//        case .exercise:
//            return "Thể dục"
//
        case .nutrition:
            return "Dinh dưỡng"
            
        case .mentalhealth:
            return "Sức khỏe tinh thần"
            
        case .technology:
            return "Công nghệ"
        }
    }
    
    var typeId: Int {
        switch self {
        case .all:
            return 0
//
//        case .exercise:
//            return 94
            
        case .nutrition:
            return 95
            
        case .mentalhealth:
            return 96
            
        case .technology:
            return 97
        }
    }
    
    static func getMenuItems() -> [HealthyLivingFilterType] {
        return [.all, .nutrition, .mentalhealth, .technology]
    }
}
