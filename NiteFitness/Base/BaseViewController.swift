//
//  BaseViewController.swift
//  myElcom
//
//  Created by Valerian on 13/05/2022.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController, UIGestureRecognizerDelegate {
    private var progressHub: UIActivityIndicatorView?
    private var viewProgressHub: UIView?
    var viewError: ErrorView?

    private var viewNoInternetConnection = UIView()
    private var constraint_height_ViewNoInternetConnection: Constraint?
    var startContentOffset: CGFloat!
    var lastContentOffset: CGFloat!
    private var isHidingTabBar: Bool = false
    
    var isInteractivePopGestureEnable = true {
        didSet {
            self.setUpdateInteractivePopGesture()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewNoInternetConnection = self.createNoInternetConnectionView()
        self.setObserverInternetConnection()
        self.addIndicator()
    }
}

// MARK: Navigation View
extension BaseViewController {
    func setNavagationBarHidden(_ viewControllers: UIViewController.Type...) {
        guard let baseNavigationController = navigationController as? BaseNavigationController else {
            return
        }
        
        baseNavigationController.setHiddenNavigationBarViewControllers(viewControllers)
    }
}

// MARK: - Loading
extension BaseViewController {
    private func addIndicator() {
        self.viewProgressHub = UIView()
        self.viewProgressHub!.backgroundColor = .clear
        self.viewProgressHub?.alpha = 0
        self.viewProgressHub?.isHidden = true
        self.view.addSubview(self.viewProgressHub!)
        self.view.bringSubviewToFront(viewProgressHub!)
        self.viewProgressHub?.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        self.progressHub = UIActivityIndicatorView(style: .whiteLarge)
        
        let hudBGView = UIView()
        hudBGView.backgroundColor = UIColor.darkGray
        self.viewProgressHub?.addSubview(hudBGView)
        hudBGView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(80)
        }
        hudBGView.cornerRadius = 8
        hudBGView.addSubview(self.progressHub!)
        self.progressHub?.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(40)
        }
    }

    func showProgressHud(offsetTop: CGFloat = 0, offsetBottom: CGFloat = 0, position: ProgressPosition = .full, backgroundColor: UIColor = .clear) {
        self.viewProgressHub?.backgroundColor = backgroundColor
        self.view.bringSubviewToFront(self.viewProgressHub!)
        let navigationBarHeight = navigationController?.navigationBar.height ?? 0
        let tabbarHeight = tabBarController?.tabBar.height ?? 0
        var statusBarHeight = UIApplication.shared.statusBarFrame.height
        if #available(iOS 13, *) {
            statusBarHeight = UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        }
        var topMargin: CGFloat = 0
        var bottomMargin: CGFloat = 0
        switch position {
        case .full:
            topMargin = offsetTop
            bottomMargin = offsetBottom
        case .underStatusBar:
            topMargin = statusBarHeight + offsetTop
            bottomMargin = offsetBottom
        case .aboveTabbar:
            topMargin = offsetTop
            bottomMargin = tabbarHeight + offsetBottom
        case .underNavigationBar:
            topMargin = statusBarHeight + navigationBarHeight + offsetTop
            bottomMargin = offsetBottom
        case .aboveTabbarAndUnderNavigationBar:
            topMargin = statusBarHeight + navigationBarHeight + offsetTop
            bottomMargin = offsetBottom + tabbarHeight
        case .aboveTabbarAndUnderStatusBar:
            topMargin = statusBarHeight + offsetTop
            bottomMargin = offsetBottom + tabbarHeight
        }

        self.viewProgressHub?.snp.remakeConstraints { (make) in
            make.top.equalToSuperview().offset(topMargin)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-bottomMargin)
        }
        self.progressHub?.startAnimating()
        self.viewProgressHub?.isHidden = false
            self.viewProgressHub?.alpha = 1
            self.view.layoutIfNeeded()
    }

    func hideProgressHud() {
        self.progressHub?.stopAnimating()
        UIView.animate(withDuration: Constant.Number.animationTime, animations: {
            self.viewProgressHub?.alpha = 0
        }, completion: { _ in
            self.viewProgressHub?.isHidden = true
        })
    }
}

// MARK: - Internet Connection
extension BaseViewController {
    @discardableResult private func createNoInternetConnectionView() -> UIView {
        let noInternetView = UIView()
        noInternetView.alpha = 0
        noInternetView.backgroundColor = .white
        self.view.addSubview(noInternetView)
        noInternetView.snp.makeConstraints { (make) in
            make.bottom.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            self.constraint_height_ViewNoInternetConnection = make.height.equalTo(0).constraint
        }
        
        let wifiImageView = UIImageView(image: UIImage(named: ""))
        noInternetView.addSubview(wifiImageView)
        wifiImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(17)
            make.leading.equalToSuperview().offset(16)
        }
        
        let contentLabel = createNoInternetViewContentLabel()
        noInternetView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(12)
            make.leading.equalTo(wifiImageView.snp.trailing).offset(18)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        let closeButton = createNoInternetViewCloseButton()
        noInternetView.addSubview(closeButton)
        closeButton.snp.makeConstraints { (make) in
            make.top.equalTo(contentLabel.snp.bottom).offset(12)
            make.leading.equalTo(wifiImageView.snp.leading)
            make.height.equalTo(35)
        }
        
        let retryButton = createNoInternetViewRetryButton()
        noInternetView.addSubview(retryButton)
        retryButton.snp.makeConstraints { (make) in
            make.centerY.height.width.equalTo(closeButton)
            make.leading.equalTo(closeButton.snp.trailing).offset(27)
            make.trailing.equalTo(contentLabel)
        }
        
        return noInternetView
    }

    private func createNoInternetViewContentLabel() -> UILabel {
        
        ///////////////////////////////
        
        let contentLabel = UILabel()
        contentLabel.text = "Không có kết nối mạng.\nVui lòng kiểm tra kết nối mạng của bạn."
        contentLabel.font = UIFont.systemFont(ofSize: 14)
        contentLabel.textColor = UIColor.darkText
        contentLabel.numberOfLines = 0
        contentLabel.lineBreakMode = .byWordWrapping
        return contentLabel
    }

    private func createNoInternetViewCloseButton() -> UIButton {
        let closeButton = UIButton()
        closeButton.setTitle("Đóng", for: .normal)
        closeButton.setTitleColor(UIColor.white, for: .normal)
        closeButton.backgroundColor = UIColor(hex: "")
        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        closeButton.addTarget(self, action: #selector(self.buttonCloseNoInternetConnectionViewDidTapped), for: .touchUpInside)
        closeButton.cornerRadius = 4
        return closeButton
    }

    private func createNoInternetViewRetryButton() -> UIButton {
        let retryButton = UIButton()
        retryButton.setTitle("Thử lại", for: .normal)
        retryButton.setTitleColor(UIColor.white, for: .normal)
        retryButton.backgroundColor = UIColor.blue
        retryButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        retryButton.addTarget(self, action: #selector(self.buttonRetryInternetConnectionDidTapped), for: .touchUpInside)
        retryButton.cornerRadius = 4
        return retryButton
    }

    private func setObserverInternetConnection() {
        print("BaseViewController setObserverInternetConnection")
        NotificationCenter.default.addObserver(self, selector: #selector(self.onInternetConnectionAvailable), name: .connectionAvailable, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.onInternetConnectionUnavailable), name: .connectionUnavailable, object: nil)
    }

    @objc func onInternetConnectionAvailable() {
        print("BaseViewController onInternetConnectionAvailable")
        gIsHaveInternetConnected = true
        self.hideNoInternetConnectionView()
    }

    @objc func onInternetConnectionUnavailable() {
        print("BaseViewController onInternetConnectionUnavailable")
        gIsHaveInternetConnected = false
        guard self.viewError == nil, !self.isKind(of: LoginViewController.self), !self.isKind(of: NewFeedViewController.self) else {
            return
        }
        self.showNoInternetConnectionView()
    }

    @objc func buttonCloseNoInternetConnectionViewDidTapped() {
        self.hideNoInternetConnectionView()
    }

    @objc func buttonRetryInternetConnectionDidTapped() {
        if InternetConnection.shared.isAvailable() {
            self.hideNoInternetConnectionView()
        }
    }

    private func showNoInternetConnectionView() {
        self.viewNoInternetConnection.alpha = 1
        self.view.bringSubviewToFront(self.viewNoInternetConnection)
        self.constraint_height_ViewNoInternetConnection?.update(offset: 107)
        UIView.animate(withDuration: Constant.Number.animationTime) {
            self.view.layoutIfNeeded()
        }
    }

    private func hideNoInternetConnectionView() {
        self.constraint_height_ViewNoInternetConnection?.update(offset: 0)
        UIView.animate(withDuration: Constant.Number.animationTime, animations: {
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.viewNoInternetConnection.alpha = 0
        })
    }

    private func setUpdateInteractivePopGesture() {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = self.isInteractivePopGestureEnable
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
}

// MARK: - Error View
extension BaseViewController {
    func showErrorView(with content: String?,
                       delegate: ErrorViewDelegate,
                       position: ProgressPosition = .full,
                       offsetTop: CGFloat = 0,
                       offsetBottom: CGFloat = 0) {
        if let `errorView` = self.viewError {
            errorView.removeFromSuperview()
            self.viewError = nil
        }
        let navigationBarHeight = navigationController?.navigationBar.height ?? 0
        let tabbarHeight = tabBarController?.tabBar.height ?? 0
        var statusBarHeight = UIApplication.shared.statusBarFrame.height
        if #available(iOS 13, *) {
            statusBarHeight = UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        }
        var topMargin: CGFloat = 0
        var bottomMargin: CGFloat = 0
        switch position {
        case .full:
            topMargin = offsetTop
            bottomMargin = offsetBottom
        case .underStatusBar:
            topMargin = statusBarHeight + offsetTop
            bottomMargin = offsetBottom
        case .aboveTabbar:
            topMargin = offsetTop
            bottomMargin = tabbarHeight + offsetBottom
        case .underNavigationBar:
            topMargin = statusBarHeight + navigationBarHeight + offsetTop
            bottomMargin = offsetBottom
        case .aboveTabbarAndUnderNavigationBar:
            topMargin = statusBarHeight + navigationBarHeight + offsetTop
            bottomMargin = offsetBottom + tabbarHeight
        case .aboveTabbarAndUnderStatusBar:
            topMargin = statusBarHeight + offsetTop
            bottomMargin = offsetBottom + tabbarHeight
        }

        self.viewError = ErrorView(message: content ?? "Không thể tải dữ liệu")
        self.view.addSubview(self.viewError!)
        self.viewError?.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.top.equalToSuperview().offset(topMargin)
            make.bottom.equalToSuperview().offset(-bottomMargin)
        }
        self.viewError?.delegate = delegate
        self.view.bringSubviewToFront(self.viewError!)
    }

    func hideErrorView() {
        self.viewError?.removeFromSuperview()
        self.viewError = nil
    }
}

//MARK: - EmptyView
extension BaseViewController {
    func getMessageNoData(message: String) -> NSAttributedString {
        let font = UIFont.systemFont(ofSize: 16)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font
        ]
        let attributedMessage = NSAttributedString(string: message, attributes: attributes)
        return attributedMessage
    }
    
    func hideTabBarIfNeeded() {
        guard !self.isHidingTabBar else { return }
        self.isHidingTabBar = true
        (self.tabBarController as! MainTabbarController).setTabBarHidden(true, animated: true)
    }
    
    func showTabBarIfNeeded() {
        guard self.isHidingTabBar else { return }
        self.isHidingTabBar = false
        (self.tabBarController as! MainTabbarController).setTabBarHidden(false, animated: true)
    }
}

// MARK: - UIGestureRecognizerDelegate
extension BaseViewController {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard gestureRecognizer == self.navigationController?.interactivePopGestureRecognizer else {
            return true
        }
        return navigationController?.viewControllers.count ?? 0 > 1
    }
}
