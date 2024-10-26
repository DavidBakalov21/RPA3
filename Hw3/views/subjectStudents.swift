//
//  subjectStudents.swift
//  Hw3
//
//  Created by david david on 25.10.2024.
//

import Foundation
import UIKit
import SnapKit

class SubjectStudent: UIViewController {
    let students: [Student]
    let subjectName = UILabel()
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(StudentCard.self, forCellReuseIdentifier: "studentCard")
        return tableView
    }()
    init(subject: String, students: [Student] ) {
        self.students = students.filter { $0.subjects?.contains(subject) ?? false }
        super.init(nibName: nil, bundle: nil)
        tableView.delegate = self
        tableView.dataSource = self
        subjectName.text = subject
        subjectName.font = subjectName.font.withSize(30)
        setupView()
        makeConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(subjectName)
        view.addSubview(tableView)
    }
    private func makeConstraints() {
        
        subjectName.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(subjectName.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
         
    }
}
extension SubjectStudent: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        students.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "studentCard",
                                                       for: indexPath) as? StudentCard else {
            return UITableViewCell()
        }
        cell.setupCell(with: students[indexPath.row])
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
