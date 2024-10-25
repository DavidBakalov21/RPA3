//
//  navigator.swift
//  Hw3
//
//  Created by david david on 24.10.2024.
//

import Foundation
import UIKit
import Combine
import SnapKit
final class Coordinator {
    
    let rootViewController: UINavigationController
    
    private var cancellable: Set<AnyCancellable> = []
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func start() {
        let parser=StudentParser(jsonData: "store")
        let mainViewController = StudentListViewController(studs: parser.parseJson()!)
        
        mainViewController.outputPublisher
            .sink { [weak self] message in
                switch message {
                case let .studentSelected(student):
                    self?.showDetailsViewController(with: student)
                }
            }
            .store(in: &cancellable)
        
        rootViewController.pushViewController(mainViewController, animated: true)
    }
                   
    func showDetailsViewController(with student: Student) {
        
        let sss = StudentDetails(student: student)
           let controller = UIViewController()
        let titleText=UILabel()
        titleText.text=student.name
        controller.view.addSubview(titleText)
        controller.view.backgroundColor = .red
        titleText.snp.makeConstraints {
            $0.top.equalTo(controller.view.safeAreaLayoutGuide.snp.top)
            $0.centerX.equalToSuperview()
        }
        
        rootViewController.pushViewController(sss, animated: true)
    }
}
