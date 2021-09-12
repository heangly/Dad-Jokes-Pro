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
        tabBar.isTranslucent = false
        tabBar.barTintColor = .mainGold
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .black

        let homeVC = getNavControllerTemplate(unSelectedImage: UIImage(systemName: "house")!, selectedImage: UIImage(systemName: "house.fill")!, rootViewController: HomeTabController())
        homeVC.title = "Home"

        let favoriteVC = getNavControllerTemplate(unSelectedImage: UIImage(systemName: "star")!, selectedImage: UIImage(systemName: "star.fill")!, rootViewController: FavoriteTabController())
        favoriteVC.title = "Favorite"

        setViewControllers([homeVC, favoriteVC], animated: false)
    }

    func getNavControllerTemplate(unSelectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = unSelectedImage
        nav.tabBarItem.selectedImage = selectedImage
        return nav
    }
}

