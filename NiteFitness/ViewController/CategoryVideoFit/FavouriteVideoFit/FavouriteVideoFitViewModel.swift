//
//  
//  FavouriteVideoFitViewModel.swift
//  1SK
//
//  Created by Thaad on 08/07/2022.
//
//

import UIKit

// MARK: - ViewModelProtocol
protocol FavouriteVideoFitViewModelProtocol {
    func onViewDidLoad()
    func onViewWillAppear()
    func onFavoriteAction(indexPath: IndexPath?)
    
    // UITableView
    func numberOfRows() -> Int
    func cellForRow(at indexPath: IndexPath) -> VideoModel?
    func didSelectRow(at indexPath: IndexPath)
    
    var listVideo: [VideoModel] { get set }
}

// MARK: - FavouriteVideoFit ViewModel
class FavouriteVideoFitViewModel {
    weak var view: FavouriteVideoFitViewProtocol?
    private var interactor: FavouriteVideoFitInteractorInputProtocol

    init(interactor: FavouriteVideoFitInteractorInputProtocol) {
        self.interactor = interactor
    }

    var listVideo: [VideoModel] = []
    
    func getInitData() {
        self.view?.showHud()
        self.interactor.getVideoFavorite()
    }
}

// MARK: - FavouriteVideoFit ViewModelProtocol
extension FavouriteVideoFitViewModel: FavouriteVideoFitViewModelProtocol {
    func onViewDidLoad() {
        //
    }
    
    func onViewWillAppear() {
        self.getInitData()
    }
    
    func onFavoriteAction(indexPath: IndexPath?) {
        guard let index = indexPath?.row else { return }
        guard let videoId = self.listVideo[index].id else { return }
        
        self.view?.showHud()
        self.interactor.setRemoveFavorite(videoId: videoId)
    }
    
    // TableView
    func numberOfRows() -> Int {
        return self.listVideo.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> VideoModel? {
        return self.listVideo[indexPath.row]
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        //
    }
}

// MARK: - FavouriteVideoFit InteractorOutputProtocol
extension FavouriteVideoFitViewModel: FavouriteVideoFitInteractorOutputProtocol {
    func onGetVideoFavoriteFinished(with result: Result<[VideoModel], APIError>) {
        switch result {
        case .success(let model):
            self.listVideo = model
            self.view?.onReloadData()
            
        case .failure(let error):
            debugPrint(error)
        }
        self.view?.hideHud()
    }
    
    func onSetRemoveFavoriteFinished(with result: Result<EmptyModel, APIError>, videoId: Int) {
        switch result {
        case .success:
            guard let index = self.listVideo.firstIndex(where: {$0.id == videoId}) else {
                return
            }
            self.listVideo.remove(at: index)
            self.view?.onReloadData()
            
        case .failure(let error):
            debugPrint(error)
        }
        self.view?.hideHud()
    }
}
