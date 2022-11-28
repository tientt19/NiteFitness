//
//  BaseRouter.swift
//  1SK
//
//  Created by tuyenvx on 12/01/2021.
//

import UIKit

protocol BaseRouterProtocol {
    func showHud()
    func showHud(offsetTop: CGFloat, offsetBottom: CGFloat, position: ProgressPosition, backgroundColor: UIColor)
    func hideHud()
    func showToast(content: String?)
    func showErrorView(with content: String?, delegate: ErrorViewDelegate)
    func showErrorView(with content: String?,
                       delegate: ErrorViewDelegate,
                       offsetTop: CGFloat,
                       offsetBottom: CGFloat,
                       position: ProgressPosition)
    func hideErrorView()
}

// MARK: BaseRouterProtocol
class BaseRouter: BaseRouterProtocol {
    weak var viewController: UIViewController?

    func showHud() {
        guard let `viewController` = self.viewController as? BaseViewController else {
            return
        }
        viewController.showProgressHud()
    }

    func showHud(offsetTop: CGFloat = 0,
                 offsetBottom: CGFloat = 0,
                 position: ProgressPosition = .full,
                 backgroundColor: UIColor = .clear) {
        guard let `viewController` = self.viewController as? BaseViewController else {
            return
        }
        viewController.showProgressHud(offsetTop: offsetTop,
                               offsetBottom: offsetBottom,
                               position: position,
                               backgroundColor: backgroundColor)
    }

    func hideHud() {
        guard let `viewController` = self.viewController as? BaseViewController else {
            return
        }
        viewController.hideProgressHud()
    }

    func showToast(content: String?) {
        guard let `viewController` = self.viewController,
              let `content` = content else {
            return
        }
        SKToast.shared.showToast(content: content, on: viewController)
    }

    func showErrorView(with content: String?,
                       delegate: ErrorViewDelegate,
                       offsetTop: CGFloat = 0,
                       offsetBottom: CGFloat = 0,
                       position: ProgressPosition = .full) {
        if let `viewController` = self.viewController as? BaseViewController {
            viewController.showErrorView(with: content,
                                         delegate: delegate,
                                         position: position,
                                         offsetTop: offsetTop,
                                         offsetBottom: offsetBottom)
        }
    }

    func showErrorView(with content: String?, delegate: ErrorViewDelegate) {
        if let `viewController` = self.viewController as? BaseViewController {
            viewController.showErrorView(with: content, delegate: delegate)
        }
    }

    func hideErrorView() {
        if let baseViewController = self.viewController as? BaseViewController,
           let errorView = baseViewController.viewError {
            errorView.removeFromSuperview()
            baseViewController.viewError = nil
        }
    }
}
