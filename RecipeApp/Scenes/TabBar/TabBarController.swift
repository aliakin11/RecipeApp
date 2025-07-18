//
//  TabBarController.swift
//  RecipeApp
//
//  Created by Ali AKIN on 30.06.2025.
//

import UIKit

class TabBarController: UITabBarController {
            
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        
    }
    
}

// MARK: - Private Methods
private extension TabBarController {
    
    func setupTabs() {
        let recipeVC = createTabBar(
            title: "Home",
            image: UIImage(systemName: "house.fill"),
            viewController: RecipeViewController()
        )
        
        let settingsVC = createTabBar(
            title: "Settings",
            image: UIImage(systemName: "gear"),
            viewController: SettingsViewController()
        )
        
        let favoritesVC = createTabBar(
            title: "Favorites",
            image: UIImage(systemName: "star.fill"),
            viewController: FavoritesViewController()
        )
        
        setViewControllers([recipeVC, favoritesVC, settingsVC], animated: true)
    }
    
    func createTabBar(title: String, image: UIImage?, viewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        viewController.title = title
        navigationController.navigationBar.prefersLargeTitles = true
        
        return navigationController
    }
}

