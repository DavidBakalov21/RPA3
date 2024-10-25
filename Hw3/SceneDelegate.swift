//
//  SceneDelegate.swift
//  Hw3
//
//  Created by david david on 21.10.2024.
//

import UIKit
final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: Coordinator?
func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
           options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    let navigationController = UINavigationController()
    let coordinator = Coordinator(rootViewController: navigationController)
    
    let window = UIWindow(windowScene: windowScene)
    window.rootViewController = navigationController
    self.window = window
  self.coordinator = coordinator
    window.makeKeyAndVisible()
    
    coordinator.start()
}
}
