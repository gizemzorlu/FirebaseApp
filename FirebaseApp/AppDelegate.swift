//
//  AppDelegate.swift
//  FirebaseApp
//
//  Created by Gizem Zorlu on 23.08.2023.
//

import UIKit
import Firebase
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
        window = UIWindow()
        
      
        window?.makeKeyAndVisible()
        
        FirebaseApp.configure()
//        FeedVC().getDataFromFirestore()
        
        let currentUser = Auth.auth().currentUser
         
        if currentUser != nil {
            let loginVC = TabBarController()
            loginVC.modalPresentationStyle = .fullScreen
        
            window?.rootViewController = TabBarController()
        }
        
     
        
        return true
    }



}

