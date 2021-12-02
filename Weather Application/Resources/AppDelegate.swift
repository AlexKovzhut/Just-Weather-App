//
//  AppDelegate.swift
//  Just Weather App
//
//  Created by Alexander Kovzhut on 04.07.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        let weatherVC = WeatherViewController()
        let weatherNavVC = UINavigationController(rootViewController: weatherVC)
        
        window?.rootViewController = weatherNavVC
        
        return true
    }
}

