//
//  TabBarController.swift
//  BankMap
//
//  Created by Александр Янчик on 17.01.23.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
    
    
    private func configureTabBar() {
        
        let mapVC = BankLocationMapController(nibName: "BankLocationMapController", bundle: nil)
        let profileVC = ProfileController(nibName: "ProfileController", bundle: nil)
       
        self.viewControllers = [mapVC,profileVC]
        
        mapVC.tabBarItem = UITabBarItem(title: "Map", image: UIImage(systemName: "map"), tag: 0)
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 1)

        self.tabBar.barTintColor = UIColor(red: 62/255, green: 64/255, blue: 77/255, alpha: 1)
        self.tabBar.tintColor = .black
    }
    
}
