//
//  HomeViewController.swift
//  TribalWorldWideMitch
//
//  Created by Mitch Samaniego on 23/07/21.
//

import UIKit

final class HomeViewController: UITabBarController {
    
    let principalFeedViewController = PrincipalFeedViewController()
    let profileViewController = ProfileViewController()
    let favouritesViewcontroller = FavouritesViewController()
    let settingsViewController = SettingsViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    private func setupView() {
        tabBar.barTintColor = .white
        tabBar.tintColor = .link
        tabBar.barStyle = .default
        tabBar.unselectedItemTintColor = UIColor.link.withAlphaComponent(0.8)
        
        
        
        principalFeedViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "house.fill"), tag: 0)

        profileViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "person.fill"), tag: 1)

        favouritesViewcontroller.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "star.fill"), tag: 2)
        
        settingsViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "gearshape.fill"), tag: 3)

        let controllers = [principalFeedViewController, profileViewController, favouritesViewcontroller, settingsViewController]

        viewControllers = controllers.map { UINavigationController(rootViewController: $0) }
    }
}

