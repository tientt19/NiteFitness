//
//  VideoFitDetailPlayer+Extension.swift
//  1SK
//
//  Created by Thaad on 11/07/2022.
//

import Foundation
import UIKit
import AVFoundation

// MARK: AVPlayer Video
extension VideoFitDetailPlayerViewController {
    func setInitAVPlayer(videoUrl: String) {
        print("videoUrl:", videoUrl)
        
        guard let url = URL(string: videoUrl) else {
            self.alertDefault(title: "Error Video URL", message: videoUrl)
            return
        }
        
        if self.avPlayer == nil {
            self.preparelayVideoWithFisrt(url: url)
            
        } else {
            self.preparePlayVideoNext(url: url)
        }
    }
    
    func preparelayVideoWithFisrt(url: URL) {
        let avPlayerItem = AVPlayerItem(url: url)
        self.avPlayer = AVPlayer(playerItem: avPlayerItem)
        
        self.avPlayerLayer = AVPlayerLayer(player: self.avPlayer)
        self.avPlayerLayer?.frame = CGRect(x: 0, y: 0, width: self.view_Player.width, height: self.view_Player.height)
        self.avPlayerLayer?.videoGravity = .resizeAspect
        self.view_Player.layer.addSublayer(self.avPlayerLayer!)
        
        self.onAddObserverCurrentItem()
        self.onAddObserverKVOPlayer()
        
        self.avPlayer?.play()
    }
    
    func preparePlayVideoNext(url: URL) {
        let avPlayerItem = AVPlayerItem(url: url)
        self.avPlayer?.replaceCurrentItem(with: avPlayerItem)
        
        self.onAddObserverCurrentItem()
        self.onResetViewControl()
        self.setViewControlShow()
        
        self.avPlayer?.play()
    }
    
    func onResetViewControl() {
        self.avControlView?.avState = .loading
        self.avControlView?.ind_Loading.startAnimating()
        self.avControlView?.slider_TimeTracking.setValue(0, animated: true)
        self.avControlView?.btn_Play.isHidden = true
    }
    
    func onSegmentVideoChanged(second: Double) {
        guard let durationCMTimeFormat = self.avPlayer?.currentItem?.asset.duration else {
            return
        }
                
        let duration = CMTimeGetSeconds(durationCMTimeFormat).rounded(toPlaces: 1)
        let sliderValue = Float(second / Double(duration))
        self.avControlView?.slider_TimeTracking.setValue(sliderValue, animated: true)
        self.onSliderValueChangeAction(value: sliderValue)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.onPlay()
        }
    }
    
    func resetTimeLine(value: Int) {
        guard let durationCMTimeFormat = self.avPlayer?.currentItem?.asset.duration else {
            return
        }
        
        let duration = CMTimeGetSeconds(durationCMTimeFormat).rounded(toPlaces: 1)
        let sliderValue = Float(Double(value) / Double(duration))
        self.avControlView?.slider_TimeTracking.setValue(sliderValue, animated: true)
        
        self.onSliderValueChangeAction(value: sliderValue)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.onPlay()
        }
    }
}


// MARK: - Player Handler Control
extension VideoFitDetailPlayerViewController {
    func onPlay() {
        self.avPlayer?.play()
        self.avControlView?.btn_Play.setImage(R.image.ic_fit_pause(), for: .normal)
        NotificationCenter.default.post(name: .onActionPlayControl, object: nil)
        self.setViewControlShow()
    }
    
    func onPause() {
        self.avPlayer?.pause()
        self.avControlView?.btn_Play.setImage(R.image.ic_fit_play(), for: .normal)
    }
    
    func onReplay() {
        self.resetTimeLine(value: 0)
        self.avPlayer?.seek(to: CMTime.zero)
        self.onPlay()
    }
}

// MARK: Timer Control
extension VideoFitDetailPlayerViewController {
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
// MARK: KVO Observer
extension VideoFitDetailPlayerViewController {
    func onAddObserverKVOPlayer() {
        self.avPlayer?.addObserver(self, forKeyPath: AVConstant.rate, options: [.old, .new], context: nil)
        
        self.onTimeObserver()
    }
    
    func setRemoveObserver() {
        self.avPlayer?.currentItem?.removeObserver(self, forKeyPath: #keyPath(AVPlayerItem.status), context: nil)
        self.avPlayer?.currentItem?.removeObserver(self, forKeyPath: AVConstant.loadedTimeRangesKey, context: nil)
        self.avPlayer?.removeObserver(self, forKeyPath: AVConstant.rate, context: nil)
    }
    
    func onAddObserverCurrentItem() {
        self.avPlayer?.currentItem?.addObserver(self, forKeyPath: #keyPath(AVPlayerItem.status), options: [.initial, .new], context: nil)
        self.avPlayer?.currentItem?.addObserver(self, forKeyPath: AVConstant.loadedTimeRangesKey, options: [.initial, .new], context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        
        switch keyPath {
        case #keyPath(AVPlayerItem.status):
            var status: AVPlayerItem.Status = .unknown
            if let statusNumber = change?[.newKey] as? NSNumber,
                let newStatus = AVPlayerItem.Status(rawValue: statusNumber.intValue) {
                status = newStatus
            }
            
            switch status {
            case .readyToPlay:
                self.avControlView?.btn_Play.setImage(R.image.ic_fit_pause(), for: .normal)
                self.avControlView?.ind_Loading.stopAnimating()
                self.avControlView?.btn_Play.isHidden = false
                
                if self.avControlView?.avState == .seeking || self.avControlView?.avState == .loading {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        self.avControlView?.avState = .readyToPlay
                        self.valueSliderChange = 0
                        
                        print("observeValue readyToPlay 1.5")
                    }
                } else {
                    self.avControlView?.avState = .readyToPlay
                    print("observeValue readyToPlay")
                }
                
                self.setViewControlShow()
                
            case .failed:
                print("observeValue failed")
                
            case .unknown:
                print("observeValue unknown")
                
            @unknown default:
                fatalError()
            }
            
        case AVConstant.loadedTimeRangesKey:
            self.onLoadedTimeRangedChanged()
            
        case AVConstant.rate:
            if self.avPlayer?.rate == 1 {
                self.avControlView?.avRate = .isPlay
                
            } else {
                self.avControlView?.avRate = .isPause
            }
             
        default:
            break
        }
    }
    
    private func onLoadedTimeRangedChanged() {
        let duration = self.avPlayer?.currentItem?.asset.duration
        let durationSeconds = CMTimeGetSeconds(duration ?? .zero)
        
        let totalBuffer = self.avPlayer?.currentItem?.totalBuffer()
        self.progressValue = CGFloat(totalBuffer ?? 0) / CGFloat(durationSeconds)
        self.avControlView?.view_Progress.setProgress(Float(progressValue), animated: true)
    }
    
    func onTimeObserver() {
        let interval = CMTime(seconds: 1.0, preferredTimescale: CMTimeScale(NSEC_PER_SEC)) //DispatchQueue.main
        
        self.avPlayer?.addPeriodicTimeObserver(forInterval: interval, queue: nil, using: { [weak self] _ in
            guard let currentItem = self?.avPlayer?.currentItem, let durationCMTimeFormat = self?.avPlayer?.currentItem?.asset.duration else {
                return
            }
            
            let duration = CMTimeGetSeconds(durationCMTimeFormat).rounded(toPlaces: 1)
            let currentTime = currentItem.currentTime().seconds.rounded(toPlaces: 1)
            
            if self?.avControlView?.avState != .seeking {
                if self?.valueSliderChange ?? 0 == 0 {
                    let sliderValue = Float(currentTime / Double(duration))
                    self?.avControlView?.slider_TimeTracking.setValue(sliderValue, animated: true)
                    
                    let sliderValuePlay = sliderValue.rounded(toPlaces: 3)
                    let sliderValueLoad = Float(self!.progressValue).rounded(toPlaces: 3)
                    
                    if sliderValuePlay == sliderValueLoad && sliderValueLoad > 0.0 {
                        self?.avControlView?.avState = .loading
                        self?.avControlView?.btn_Play.isHidden = true
                        self?.avControlView?.ind_Loading.startAnimating()
                        self?.setViewControlShow()
                        
                        NotificationCenter.default.post(name: .onActionLoading, object: nil)
//                        print("<AVPlayer> addTimeObserver: xxx ==")
                    }
                    
                } else {
                    self?.avControlView?.slider_TimeTracking.setValue(self?.valueSliderChange ?? 0, animated: true)
//                    print("<AVPlayer> addTimeObserver: valueSliderChange: ", self?.valueSliderChange ?? 0)
                    if self?.needHideLoad == true {
                        self?.avControlView?.avState = .readyToPlay
                        self?.avControlView?.ind_Loading.stopAnimating()
                        self?.avControlView?.btn_Play.isHidden = false
                        self?.setViewControlShow()
                        self?.needHideLoad = false
                    }
                }
            }
            
            let currentTimeFormat = AVUtils.formatDurationTime(time: Int(currentTime))
            let durationFormat = AVUtils.formatDurationTime(time: Int(duration))
            

            self?.setTimePlayer(withDuration: durationFormat, currentTime: currentTimeFormat)
            
            // Played To The End
            if currentTimeFormat == durationFormat {
                self?.avControlView?.avState = .playedToTheEnd
                self?.avControlView?.btn_Play.setImage(R.image.ic_replay(), for: .normal)
                self?.avControlView?.ind_Loading.stopAnimating()
                self?.avControlView?.btn_Play.isHidden = false
                self?.setViewControlShow()
                print("<AVPlayer> addTimeObserver: Played To The End")
            }
            
            self?.timePlaying = Double(currentTime)
            self?.lastSeenTime = currentTimeFormat
            
            print("<AVPlayer> addTimeObserver: duration: ", duration)
            print("<AVPlayer> addTimeObserver: currentTime: ", currentTime)
            print("<AVPlayer> addTimeObserver: ========================\n")
        })
    }
    
    private func setTimePlayer(withDuration duration: String, currentTime: String) {
        self.avControlView?.lbl_TimePlayer.text = String(format: "%@/%@", currentTime, duration)
    }
}
