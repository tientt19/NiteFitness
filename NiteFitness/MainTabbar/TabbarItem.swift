//
//  TabbatItem.swift
//  NiteFitness
//
//  Created by Tiến Trần on 11/11/2022.
//
import UIKit

extension UITabBar {
    func addBadge(index: Int) {
        if let tabItems = self.items {
            let tabItem = tabItems[index]
            tabItem.badgeValue = "●"
            tabItem.badgeColor = .clear
            tabItem.setBadgeTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .normal)
        }
    }
    
    func removeBadge(index: Int) {
        if let tabItems = self.items {
            let tabItem = tabItems[index]
            tabItem.badgeValue = nil
        }
    }
 }

// MARK: TabbarItem
enum TabbarItem {
//    case HOME
    case HEALTHY
    case EXERCISE
//    case STORE
//    case MESSAGE
//    case PROFILE

    var item: UITabBarItem {
        switch self {
//        case .HOME:
//            let tabBarItem = UITabBarItem()
//            tabBarItem.tag = 0
//            tabBarItem.title  = "Home"
//            tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -1)
//            tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//            tabBarItem.image = self.tabbarImage(with: R.image.ic_tab_0_false())
//            tabBarItem.selectedImage = self.tabbarImage(with: R.image.ic_tab_0_true())
//
//            return tabBarItem
            
        case .HEALTHY:
            let tabBarItem = UITabBarItem()
            tabBarItem.tag = 1
            tabBarItem.title  = "Sống khỏe"
            tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -1)
            tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            tabBarItem.image = self.tabbarImage(with: R.image.ic_tab_1_false())
            tabBarItem.selectedImage = self.tabbarImage(with: R.image.ic_tab_1_true())
            
            return tabBarItem
            
        case .EXERCISE:
            let tabBarItem = UITabBarItem()
            tabBarItem.tag = 2
            tabBarItem.title  = "Luyện tập"
            tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -1)
            tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            tabBarItem.image = self.tabbarImage(with: R.image.ic_fitness())
            tabBarItem.selectedImage = self.tabbarImage(with: R.image.ic_fitness_selected())

            return tabBarItem
//
//        case .MESSAGE:
//            let tabBarItem = UITabBarItem()
//            tabBarItem.tag = 3
//            tabBarItem.title  = "Tin nhắn"
//            tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -1)
//            tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//            tabBarItem.image = self.tabbarImage(with: R.image.ic_tab_3_false())
//            tabBarItem.selectedImage = self.tabbarImage(with: R.image.ic_tab_3_true())
//
//            return tabBarItem
//
//        case .PROFILE:
//            let tabBarItem = UITabBarItem()
//            tabBarItem.tag = 4
//            tabBarItem.title  = "Cá nhân"
//            tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -1)
//            tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//            tabBarItem.image = self.tabbarImage(with: R.image.ic_tab_4_false())
//            tabBarItem.selectedImage = self.tabbarImage(with: R.image.ic_tab_4_true())
//
//            return tabBarItem
        }
    }

    private func tabbarImage(with image: UIImage?) -> UIImage? {
        return image?.withRenderingMode(.alwaysOriginal)
    }
}
