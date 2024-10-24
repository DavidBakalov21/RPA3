//
//  SceneDelegate.swift
//  Hw3
//
//  Created by david david on 21.10.2024.
//

import UIKit
final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

func scene(_ scene: UIScene, willConnectTo session: UISceneSession, 
           options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
                
                let window = UIWindow(windowScene: windowScene)
                window.rootViewController = ViewController() // Replace with your initial view controller
                self.window = window
                window.makeKeyAndVisible()
    }
}
