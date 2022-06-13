//
//  MainView.swift
//  PhotosApp
//
//  Created by Eugene on 12.06.2022.
//

import UIKit
import Foundation

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = UIColor.black
        
        tabBar.backgroundColor = UIColor(named: "medium")
        
        let searchVC = Builder.buildSearchModule()
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        let favoriteVC = Builder.buildFavoriteModule()
        favoriteVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        viewControllers = [searchVC, favoriteVC]
    }

}
