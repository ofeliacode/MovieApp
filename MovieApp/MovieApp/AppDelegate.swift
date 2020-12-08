//
//  AppDelegate.swift
//  MovieApp
//
//  Created by Офелия Баширова on 28.10.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let vc = ViewController()
        window?.rootViewController = UINavigationController(rootViewController: vc)
        
       // print(Realm.Configuration.defaultConfiguration.fileURL)
       // FirebaseApp.configure()
        return true
    }
}

