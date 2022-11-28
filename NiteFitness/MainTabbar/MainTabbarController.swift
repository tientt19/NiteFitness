//
//  MainTabbarController.swift
//  myElcom
//
//  Created by Valerian on 13/05/2022.
//

import UIKit

class MainTabbarController: UITabBarController, UITabBarControllerDelegate {
    
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
    
    private func setShadowTabBar() {
        self.tabBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.tabBar.layer.shadowOpacity = 0.5
        self.tabBar.layer.shadowOffset = CGSize.zero
        self.tabBar.layer.shadowRadius = 5
        self.tabBar.layer.borderColor = UIColor.clear.cgColor
        self.tabBar.layer.borderWidth = 0
        self.tabBar.clipsToBounds = false
        self.tabBar.backgroundColor = UIColor.white
    }
    
    private func setInitAddItemTabBarController() {
        self.tabBar.layer.borderColor = UIColor(hex: "D4D4D4").cgColor
        self.tabBar.layer.borderWidth = 0.5
        
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().barTintColor = UIColor.white
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().tintColor = R.color.mainColor()
        UITabBar.appearance().unselectedItemTintColor = UIColor.init(hex: "8A8A8A")
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().barStyle = .default
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)], for: .selected)
        
        let verticalSize: CGFloat = -1 // -3.0
        
        // MARK: Page 1
        let tab_1 = HomeHealthyRouter.setupModule()
        tab_1.tabBarItem = TabbarItem.HEALTHY.item
        
        let navigationTab_1 = BaseNavigationController(rootViewController: tab_1)
        navigationTab_1.setHiddenNavigationBarViewControllers([
//            HomeFitViewController.self,
//            PracticeViewController.self,
//            MyWorkoutViewController.self,
//            EditListExerciseViewController.self,
//            DoExerciseViewController.self,
//            FinishWorkoutViewController.self,
//            SearchFitViewController.self,
//            DetailPurposePracticeViewController.self,
//            BikeWorkoutViewController.self,
//            WorkoutDetailViewController.self,
//            BicycleResultViewController.self,
//            HomeFitContainerViewController.self,
//            VideoFitDetailPlayerViewController.self,
//            DetailRacingViewController.self,
//            BlogDetailViewController.self,
//            PlayVideoViewController.self,
//            PlayVideoFullViewController.self,
//            PlayVideoFullFitViewController.self,
//            DetailAppointmentViewController.self,
//            DoctorDetailViewController.self,
            HomeHealthyViewController.self])
        
        // MARK:  Add Tabbar
        self.viewControllers = [
            tab_1
        ]
        self.delegate = self
        gTabBarController = self
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
