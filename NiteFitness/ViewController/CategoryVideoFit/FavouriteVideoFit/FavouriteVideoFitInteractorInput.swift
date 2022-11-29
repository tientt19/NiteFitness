//
//  
//  FavouriteVideoFitInteractorInput.swift
//  1SK
//
//  Created by Thaad on 08/07/2022.
//
//

import UIKit

// MARK: - Interactor Input Protocol
protocol FavouriteVideoFitInteractorInputProtocol {
    func getVideoFavorite()
    func setRemoveFavorite(videoId: Int)
}

// MARK: - Interactor Output Protocol
protocol FavouriteVideoFitInteractorOutputProtocol: AnyObject {
    func onGetVideoFavoriteFinished(with result: Result<[VideoModel], APIError>)
    func onSetRemoveFavoriteFinished(with result: Result<EmptyModel, APIError>, videoId: Int)
}

// MARK: - FavouriteVideoFit InteractorInput
class FavouriteVideoFitInteractorInput {
    weak var output: FavouriteVideoFitInteractorOutputProtocol?
    var fitVideoSevice: FitVideoSeviceProtocol?
}

// MARK: - FavouriteVideoFit InteractorInputProtocol
extension FavouriteVideoFitInteractorInput: FavouriteVideoFitInteractorInputProtocol {
    func getVideoFavorite() {
        self.fitVideoSevice?.getVideoFavorite(completion: { [weak self] result in
            self?.output?.onGetVideoFavoriteFinished(with: result.unwrapSuccessModel())
        })
    }
    
    func setRemoveFavorite(videoId: Int) {
        self.fitVideoSevice?.setRemoveFavorite(videoId: videoId, completion: { [weak self] result in
            self?.output?.onSetRemoveFavoriteFinished(with: result.unwrapSuccessModel(), videoId: videoId)
        })
    }
}
