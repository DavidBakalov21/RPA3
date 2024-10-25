//
//  deatialsScreen.swift
//  Hw3
//
//  Created by david david on 24.10.2024.
//

import Foundation
import UIKit
import SnapKit

class StudentDetails: UIViewController {
    let student: Student
    // name
    let nameVal=UILabel()
    
    // age
    let ageText=UILabel()
    let ageValue=UILabel()
    
    // score
    let scoreText=UILabel()
    let scoreValue=UILabel()
    
    // address
    let addressText=UILabel()
    let addressValue=UILabel()
    
    // schollarship
    let scholarshipSign: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 30
        view.backgroundColor = .red
        return view
    }()
    
    // image
    let studentImage: UIImageView = {
        let imageView = UIImageView()
        let imageNames = ["npc1", "npc2", "npc3"]
        let randImage = imageNames.randomElement()!
                if let imageUrl = Bundle.main.url(forResource: randImage, withExtension: "png"),
                   let image = UIImage(contentsOfFile: imageUrl.path) {
                    imageView.image = image
                } else {
                    imageView.backgroundColor = .red
                }
        // https://stackoverflow.com/questions/29616992/how-do-i-draw-a-circle-in-ios-swift
                imageView.layer.cornerRadius = 15
                imageView.clipsToBounds = true
                imageView.contentMode = .scaleAspectFill
                
                return imageView
    }()
    // Subjects
    let subjectTable: UITableView = {
        let tableView=UITableView()
        tableView.register(SubjectCell.self, forCellReuseIdentifier: "subjectCard")
        return tableView
    }()
    
    init(student: Student) {
        self.student = student
        super.init(nibName: nil, bundle: nil)
        subjectTable.delegate = self
        subjectTable.dataSource = self
        ageText.text="age:"
        scoreText.text="score:"
        addressText.text="address:"
        nameVal.font = nameVal.font.withSize(45)
        
        ageText.font = nameVal.font.withSize(20)
        scoreText.font = nameVal.font.withSize(20)
        addressText.font = nameVal.font.withSize(20)
        ageValue.font = nameVal.font.withSize(20)
        scoreValue.font = nameVal.font.withSize(20)
        addressValue.font = addressValue.font.withSize(20)
        setupUI()
        setupView()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(nameVal)
        view.addSubview(scoreText)
        view.addSubview(scoreValue)
        view.addSubview(ageText)
        view.addSubview(ageValue)
        studentImage.addSubview(scholarshipSign)
        view.addSubview(studentImage)
        view.addSubview(addressText)
        view.addSubview(addressValue)
        view.addSubview(subjectTable)
    }
    private func setupUI() {
        nameVal.text = {
            if let name=student.name {
                return name
            } else {
                return "unknown"
            }
        }()
        ageValue.text = {
            if let age=student.age {
            return String(age)
        } else {
            return "unknown"
        }
        }()
        scoreValue.text = {
            if let scores = student.scores?.values {
                var scoreFinal = 0
                var amount = 0
                for score in scores {
                   if let score = score {
                       scoreFinal += score
                       amount += 1
                   }
                }
                return String(scoreFinal/amount)
            } else {
               return "unknown"
            }
        }()
        scholarshipSign.backgroundColor = {
            if let scholarship = student.hasScholarship {
                return scholarship ? .green : .red
            } else {
                return .red
            }
        }()
        
        addressValue.text = {
            // https://developer.apple.com/documentation/swift/dictionary/compactmapvalues(_:)
            if let address = student.address {
                let addressString =  address.compactMapValues { $0 }.values.joined(separator: ", ")
                return addressString.isEmpty ? "unknown" : addressString
            } else {
                return "unknown"
            }
        }()
    }
    private func makeConstraints() {
        
        studentImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.width.equalTo(310)
            $0.height.equalTo(310)
        }
        
        nameVal.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(studentImage.snp.bottom).offset(20)
        }
        
        ageText.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(nameVal.snp.bottom).offset(15)
      
        }
        ageValue.snp.makeConstraints {
            $0.leading.equalTo(ageText.snp.trailing)
            $0.top.equalTo(nameVal.snp.bottom).offset(15)
      
        }
        
        scoreText.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(ageText.snp.bottom).offset(10)
      
        }
        scoreValue.snp.makeConstraints {
            $0.leading.equalTo(scoreText.snp.trailing)
            $0.top.equalTo(ageText.snp.bottom).offset(10)
        }
        addressText.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(scoreText.snp.bottom).offset(10)
        }
        
        addressValue.snp.makeConstraints {
            $0.leading.equalTo(addressText.snp.trailing)
            $0.top.equalTo(scoreText.snp.bottom).offset(10)
        }
        scholarshipSign.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.width.equalTo(60)
            $0.height.equalTo(60)
        }
        subjectTable.snp.makeConstraints {
            $0.top.equalTo(addressText.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
    }
}
extension StudentDetails: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        student.subjects?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "subjectCard",
                                                       for: indexPath) as? SubjectCell else {
            return UITableViewCell()
        }
        if let subj = student.subjects, let score = student.scores {
            let cleanArray = subj.compactMap { $0 }
            let cleanDict = score.compactMapValues { $0 }
            cell.setupCell(score: cleanDict[cleanArray[indexPath.row]] ?? 0, name: cleanArray[indexPath.row])
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // _outputPublisher.send(.studentSelected(names![indexPath.row]))
    }
}
