//
//  TabBarController.swift
//  FirebaseApp
//
//  Created by Gizem Zorlu on 24.08.2023.
//

import UIKit

class TabBarController: UIViewController {
    
    var tabBar = UITabBarController()
    var feedVC = FeedVC()
    var uploadVC = UploadVC()
    var settingsVC = SettingsVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
       
        feedVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        uploadVC.tabBarItem = UITabBarItem(title: "Upload", image: UIImage(systemName: "camera"), tag: 1)
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 2)
        tabBar.viewControllers = [feedVC, uploadVC, settingsVC]
    
      
        tabBar.tabBar.tintColor = .black
        tabBar.tabBar.barTintColor = .white
        tabBar.tabBar.layer.borderWidth = 1
        UITabBar.appearance().unselectedItemTintColor = .systemGray
        
        tabBar.tabBar.layer.cornerRadius = 5
        tabBar.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.tabBar.layer.masksToBounds = true
        
        addChild(tabBar)
        view.addSubview(tabBar.view)
       
        tabBar.didMove(toParent: self)
        
        
        
    }
    
  
}

