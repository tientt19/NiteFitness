//
//  MainTabbarController.swift
//  myElcom
//
//  Created by Valerian on 13/05/2022.
//

import UIKit

class MainTabbarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitAddItemTabBarController()
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        let navigation = self.selectedViewController as? BaseNavigationController
        return navigation?.supportedInterfaceOrientations ?? .portrait
    }
    
    private func setInitAddItemTabBarController() {
        self.tabBar.layer.borderColor = UIColor(hex: "D4D4D4").cgColor
        self.tabBar.layer.borderWidth = 0.5
        
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().barTintColor = UIColor.white
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().tintColor = UIColor(hex: "0026AB")
        UITabBar.appearance().unselectedItemTintColor = UIColor(hex: "25150E", alpha: 0.5)
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().barStyle = .default
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)], for: .selected)
        
        let verticalSize: CGFloat = -1 // -3.0
        
        //Tin tức
        let feedController = NewFeedRouter.setupModule()
        
        feedController.tabBarItem.tag = 0
        feedController.tabBarItem.title  = "Tin Tức"
        feedController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: verticalSize)
        feedController.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        feedController.tabBarItem.image = UIImage(named: "")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        feedController.tabBarItem.selectedImage = UIImage(named: "")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        let feedNavController = BaseNavigationController(rootViewController: feedController)
        feedNavController.navigationItem.backBarButtonItem = UIBarButtonItem(title: String(), style: .plain, target: nil, action: nil)
        feedNavController.setHiddenNavigationBarViewControllers([])
        
        //Tin tức
        let xxxController = LoginRouter.setupModule()
        
        xxxController.tabBarItem.tag = 0
        xxxController.tabBarItem.title  = "Tin Tức tesst"
        xxxController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: verticalSize)
        xxxController.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        xxxController.tabBarItem.image = UIImage(named: "")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        xxxController.tabBarItem.selectedImage = UIImage(named: "")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        let xxxNavController = BaseNavigationController(rootViewController: xxxController)
        xxxNavController.navigationItem.backBarButtonItem = UIBarButtonItem(title: String(), style: .plain, target: nil, action: nil)
        xxxNavController.setHiddenNavigationBarViewControllers([])
        
        // MARK:  Add Tabbar
        self.viewControllers = [
            feedNavController,
            xxxNavController
        ]
    }
}

extension UITabBarController {
    /// Extends the size of the `UITabBarController` view frame, pushing the tab bar controller off screen.
    /// - Parameters:
    ///   - hidden: Hide or Show the `UITabBar`
    ///   - animated: Animate the change
    func setTabBarHidden(_ hidden: Bool, animated: Bool) {
        guard let vc = selectedViewController else { return }
        guard tabBarHidden != hidden else { return }
        
        let frame = self.tabBar.frame
        let height = frame.size.height
        let offsetY = hidden ? height : -height
        
        UIViewPropertyAnimator(duration: animated ? 0.3 : 0, curve: .easeOut) {
            self.tabBar.frame = self.tabBar.frame.offsetBy(dx: 0, dy: offsetY)
            self.selectedViewController?.view.frame = CGRect(
                x: 0,
                y: 0,
                width: vc.view.frame.width,
                height: vc.view.frame.height + offsetY
            )
            
            self.view.setNeedsDisplay()
            self.view.layoutIfNeeded()
        }
        .startAnimation()
    }
    
    /// Is the tab bar currently off the screen.
    private var tabBarHidden: Bool {
        tabBar.frame.origin.y >= UIScreen.main.bounds.height
    }
}
