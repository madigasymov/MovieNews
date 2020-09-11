//
//  AppDelegate.swift
//  MovieNews
//
//  Created by Rustem Madigassymov on 9/9/20.
//  Copyright © 2020 Rustem Madigassymov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let newsController = NewsController(collectionViewLayout: layout)
        let navigationController = UINavigationController(rootViewController: newsController)
        
        window?.rootViewController = navigationController
        
        return true
    }
}

