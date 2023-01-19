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
        let gemVC = GemsController(nibName: "GemsController", bundle: nil)
        let metalsVC = MetalsController(nibName: "MetalsController", bundle: nil)
        
        self.viewControllers = [mapVC, gemVC, metalsVC]
        
        mapVC.tabBarItem = UITabBarItem(title: "Map", image: UIImage(systemName: "map"), tag: 0)
        gemVC.tabBarItem = UITabBarItem(title: "Gems", image: UIImage(systemName: "diamond.fill"), tag: 1)
        metalsVC.tabBarItem = UITabBarItem(title: "Metals", image: UIImage(systemName: "stop.fill"), tag: 2)

        self.tabBar.barTintColor = UIColor(red: 62/255, green: 64/255, blue: 77/255, alpha: 1)
        self.tabBar.tintColor = .black
    }
    
}
