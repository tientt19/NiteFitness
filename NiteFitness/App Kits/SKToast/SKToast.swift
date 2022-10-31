//
//  SKToast.swift
//  myElcom
//
//  Created by Tiến Trần on 29/07/2022.
//

import Foundation
import SnapKit

class SKToast {
    private var toastView = UIView()
    private var contentLabel = UILabel()
    private var timer: Timer?
    private let animationTime = Constant.Number.animationTime

    static let shared = SKToast()
    
    private init() {
        self.setupUI()
    }

    func setupUI() {
        self.toastView.addSubview(contentLabel)
        self.contentLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(22)
            make.top.equalToSuperview().offset(5)
        }
        self.toastView.cornerRadius = 16
        self.toastView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.toastView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hide)))
        self.contentLabel.numberOfLines = 0
        self.contentLabel.lineBreakMode = .byWordWrapping
        self.contentLabel.textColor = .white
        self.contentLabel.textAlignment = .center
    }

    func showToast(content: String = "Đã có lỗi xảy ra") {
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        window.addSubview(toastView)
        self.toastView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.leading.greaterThanOrEqualToSuperview().offset(20)
        }
        
        self.contentLabel.text = content
        UIView.animate(withDuration: self.animationTime, animations: {
            self.toastView.alpha = 1
            
        }, completion: { _ in
            self.startTimer()
        })
    }

    func showToast(content: String, on viewController: UIViewController) {
        viewController.view.addSubview(toastView)
        self.toastView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.leading.greaterThanOrEqualToSuperview().offset(20)
        }
        
        self.contentLabel.text = content
        UIView.animate(withDuration: self.animationTime, animations: {
            self.toastView.alpha = 1
            
        }, completion: { _ in
            self.startTimer()
        })
    }

    func showErrorMessage(with error: APIError) {
        if error.statusCode == -999 { // Cancel
            return
            
        } else {
            self.showToast(content: error.message)
        }
    }

    @objc private func hide() {
        UIView.animate(withDuration: self.animationTime, animations: {
            self.toastView.alpha = 0
            
        }, completion: { (_) in
            self.contentLabel.text = ""
            self.toastView.removeFromSuperview()
            self.endTimer()
        })
    }

    private func startTimer() {
        self.endTimer()
        self.timer = Timer.scheduledTimer(timeInterval: 2,
                                     target: self,
                                     selector: #selector(hide),
                                     userInfo: nil,
                                     repeats: false)
    }

    private func endTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }
}
