//
//  Contanst.swift
//  myElcom
//
//  Created by Valerian on 16/05/2022.
//

import UIKit

struct Constant {
    struct Screen {
        static var width = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
        static var height = max(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
    }
    
    struct LogoutAlert {
        static var title = "Đăng xuất"
        static var message = "Chắc chắn muốn đăng xuất"
        static var cancelButtonTite = "Cancel"
    }
    
    struct LoginAlert {
        static var title = "Đăng nhập thất bại!"
        static var message = "Tính năng không khả dụng."
        static var cancelButtonTite = "Cancel"
    }
    
    struct Number {
        static let animationTime = 0.3
        static let roundCornerRadius: CGFloat = 30        
    }
}
