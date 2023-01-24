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
        let newsVC = NewsController(nibName: "NewsController", bundle: nil)
        let historyVC = HistoryController(nibName: "HistoryController", bundle: nil)
        
        self.viewControllers = [mapVC, gemVC, metalsVC, newsVC, historyVC]
        
        mapVC.tabBarItem = UITabBarItem(title: "Map", image: UIImage(systemName: "map"), tag: 0)
        gemVC.tabBarItem = UITabBarItem(title: "Gems", image: UIImage(systemName: "diamond.fill"), tag: 1)
        metalsVC.tabBarItem = UITabBarItem(title: "Metals", image: UIImage(systemName: "stop.fill"), tag: 2)
        newsVC.tabBarItem = UITabBarItem(title: "News", image: UIImage(systemName: "newspaper"), tag: 3)
        historyVC.tabBarItem = UITabBarItem(title: "history", image: UIImage(systemName: "books.vertical.fill"), tag: 4)


        self.tabBar.barTintColor = UIColor(red: 62/255, green: 64/255, blue: 77/255, alpha: 1)
        self.tabBar.tintColor = .black
    }
    
}
