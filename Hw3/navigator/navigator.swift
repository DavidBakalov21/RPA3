//
//  navigator.swift
//  Hw3
//
//  Created by david david on 24.10.2024.
//


import Foundation
import UIKit
import Combine
final class Coordinator {
    
    let rootViewController: UINavigationController
    
    private var cancellable: Set<AnyCancellable> = []
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func start() {
        let mainViewController = MenuListViewController(drinks: MenuFetcher.shared.fetchMenu())
        
        mainViewController.outputPublisher
            .sink { [weak self] message in
                switch message {
                case let .drinkSelected(drink):
                    self?.showDetailsViewController(with: drink)
                }
            }
            .store(in: &cancellable)
        
        rootViewController.pushViewController(mainViewController, animated: true)
    }
                   
    func showDetailsViewController(with drink: Drink) {
           let controller = UIViewController()
        controller.view.backgroundColor = .red
        rootViewController.pushViewController(controller, animated: true)
    }
}










