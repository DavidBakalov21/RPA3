//
//  ViewController.swift
//  Hw3
//
//  Created by david david on 21.10.2024.
//

import UIKit
import SnapKit
import Combine

enum StudentListViewControllerOutputMessage {
    case studentSelected(Student)
}
class StudentListViewController: UIViewController {
    private let _outputPublisher = PassthroughSubject<StudentListViewControllerOutputMessage, Never>()
        var outputPublisher: AnyPublisher<StudentListViewControllerOutputMessage, Never> {
            _outputPublisher.eraseToAnyPublisher()
        }
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(StudentCard.self, forCellReuseIdentifier: "studentCard")
        return tableView
    }()
    let titleText = UILabel()
    var names: [Student]?
    init(studs: [Student]) {
        self.names = studs
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
       // https://stackoverflow.com/questions/24356888/how-do-i-change-the-font-size-of-a-uilabel-in-swift
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        titleText.text = "Students"
        titleText.font = titleText.font.withSize(30)
        view.backgroundColor = UIColor.white
        view.addSubview(tableView)
        view.addSubview(titleText)
        titleText.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.centerX.equalToSuperview()
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(titleText.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }

}
extension StudentListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        names!.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "studentCard",
                                                       for: indexPath) as? StudentCard else {
            return UITableViewCell()
        }
        cell.setupCell(with: names![indexPath.row])
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _outputPublisher.send(.studentSelected(names![indexPath.row]))
    }
}
