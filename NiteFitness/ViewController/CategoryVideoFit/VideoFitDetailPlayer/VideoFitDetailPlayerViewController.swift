//
//  
//  VideoExerciseDetailViewController.swift
//  1SK
//
//  Created by Valerian on 28/06/2022.
//
//

import UIKit
import AVFoundation

// MARK: - ViewProtocol
protocol VideoFitDetailPlayerViewProtocol: AnyObject {
    func showHud()
    func hideHud()
    func setFavoriteStateUI()
    func getShareView() -> UIView
    func showShareViewController(shareItem: [Any], sourceView: UIView)
    func onReloadDataRelated()
    func setVideoResolution(_ resolution: VideoResolution)
    func setDataViewUI(video: VideoModel?)
    func setPlayVideo(video: VideoModel?)
}

// MARK: - VideoExerciseDetail ViewController
class VideoFitDetailPlayerViewController: BaseViewController {
    var router: VideoFitDetailPlayerRouterProtocol!
    var viewModel: VideoFitDetailPlayerViewModelProtocol!

    @IBOutlet weak var scroll_ScrollView: UIScrollView!
    
    @IBOutlet weak var btn_Favorite: UIButton!
    @IBOutlet weak var btn_Share: UIButton!
    
    @IBOutlet weak var view_Player: UIView!
    @IBOutlet weak var view_Control: UIView!
    @IBOutlet weak var view_AVPlayerControl: UIView!
    
    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var coll_Segments: UICollectionView!
    
    @IBOutlet weak var lbl_Time: UILabel!
    @IBOutlet weak var lbl_Level: UILabel!
    @IBOutlet weak var lbl_Category: UILabel!
    @IBOutlet weak var lbl_Tool: UILabel!
    
    @IBOutlet weak var lbl_Desc: UILabel!
    
    @IBOutlet weak var view_CoachView: UIView!
    @IBOutlet weak var img_CoachAvatar: UIImageView!
    @IBOutlet weak var lbl_CoachName: UILabel!
    @IBOutlet weak var lbl_CoachDesc: UILabel!
    
    @IBOutlet weak var view_Related: UIView!
    @IBOutlet weak var coll_Related: UICollectionView!
    
    @IBOutlet weak var btn_ExpandCoachDesc: UIButton!
    
    var avPlayer: AVPlayer?
    var avPlayerLayer: AVPlayerLayer?
    var avControlView: AVPlayerControlView?
    var timerControl: Timer?
    var timeControlDuration: TimeInterval = 5
    var isPlayFullScreen = false
    var valueSliderChange: Float = 0
    var progressValue: CGFloat = 0
    var needHideLoad = true
    var lastSeenTime: String = ""
    
    var timePlaying: Double = 0 {
        didSet {
            self.controllerPlayVideoFullFitView?.timePlaying = self.timePlaying
        }
    }
    
    var controllerPlayVideoFullFitView: PlayVideoFullFitViewController?
    
    var isBackController = false
    var isExpand = false
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInit()
        self.viewModel.onViewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.isPlayFullScreen {
            self.view_Player.layer.addSublayer(self.avPlayerLayer!)
            self.view_AVPlayerControl.addSubview(self.avControlView!)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.isInteractivePopGestureEnable = false
        if self.isPlayFullScreen {
            self.avPlayerLayer?.frame = CGRect(x: 0, y: 0, width: self.view_Player.width, height: self.view_Player.height)
            self.avControlView?.frame = CGRect(x: 0, y: 0, width: self.view_AVPlayerControl.width, height: self.view_AVPlayerControl.height)
            
            self.isPlayFullScreen = false
        }
        
        self.avControlView?.setScreenSize(isPlayFull: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isBackController {
            self.viewModel.onSaveLastSeen(with: self.lastSeenTime)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.isInteractivePopGestureEnable = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.avPlayerLayer?.frame = self.view_Player.bounds
    }
    
    deinit {
        gIsShowMarketingPopup = false
    }
    
    // MARK: - Init
    private func setupInit() {
        gIsShowMarketingPopup = true
        self.setInitAVPlayerControlView()
        self.setInitUIGestureRecognizer()
        self.setIntUICollectionView()
    }
    
    func setInitAVPlayerControlView() {
        self.avControlView = AVPlayerControlView.loadFromNib()
        self.avControlView?.delegate = self
        self.avControlView?.frame = CGRect(x: 0, y: 0, width: self.view_AVPlayerControl.width, height: self.view_AVPlayerControl.height)
        self.view_AVPlayerControl.addSubview(self.avControlView!)
        
    }
    
    // MARK: - Action
    @IBAction func onBackAction(_ sender: UIButton) {
        self.isBackController = true
        
        self.navigationController?.popViewController(animated: true)
        self.setInvalidateTimeControl()
        self.setRemoveObserver()
    }
    
    @IBAction func onFavoriteAction(_ sender: UIButton) {
        self.viewModel.onFavoriteAction()
    }
    
    @IBAction func onShareAction(_ sender: UIButton) {
        self.viewModel.onShareAction()
    }
    
    @IBAction func onExpandCoachDescAction(_ sender: Any) {
        self.isExpand.toggle()
        if let coach = self.viewModel.video?.coach {
            self.lbl_CoachDesc.text = coach.description ?? ""
            self.lbl_CoachDesc.sizeToFit()
        }
        
        if isExpand {
            self.lbl_CoachDesc.numberOfLines = 0
            self.btn_ExpandCoachDesc.setTitle("Rút gọn", for: .normal)
            
        } else {
            self.lbl_CoachDesc.numberOfLines = 3
            self.btn_ExpandCoachDesc.setTitle("Xem thêm", for: .normal)
        }
    }
    
}

// MARK: - VideoExerciseDetail ViewProtocol
extension VideoFitDetailPlayerViewController: VideoFitDetailPlayerViewProtocol {
    func showHud() {
        self.showProgressHud()
    }
    
    func hideHud() {
        self.hideProgressHud()
    }
    
    func getShareView() -> UIView {
        return self.btn_Share
    }
    
    func setFavoriteStateUI() {
        if self.viewModel.video?.isLiked == true {
            self.btn_Favorite.setImage(R.image.ic_fit_likedVideo(), for: .normal)
            
        } else {
            self.btn_Favorite.setImage(R.image.ic_fit_likedButton(), for: .normal)
        }
    }
    
    func showShareViewController(shareItem: [Any], sourceView: UIView) {
        self.router.showShareViewController(with: shareItem, sourceView: sourceView)
    }
    
    func onReloadDataRelated() {
        self.coll_Related.reloadData()
        self.coll_Related.setContentOffset(.zero, animated: true)
        self.coll_Related.collectionViewLayout.invalidateLayout()
        
        if self.viewModel.numberOfItemsRelated() > 0 {
            self.view_Related.isHidden = false
        } else {
            self.view_Related.isHidden = true
        }
    }
    
    func setVideoResolution(_ resolution: VideoResolution) {
        switch resolution {
        case .auto:
            self.avPlayer?.currentItem?.preferredMaximumResolution = CGSize.zero
            
        case ._1080:
            self.avPlayer?.currentItem?.preferredMaximumResolution = CGSize(width: 1920, height: 1080)
            
        case ._720:
            self.avPlayer?.currentItem?.preferredMaximumResolution = CGSize(width: 1280, height: 720)
            
        case ._480:
            self.avPlayer?.currentItem?.preferredMaximumResolution = CGSize(width: 854, height: 480)
            
        case ._360:
            self.avPlayer?.currentItem?.preferredMaximumResolution = CGSize(width: 640, height: 360)
        }
    }
    
    func setDataViewUI(video: VideoModel?) {
        self.lbl_Title.text = video?.name ?? ""
        self.lbl_Desc.text = video?.description ?? ""
        
        self.lbl_Time.text = video?.duration?.toTimeInterval()?.toFullTimeString() ?? ""
        
        self.lbl_Level.text = ""
        self.lbl_Category.text = ""
        self.lbl_Tool.text = ""
        
        if let details = video?.details, details.count > 0 {
            details.enumerated().forEach { (index, detail) in
                switch index {
                case 0:
                    self.lbl_Level.text = detail.value?.name ?? ""
                    
                case 1:
                    self.lbl_Category.text = detail.value?.name ?? ""
                    
                case 2:
                    self.lbl_Tool.text = detail.value?.name ?? ""
                    
                default:
                    break
                }
            }
        }
        
        if let coach = video?.coach {
            self.img_CoachAvatar.setImageWith(imageUrl: coach.avatar ?? "", placeHolder: R.image.default_avatar_2())
            self.lbl_CoachName.text = coach.name ?? ""
            self.lbl_CoachDesc.text = coach.description ?? ""
            self.view_CoachView.isHidden = false
            
            if self.lbl_CoachDesc.isClipped == true {
                self.btn_ExpandCoachDesc.isHidden = false
                
            } else {
                self.btn_ExpandCoachDesc.isHidden = true
            }
            
//            print("lbl_CoachDesc isClipped: \(self.lbl_CoachDesc.isClipped)")
//            print("lbl_CoachDesc isTruncated: \(self.lbl_CoachDesc.isTruncated)")
            
        } else {
            self.view_CoachView.isHidden = true
        }
        
        if video?.segments?.count ?? 0 > 0 {
            self.coll_Segments.isHidden = false
            self.coll_Segments.reloadData()
            self.coll_Segments.collectionViewLayout.invalidateLayout()
            
        } else {
            self.coll_Segments.isHidden = true
        }
        
        self.scroll_ScrollView.setContentOffset(.zero, animated: true)
    }
    
    func setPlayVideo(video: VideoModel?) {
        self.setInitAVPlayer(videoUrl: video?.link ?? "")
    }
}

// MARK: - UICollectionViewDataSource
extension VideoFitDetailPlayerViewController: UICollectionViewDataSource {
    func setIntUICollectionView() {
        self.coll_Related.registerNib(ofType: CellCollectionViewVideoFit.self)
        self.coll_Segments.registerNib(ofType: CellCollectionViewVideoFit.self)
        
        self.coll_Related.delegate = self
        self.coll_Related.dataSource = self
        self.coll_Segments.delegate = self
        self.coll_Segments.dataSource = self
        
        let layoutVideoExercise = UICollectionViewFlowLayout()
        layoutVideoExercise.scrollDirection = .horizontal
        layoutVideoExercise.minimumLineSpacing = 16
        layoutVideoExercise.minimumInteritemSpacing = 16
        layoutVideoExercise.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layoutVideoExercise.itemSize = CGSize(width: 200, height: self.coll_Related.frame.height)
        self.coll_Related.collectionViewLayout = layoutVideoExercise
        
        let layoutVideoExerciseSegment = UICollectionViewFlowLayout()
        layoutVideoExerciseSegment.scrollDirection = .horizontal
        layoutVideoExerciseSegment.minimumLineSpacing = 16
        layoutVideoExerciseSegment.minimumInteritemSpacing = 16
        layoutVideoExerciseSegment.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layoutVideoExerciseSegment.itemSize = CGSize(width: 164, height: self.coll_Segments.frame.height)
        self.coll_Segments.collectionViewLayout = layoutVideoExerciseSegment
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case coll_Segments:
            return self.viewModel.numberOfItemsSegment()
            
        case coll_Related:
            return self.viewModel.numberOfItemsRelated()
            
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeuCell(ofType: CellCollectionViewVideoFit.self, for: indexPath)
        switch collectionView {
        case coll_Segments:
            cell.videoSegment = self.viewModel.cellForItemSegment(at: indexPath)
            
        case coll_Related:
            cell.videoRelated = self.viewModel.cellForItemRelated(at: indexPath)
            
        default:
            return cell
        }
        return cell
    }

}

// MARK: - UICollectionViewDelegate
extension VideoFitDetailPlayerViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case coll_Segments:
            if let startAt = self.viewModel.video?.segments?[indexPath.row].startAt {
                if let second = startAt.toTimeInterval() {
                    self.timePlaying = second
                    self.onSegmentVideoChanged(second: second)
                }
            }
            
        case coll_Related:
            self.lbl_CoachDesc.text = ""
            self.lbl_CoachDesc.numberOfLines = 3
            self.view_CoachView.isHidden = true
            
            self.viewModel.didSelectItemRelated(at: indexPath)
            
        default:
            break
        }
    }
}

// MARK: - AVPlayerControlViewDelegate
extension VideoFitDetailPlayerViewController: AVPlayerControlViewDelegate {
    func onPlayAction() {
        guard let avPlayer = self.avPlayer else {
            return
        }
        
        switch self.avControlView?.avState {
        case .readyToPlay:
            if avPlayer.isPlaying {
                self.onPause()
                
            } else {
                self.onPlay()
            }
            
        case .playedToTheEnd:
            self.onReplay()
            
        default:
            break
        }
    }
    
    func onSliderValueChangeAction(value: Float) {
        self.needHideLoad = true
        self.valueSliderChange = value
        
        self.avControlView?.avState = .loading
        self.avControlView?.ind_Loading.startAnimating()
        self.avControlView?.btn_Play.isHidden = true
        
        guard let duration = self.avPlayer?.currentItem?.asset.duration,
              let item = self.avPlayer?.currentItem else { return }
        
        let valueChanged = Double(self.avControlView?.slider_TimeTracking.value ?? 0) * duration.seconds
        let timeIntervalChanged = CMTime(seconds: valueChanged, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        self.timePlaying = valueChanged
        
        item.seek(to: timeIntervalChanged) { _ in
            if self.avPlayer?.isPlaying == true {
                self.avPlayer?.play()
            }
        }
    }
    
    func onSliderEventAction(event: SliderEvent) {
        switch event {
        case .began:
            self.avControlView?.avState = .seeking
            
        case .ended:
            self.setTimerViewControlHidden()
            
        default:
            break
        }
    }
    
    func onScreenSizeAction(isPlayFull: Bool) {
        if isPlayFull == true {
            self.controllerPlayVideoFullFitView?.navigationController?.popViewController(animated: true)
            self.controllerPlayVideoFullFitView = nil
            self.avControlView?.setScreenSize(isPlayFull: false)
            
        } else {
            self.showPlayVideoFullFitView()
            self.avControlView?.setScreenSize(isPlayFull: true)
        }
    }
}

// MARK: - PlayVideoFullViewDelegate
extension VideoFitDetailPlayerViewController: PlayVideoFullFitViewDelegate {
    func showPlayVideoFullFitView() {
        self.isPlayFullScreen = true
        
        self.controllerPlayVideoFullFitView = PlayVideoFullFitViewController()
        self.controllerPlayVideoFullFitView?.delegate = self
        self.controllerPlayVideoFullFitView?.video = self.viewModel.video
        self.controllerPlayVideoFullFitView?.avPlayer = self.avPlayer
        self.controllerPlayVideoFullFitView?.avPlayerLayer = self.avPlayerLayer
        self.controllerPlayVideoFullFitView?.avControlView = self.avControlView
        self.controllerPlayVideoFullFitView?.resolution = .auto
        
        self.navigationController?.show(self.controllerPlayVideoFullFitView!, sender: nil)
        
        self.view_Control.alpha = 0
        self.view_Control.isHidden = true
    }
    
    func setVideoSegment(second: Double) {
        self.timePlaying = second
        self.onSegmentVideoChanged(second: second)
    }
    
    func setResolutionFullVideo(_ resolution: VideoResolution) {
        self.setVideoResolution(resolution)
    }
}

// MARK: UIGestureRecognizer
extension VideoFitDetailPlayerViewController {
    func setInitUIGestureRecognizer() {
        self.view_Player.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onTapViewPlayerAction)))
        self.view_Control.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onTapViewControlAction)))
        
        self.setViewControlShow()
    }
    
    @objc func onTapViewPlayerAction() {
        self.setViewControlShow()
    }
    
    @objc func onTapViewControlAction() {
        self.timeControlDuration = 5
    }
    
    func setViewControlShow() {
        if self.view_Control.isHidden == true {
            self.view_Control.isHidden = false
            UIView.animate(withDuration: 0.5) {
                self.view_Control.alpha = 1
                self.view.layoutIfNeeded()
            }
        }
        
        self.setTimerViewControlHidden()
    }
    
    func setViewControlHidden() {
        if self.avControlView?.avState == .readyToPlay && self.avControlView?.avRate == .isPlay {
            UIView.animate(withDuration: 1.0) {
                self.view_Control.alpha = 0
                self.view.layoutIfNeeded()

            } completion: { _ in
                self.view_Control.isHidden = true
            }
        }
    }
}
