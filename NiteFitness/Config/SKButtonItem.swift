//
//  SKButtonItem.swift
//  NiteFitness
//
//  Created by Tiến Trần on 29/11/2022.
//

import UIKit

class SKBarButtonItem: UIBarButtonItem {
    private var actionHandler: ((SKBarButtonItem) -> Void)?

    convenience init(style: BarButtonStyle, actionHandler: ((SKBarButtonItem) -> Void)?) {
        self.init(image: style.image, style: .plain, target: nil, action: #selector(didTapped))
        self.target = self
        self.actionHandler = actionHandler
    }

    @objc func didTapped(sender: SKBarButtonItem) {
        actionHandler?(sender)
    }
}

// MARK: - SKBarButton Style
extension SKBarButtonItem {
    enum BarButtonStyle {
        case menu
        case notification
        case close
        case back
        case option
        case addFriend
        case addNewPost
        case postEnable
        case postDisable
        case add
        case saveEnable
        case saveDisable

        var image: UIImage? {
            switch self {
            case .menu:
                return R.image.ic_menu_2()
            case .back:
                return R.image.ic_back()
            case .close:
                return R.image.ic_close_white()
            case .notification:
                return R.image.ic_notification()
            case .option:
                return R.image.ic_more()
            case .addFriend:
                return R.image.ic_add_friend()
            case .addNewPost:
                return R.image.ic_post()
            case .postEnable:
                return R.image.ic_post_navigation()?.withRenderingMode(.alwaysOriginal)
            case .postDisable:
                return R.image.ic_post_navigation_disable()?.withRenderingMode(.alwaysOriginal)
            case .add:
                return R.image.ic_add_black()
            case .saveEnable:
                return R.image.ic_save()?.withRenderingMode(.alwaysOriginal)
            case .saveDisable:
                return R.image.ic_save_disable()
            }
        }
    }
}

