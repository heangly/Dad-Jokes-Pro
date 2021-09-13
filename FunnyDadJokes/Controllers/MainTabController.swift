//
//  ViewController.swift
//  FunnyDadJokes
//
//  Created by Heang Ly on 9/10/21.
//

import UIKit

class MainTabController: UITabBarController {
    //MARK: - LifeCycle
    private let blackLine: UIView = {
        let bl = UIView()
        bl.backgroundColor = .black
        return bl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureMainUI()
    }

    //MARK: - Helpers
    func configureMainUI() {
        let favoriteVC = getNavControllerTemplate(unSelectedImage: UIImage(systemName: "star")!, selectedImage: UIImage(systemName: "star.fill")!, rootViewController: FavoriteTabController())
        favoriteVC.title = "Favorites"

        let homeVC = getNavControllerTemplate(unSelectedImage: UIImage(systemName: "house")!, selectedImage: UIImage(systemName: "house.fill")!, rootViewController: HomeTabController())
        homeVC.title = "Home"

        let notificationVC = getNavControllerTemplate(unSelectedImage: UIImage(systemName: "bell")!, selectedImage: UIImage(systemName: "bell.fill")!, rootViewController: NotificationTabController())
        notificationVC.title = "Notification"

        setViewControllers([favoriteVC, homeVC, notificationVC], animated: false)
        
        tabBar.isTranslucent = false
        tabBar.barTintColor = .mainGold
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .black
        //  set the current tab bar
        self.selectedIndex = 1
    }
    
 

    func getNavControllerTemplate(unSelectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = unSelectedImage
        nav.tabBarItem.selectedImage = selectedImage
        return nav
    }
}

