//
//  AppDelegate.swift
//  iAssistiveTouchWindow
//
//  Created by i9400506 on 2021/10/5.
//


// https://medium.com/@jerrywang0420/uiwindow-教學-swift-3-ios-85c2c90093f8

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        window = .init()
//        window?.rootViewController = AssistiveViewController()
//        window?.makeKeyAndVisible()
        
        window = .init()
        let floatingVC: FloatingViewController = .init()
        floatingVC.button.addTarget(self, action: #selector(AppDelegate.floatingButtonWasTapped), for: .touchUpInside)
        window?.rootViewController = floatingVC
        window?.makeKeyAndVisible()
        
        return true
    }
    
    @objc
    private func floatingButtonWasTapped() {
        let alert = UIAlertController(title: "Warning", message: "Don't do that!", preferredStyle: .alert)
        let action = UIAlertAction(title: "Sorry…", style: .default, handler: nil)
        alert.addAction(action)
        window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}
