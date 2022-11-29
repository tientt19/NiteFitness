//
//  
//  VideoFitDetailPlayerInteractorInput.swift
//  1SK
//
//  Created by Valerian on 28/06/2022.
//
//

import UIKit

// MARK: - Interactor Input Protocol
protocol VideoFitDetailPlayerInteractorInputProtocol {
    func getVideoDetail(videoId: Int)
    
    func setAddVideoFavorite(videoId: Int)
    func setRemoveVideoFavorite(videoId: Int)
    func getRelatedVideo(videoId: Int, categoryId: Int)
    func setTimeLastSeenVideo(videoId: Int, lastTime: String)
    
}

// MARK: - Interactor Output Protocol
protocol VideoFitDetailPlayerInteractorOutputProtocol: AnyObject {
    func onGetVideoDetailFinished(with result: Result<VideoModel, APIError>)
    
    func onSetAddVideoFavoriteFinished(with result: Result<EmptyModel, APIError>)
    func onSetRemoveVideoFavoriteFinished(with result: Result<EmptyModel, APIError>)
    
    func onGetRelatedVideoFinished(with result: Result<[VideoModel], APIError>)
    func onSetTimeLastSeenVideoFinished(with result: Result<EmptyModel, APIError>)
    
}

// MARK: - VideoExerciseDetail InteractorInput
class VideoFitDetailPlayerInteractorInput {
    weak var output: VideoFitDetailPlayerInteractorOutputProtocol?
    var fitVideoSevice: FitVideoSeviceProtocol?
}

// MARK: - VideoExerciseDetail InteractorInputProtocol
extension VideoFitDetailPlayerInteractorInput: VideoFitDetailPlayerInteractorInputProtocol {
    func getVideoDetail(videoId: Int) {
        self.fitVideoSevice?.getVideoDetail(videoId: videoId, completion: { [weak self] result in
            self?.output?.onGetVideoDetailFinished(with: result.unwrapSuccessModel())
        })
    }
    
    func setAddVideoFavorite(videoId: Int) {
        self.fitVideoSevice?.setAddFavorite(videoId: videoId, completion: { [weak self] result in
            self?.output?.onSetAddVideoFavoriteFinished(with: result.unwrapSuccessModel())
        })
    }
    
    func setRemoveVideoFavorite(videoId: Int) {
        self.fitVideoSevice?.setRemoveFavorite(videoId: videoId, completion: { [weak self] result in
            self?.output?.onSetRemoveVideoFavoriteFinished(with: result.unwrapSuccessModel())
        })
    }
    
    func getRelatedVideo(videoId: Int, categoryId: Int) {
        self.fitVideoSevice?.getRelatedVideo(videoId: videoId, categoryId: categoryId, completion: { [weak self] result in
            self?.output?.onGetRelatedVideoFinished(with: result.unwrapSuccessModel())
        })
    }
    
    func setTimeLastSeenVideo(videoId: Int, lastTime: String) {
        self.fitVideoSevice?.setTimeLastSeenVideo(videoId: videoId, lastTime: lastTime, completion: { [weak self] result in
            self?.output?.onSetTimeLastSeenVideoFinished(with: result.unwrapSuccessModel())
        })
    }
}
