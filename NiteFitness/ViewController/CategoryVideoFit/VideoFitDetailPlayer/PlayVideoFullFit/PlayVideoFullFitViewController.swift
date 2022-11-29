//
//  PlayVideoFullFitViewController.swift
//  1SK
//
//  Created by vuongbachthu on 9/4/21.
//

import UIKit
import AVFoundation

protocol PlayVideoFullFitViewDelegate: AnyObject {
    func setResolutionFullVideo(_ resolution: VideoResolution)
    func setVideoSegment(second: Double)
}

class PlayVideoFullFitViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var view_Player: UIView!
    @IBOutlet weak var view_Control: UIView!
    @IBOutlet weak var view_AVPlayerControl: UIView!
    @IBOutlet weak var stack_Setting: UIStackView!
    @IBOutlet weak var btn_Share: UIButton!
    @IBOutlet weak var btn_Setting: UIButton!
    @IBOutlet weak var lbl_Title: UILabel!
    
    weak var delegate: PlayVideoFullFitViewDelegate?
    
    var video: VideoModel?
    var avPlayer: AVPlayer?
    var avPlayerLayer: AVPlayerLayer?
    var avControlView: AVPlayerControlView?
    var timerControl: Timer?
    var timeControlDuration: TimeInterval = 5
    var resolution: VideoResolution?
    var timePlaying: Double = 0
    var valueSliderChange: Float = 0
    var needHideLoad = true

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInit()
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.landscapeRight, andRotateTo: UIInterfaceOrientation.landscapeRight)
    }

    override func viewWillDisappear(_ animated: Bool) {
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.avPlayerLayer?.frame = self.view_Player.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    
    // MARK: - Setup
    private func setupInit() {
        self.setInitAVPlayerControlView()
        self.setInitAVPlayer()
        self.setInitUIGestureRecognizer()
        self.setInitData()
    }
    
    func setInitAVPlayerControlView() {
        self.avControlView?.frame = CGRect(x: 0, y: 0, width: self.view_AVPlayerControl.width, height: self.view_AVPlayerControl.height)
        self.view_AVPlayerControl.addSubview(self.avControlView!)
    }
    
    func setInitAVPlayer() {
        self.view_Player.layer.addSublayer(self.avPlayerLayer!)
        self.avPlayerLayer?.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    func setInitData() {
        self.lbl_Title.text = self.video?.name
        if self.video?.segments?.count ?? 0 > 0 {
            self.btn_Share.isHidden = false
        } else {
            self.btn_Share.isHidden = true
        }
    }
    
    func onPlay() {
        self.avPlayer?.play()
        self.avControlView?.btn_Play.setImage(R.image.ic_fit_pause(), for: .normal)
    }

    func onPause() {
        self.avPlayer?.pause()
        self.avControlView?.btn_Play.setImage(R.image.ic_fit_play(), for: .normal)
    }
    
    func onReplay() {
        self.avPlayer?.seek(to: CMTime.zero)
        self.onPlay()
    }

    // MARK: - Action
    
    @IBAction func onBackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onSegmentSettingAction(_ sender: UIButton) {
        self.presentVideoSegmentSettingView()
    }
    
    @IBAction func onQualitySettingAction(_ sender: UIButton) {
        self.presentVideoResolutionSettingView()
    }
}

//MARK: - VideoSegmentSettingViewDelegate
extension PlayVideoFullFitViewController: VideoSegmentSettingViewDelegate {
    func presentVideoSegmentSettingView() {
        self.onPause()
        
        let controller = VideoSegmentSettingViewController()
        controller.video = self.video
        controller.timePlaying = self.timePlaying
        controller.delegate = self
        controller.modalPresentationStyle = .custom
        self.present(controller, animated: false, completion: nil)
    }
    
    func onSegmentSelected(second: Double) {
        self.timePlaying = second
        self.delegate?.setVideoSegment(second: second)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.onPlay()
        }
    }
    
    func onDismissSegment() {
        self.onPlay()
    }
}

//MARK: - VideoResolutionSettingViewDelegate
extension PlayVideoFullFitViewController: VideoResolutionSettingViewDelegate {
    func presentVideoResolutionSettingView() {
        self.onPause()
        
        let controller = VideoResolutionSettingViewController()
        controller.video = self.video
        controller.delegate = self
        controller.currentVideoResolution = self.resolution ?? .auto
        controller.modalPresentationStyle = .custom
        self.present(controller, animated: false, completion: nil)
    }
    
    func onResolutionSelected(index: Int) {
        let selectedResolution = VideoResolution.allCases[index]
        if selectedResolution == self.resolution {
            self.onPlay()
            
        } else {
            self.resolution = selectedResolution
            self.delegate?.setResolutionFullVideo(selectedResolution)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.onPlay()
            }
        }
    }
    
    func onDismissResolution() {
        self.onPlay()
    }
}

// MARK: UIGestureRecognizer
extension PlayVideoFullFitViewController {
    func setInitUIGestureRecognizer() {
        self.view_Player.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onTapViewPlayerAction)))
        self.view_Control.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onTapViewControlAction)))
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.onActionPlayControl), name: .onActionPlayControl, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.onActionLoading), name: .onActionLoading, object: nil)
        
        self.setViewControlShow()
    }
    
    @objc func onActionPlayControl() {
        self.setTimerViewControlHidden()
    }
    
    @objc func onActionLoading() {
        self.self.setViewControlShow()
    }
    
    @objc func onTapViewPlayerAction() {
        self.setViewControlShow()
    }
    
    @objc func onTapViewControlAction() {
        self.timeControlDuration = 3
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

// MARK: Timer Control
extension PlayVideoFullFitViewController {
    func setTimerViewControlHidden() {
        if self.timerControl == nil {
            self.timeControlDuration = 5
            self.timerControl = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.onTimeControlDidChange), userInfo: nil, repeats: true)
            
        } else {
            self.timeControlDuration = 3
        }
    }
    
    @objc func onTimeControlDidChange() {
        if self.timeControlDuration > 1 {
            self.timeControlDuration -= 1
            
        } else {
            self.setInvalidateTimeControl()
            self.setViewControlHidden()
        }
    }
    
    func setInvalidateTimeControl() {
        self.timerControl?.invalidate()
        self.timerControl = nil
    }
}
