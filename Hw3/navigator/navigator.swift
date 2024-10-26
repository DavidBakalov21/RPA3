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
        let parser = StudentParser(jsonData: "store")
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
        
        let detailsController = StudentDetails(student: student)
        
        detailsController.outputPublisher
            .sink { [weak self] message in
                switch message {
                case let .subjectSelected(student):
                    self?.showSubjectController(with: student)
                }
            }
            .store(in: &cancellable)
        rootViewController.pushViewController(detailsController, animated: true)
    }
    
    func showSubjectController(with subject: String) {
        let parser = StudentParser(jsonData: "store")
        let subjectController = SubjectStudent(subject: subject, students: parser.parseJson()!)
        rootViewController.pushViewController(subjectController, animated: true)
    }
}
