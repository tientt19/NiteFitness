//
//  
//  VideoFitDetailPlayerViewModel.swift
//  1SK
//
//  Created by Valerian on 28/06/2022.
//
//

import UIKit

// MARK: - ViewModelProtocol
protocol VideoFitDetailPlayerViewModelProtocol {
    func onViewDidLoad()
    
    func onFavoriteAction()
    func onShareAction()
    func onFormatTimeToInt(with startAt: String) -> Int
    func onSaveLastSeen(with lastTime: String)
    
    // UICollectionView Segments
    func numberOfItemsSegment() -> Int
    func cellForItemSegment(at indexPath: IndexPath) -> SegmentVideo?
    func didSelectItemSegment(at indexPath: IndexPath)
    
    // UICollectionView Related
    func numberOfItemsRelated() -> Int
    func cellForItemRelated(at indexPath: IndexPath) -> VideoModel?
    func didSelectItemRelated(at indexPath: IndexPath)
    
    // Value
    var video: VideoModel? { get set }
    var listRelatedVideo: [VideoModel]? { get set }
}

// MARK: - VideoExerciseDetail ViewModel
class VideoFitDetailPlayerViewModel {
    weak var view: VideoFitDetailPlayerViewProtocol?
    private var interactor: VideoFitDetailPlayerInteractorInputProtocol
    
    init(interactor: VideoFitDetailPlayerInteractorInputProtocol) {
        self.interactor = interactor
    }
    
    var video: VideoModel?
    var listRelatedVideo: [VideoModel]?
    
    private func getIntVideoData(video: VideoModel?) {
        self.view?.showHud()
        if let id = video?.id {
            self.interactor.getVideoDetail(videoId: id)
            
        } else {
            SKToast.shared.showToast(content: "Video này bị lỗi")
        }
        
        if let videoId = self.video?.id, let categoryId = self.video?.category?.id {
            self.interactor.getRelatedVideo(videoId: videoId, categoryId: categoryId)
        }
    }
}

// MARK: - VideoExerciseDetail ViewModelProtocol
extension VideoFitDetailPlayerViewModel: VideoFitDetailPlayerViewModelProtocol {
    func onViewDidLoad() {
        self.getIntVideoData(video: self.video)
        
    }
    
    // UICollectionView Segment
    func numberOfItemsSegment() -> Int {
        return self.video?.segments?.count ?? 0
    }
    
    func cellForItemSegment(at indexPath: IndexPath) -> SegmentVideo? {
        if self.video?.segments?.count ?? 0 > 0 {
            return self.video?.segments?[indexPath.row]
            
        } else {
            return nil
        }
    }
    
    func didSelectItemSegment(at indexPath: IndexPath) {
        //
    }
    
    // UICollectionView Related
    func numberOfItemsRelated() -> Int {
        return self.listRelatedVideo?.count ?? 0
    }
    
    func cellForItemRelated(at indexPath: IndexPath) -> VideoModel? {
        return self.listRelatedVideo?[indexPath.row]
    }
    
    func didSelectItemRelated(at indexPath: IndexPath) {
        guard let _video = self.listRelatedVideo?[indexPath.row] else {
            return
        }
        self.getIntVideoData(video: _video)
    }
    
    // Action
    func onFavoriteAction() {
        guard let videoId = self.video?.id else { return }
        
        if self.video?.isLiked == true {
            self.view?.showHud()
            self.interactor.setRemoveVideoFavorite(videoId: videoId)
            
        } else {
            self.view?.showHud()
            self.interactor.setAddVideoFavorite(videoId: videoId)
        }
    }
    
    func onShareAction() {
        guard let slug = self.video?.slug else {
            SKToast.shared.showToast(content: "Không thể chia sẻ video này")
            return
        }
        
        self.view?.showHud()
        let meta = MetaSocialShare()
        meta.socialMetaTitle = self.video?.name
        meta.socialMetaDescText = self.video?.description
        meta.socialMetaImageURL = self.video?.image
        
        let universalLink = "\(SHARE_URL)\(slug)\(ShareType.video.rawValue)"
        
        if let linkBuilder = DynamicLinksManager.shared.createDynamicLinksShare(meta: meta, universalLink: universalLink) {
            linkBuilder.shorten(completion: { url, warnings, error in
                self.view?.hideHud()
                
                if let listWarning = warnings {
                    for (index, warning) in listWarning.enumerated() {
                        print("createLinkShareFitnessPost warning: \(index) - \(warning)")
                    }
                }

                if let err = error {
                    SKToast.shared.showToast(content: "Chức năng chưa hoạt động")
                    print("createLinkShareFitnessPost error: \(err.localizedDescription)")
                    return
                }

                guard let urlShare = url else {
                    SKToast.shared.showToast(content: "Chức năng chưa hoạt động")
                    print("createLinkShareFitnessPost url: nil")
                    return
                }
                
                guard let shareView = self.view?.getShareView() else {
                    return
                }
                self.view?.showShareViewController(shareItem: [urlShare], sourceView: shareView)
                
                print("createLinkShareFitnessPost The short URL is: \(urlShare)")
            })
            
        } else {
            self.view?.hideHud()
            SKToast.shared.showToast(content: "Chức năng chưa hoạt động")
        }
    }
    
    func onFormatTimeToInt(with startAt: String) -> Int {
        
        // tinh theo gio ???
        
        let abc = startAt.replacingOccurrences(of: ":", with: " ")
        
        if let range = abc.range(of: " ") {
            let firstPart = abc[abc.startIndex..<range.lowerBound]
            
            let minute = firstPart
            let minuteFormat = Int(String(minute)) ?? 0

            let secondString = abc.replacingOccurrences(of: firstPart, with: "")
            let secondFormat = secondString.replacingOccurrences(of: " ", with: "")

            let second = Int(secondFormat) ?? 0
            return (minuteFormat * 60) + second
        } else {
            return 0
        }
    }
    
    func onSaveLastSeen(with lastTime: String) {
        guard Configure.shared.isLogged() == true else {
            return
        }
        guard let videoId = self.video?.id else {
            return
        }
        self.interactor.setTimeLastSeenVideo(videoId: videoId, lastTime: lastTime)
    }
}

// MARK: - VideoExerciseDetail InteractorOutputProtocol
extension VideoFitDetailPlayerViewModel: VideoFitDetailPlayerInteractorOutputProtocol {
    func onGetVideoDetailFinished(with result: Result<VideoModel, APIError>) {
        switch result {
        case .success(let model):
            self.video = model
            self.view?.setDataViewUI(video: self.video)
            self.view?.setFavoriteStateUI()
            self.view?.setPlayVideo(video: self.video)
            
        case .failure(let error):
            debugPrint(error)
        }
        self.view?.hideHud()
    }
    
    func onSetAddVideoFavoriteFinished(with result: Result<EmptyModel, APIError>) {
        switch result {
        case .success:
            self.video?.isLiked = true
            self.view?.setFavoriteStateUI()
            
        case .failure(let error):
            debugPrint(error)
        }
        self.view?.hideHud()
    }
    
    func onSetRemoveVideoFavoriteFinished(with result: Result<EmptyModel, APIError>) {
        switch result {
        case .success:
            self.video?.isLiked = false
            self.view?.setFavoriteStateUI()
            
        case .failure(let error):
            debugPrint(error)
        }
        self.view?.hideHud()
    }
    
    func onGetRelatedVideoFinished(with result: Result<[VideoModel], APIError>) {
        switch result {
        case .success(let model):
            self.listRelatedVideo = model
            self.view?.onReloadDataRelated()
            
        case .failure(let error):
            debugPrint(error)
        }
    }
    
    func onSetTimeLastSeenVideoFinished(with result: Result<EmptyModel, APIError>) {
        switch result {
        case .success:
            break
            
        case .failure(let error):
            debugPrint(error)
        }
    }
}
