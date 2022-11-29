//
//  AVPlayerControlView.swift
//  1SK
//
//  Created by vuongbachthu on 8/15/21.
//

import UIKit

protocol AVPlayerControlViewDelegate: AnyObject {
    func onPlayAction()
    func onSliderValueChangeAction(value: Float)
    func onSliderEventAction(event: SliderEvent)
    func onScreenSizeAction(isPlayFull: Bool)
}

enum SliderEvent {
    case began
    case ended
    case none
}

enum AVPlayerState {
    case none
    case loading
    case readyToPlay
    case seeking
    case playedToTheEnd
    case error
}

enum AVPlayerRate {
    case isPlay
    case isPause
    case isNone
}

class AVPlayerControlView: UIView {

    @IBOutlet weak var btn_Play: UIButton!
    @IBOutlet weak var ind_Loading: UIActivityIndicatorView!
    @IBOutlet weak var lbl_TimePlayer: UILabel!
    @IBOutlet weak var slider_TimeTracking: UISlider!
    @IBOutlet weak var view_Slider: UIView!
    @IBOutlet weak var view_Progress: UIProgressView!
    
    @IBOutlet weak var btn_ScreenSize: UIButton!
    
    weak var delegate: AVPlayerControlViewDelegate?
    
    var avState: AVPlayerState = .none
    var avRate: AVPlayerRate = .isNone
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setInitUI()
        
        self.ind_Loading.startAnimating()
        self.btn_Play.isHidden = true
    }

    private func setInitUI() {
        self.btn_ScreenSize.setImage(R.image.ic_normal_screen(), for: .selected)
        self.btn_ScreenSize.setImage(R.image.ic_full_screen(), for: .normal)
        
        self.slider_TimeTracking.setThumbImage(R.image.ic_slider_thumb(), for: .normal)
        self.slider_TimeTracking.setThumbImage(R.image.ic_slider_thumb(), for: .highlighted)
        
        self.slider_TimeTracking.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onSliderDidTapAction(gestureRecognizer:))))
        
        self.slider_TimeTracking.addTarget(self, action: #selector(self.onSliderValChanged(slider:event:)), for: .valueChanged)
    }
    
    @objc func onSliderValChanged(slider: UISlider, event: UIEvent) {
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .began:
                // handle drag began
                self.delegate?.onSliderEventAction(event: .began)
                print("onSlider onSliderValChanged began")
                
            case .moved:
                // handle drag moved
                print("onSlider onSliderValChanged moved")
                
            case .ended:
                // handle drag ended
                self.delegate?.onSliderEventAction(event: .ended)
                self.delegate?.onSliderValueChangeAction(value: slider.value)
                
                print("onSlider onSliderValChanged ended")
                
            default:
                break
            }
        }
    }
    
    @objc func onSliderDidTapAction(gestureRecognizer: UIGestureRecognizer) {
        print("onSlider onSliderDidTapAction")
        
        let pointTapped: CGPoint = gestureRecognizer.location(in: self)
        let positionOfSlider: CGPoint = self.slider_TimeTracking.frame.origin
        let widthOfSlider: CGFloat = self.slider_TimeTracking.frame.size.width
        let newValue = ((pointTapped.x - positionOfSlider.x) * CGFloat(self.slider_TimeTracking.maximumValue) / widthOfSlider)

        self.slider_TimeTracking.setValue(Float(newValue), animated: true)
        
        self.delegate?.onSliderValueChangeAction(value: Float(newValue))
    }
    
    func setScreenSize(isPlayFull: Bool) {
        self.btn_ScreenSize.isSelected = isPlayFull
    }
    
    @IBAction func onPlayAction(_ sender: Any) {
        self.delegate?.onPlayAction()
    }
    
    @IBAction func onScreenSizeAction(_ sender: Any) {
        self.delegate?.onScreenSizeAction(isPlayFull: self.btn_ScreenSize.isSelected)
    }
    
}
