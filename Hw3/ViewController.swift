//
//  ViewController.swift
//  Hw3
//
//  Created by david david on 21.10.2024.
//

import UIKit
import SnapKit

final class StudentParser {
    var jsonData: String
    struct JSONStruct: Codable {
            let students: [Student]
        }
    init(jsonData: String) {
           self.jsonData = jsonData
       }
    public func parseJson() -> [Student]? {
        // https://stackoverflow.com/questions/24410881/reading-in-a-json-file-using-swift
        if let jsonUrl = Bundle.main.url(forResource: jsonData, withExtension: "json") {
            do {
                let data = try Data(contentsOf: jsonUrl)
           
                let students = try JSONDecoder().decode(JSONStruct.self, from: data)
                let finalRes = students.students
                return finalRes
            } catch {
                return nil
            }
        } else {
            return nil
        }
         
        }
}

class ViewController: UIViewController {
    let tableView: UITableView = {
        let tableView=UITableView()
        tableView.register(StudentCard.self, forCellReuseIdentifier: "studentCard")
        return tableView
    }()
    let titleText=UILabel()
    var names: [Student]?
    override func viewDidLoad() {
        let parser=StudentParser(jsonData: "store")
        names = parser.parseJson()
       // https://stackoverflow.com/questions/24356888/how-do-i-change-the-font-size-of-a-uilabel-in-swift
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        titleText.text="Students"
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
extension ViewController: UITableViewDataSource {
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
}

    extension ViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           
        }
    }
