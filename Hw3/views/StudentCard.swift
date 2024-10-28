import Foundation
import UIKit
import SnapKit

final class StudentCard: UITableViewCell {
    let nameLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let ageLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let ageValueLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let scoreLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let scoreValueLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let scholarshipSign: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .red
        return view
    }()
    
    let scholarshipLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    // https://stackoverflow.com/questions/41475501/creating-a-shadow-for-a-uiimageview-that-has-rounded-corners
    let imageContainer: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        view.clipsToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 10
        view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: 40).cgPath
        return view
    }()
    // https://developer.apple.com/documentation/swift/array/randomelement()
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
                imageView.layer.cornerRadius = 40
                imageView.clipsToBounds = true
                imageView.contentMode = .scaleAspectFill
                
                return imageView
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
        ageLabel.text = "Age:"
        scoreLabel.text = "Score:"
        scholarshipLabel.text = "Scholarship:"
        setupView()
        setupLayout()
        }
    init() {
        super.init(style: .default, reuseIdentifier: "studentCard")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        imageContainer.snp.makeConstraints {
            
            $0.leading.equalToSuperview().offset(10)
            $0.top.equalToSuperview().offset(10)
            $0.width.equalTo(90)
            $0.height.equalTo(90)
            
        }
        studentImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(imageContainer.snp.trailing).offset(30)
            $0.top.equalToSuperview().offset(20)
      
        }
        ageLabel.snp.makeConstraints {
            $0.leading.equalTo(imageContainer.snp.trailing).offset(30)
            $0.top.equalTo(nameLabel.snp.bottom).offset(5)
      
        }
        ageValueLabel.snp.makeConstraints {
            $0.leading.equalTo(ageLabel.snp.trailing)
            $0.top.equalTo(nameLabel.snp.bottom).offset(5)
      
        }
        
        scoreLabel.snp.makeConstraints {
            $0.leading.equalTo(ageValueLabel.snp.trailing).offset(30)
            $0.top.equalTo(nameLabel.snp.bottom).offset(5)
      
        }
        scoreValueLabel.snp.makeConstraints {
            $0.leading.equalTo(scoreLabel.snp.trailing)
            $0.top.equalTo(nameLabel.snp.bottom).offset(5)
        }
        scholarshipLabel.snp.makeConstraints {
            $0.leading.equalTo(imageContainer.snp.trailing).offset(30)
            $0.top.equalTo(ageLabel.snp.bottom).offset(5)
        }
        scholarshipSign.snp.makeConstraints {
            $0.leading.equalTo(scholarshipLabel.snp.trailing).offset(6)
            $0.top.equalTo(ageLabel.snp.bottom).offset(5)
            $0.width.equalTo(20)
            $0.height.equalTo(20)
        }
        }

    func setupView() {
        backgroundColor = .white
        addSubview(nameLabel)
        addSubview(scoreLabel)
        addSubview(scoreValueLabel)
        addSubview(ageLabel)
        addSubview(ageValueLabel)
        addSubview(scholarshipLabel)
        addSubview(scholarshipSign)
        addSubview(imageContainer)
        imageContainer.addSubview(studentImage)
    }
    
    func setupCell(with student: Student) {
        nameLabel.text = {
            if let name=student.name {
                return name
            } else {
                return "unknown"
            }
        }()
        ageValueLabel.text = {
            if let age=student.age {
            return String(age)
        } else {
            return "unknown"
        }
        }()
        scoreValueLabel.text = {
            if let scores = student.scores?.values {
                var scoreFinal = 0
                var amount = 0
                for score in scores {
                   if let score = score {
                       scoreFinal += score
                       amount+=1
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
    }
}

#if DEBUG

import SwiftUI

struct DrinkCell_Previews: PreviewProvider {
    
    static func makeCell() -> StudentCard {
        let cell = StudentCard()
        
        cell.setupCell(with: .init(id: 1,
                                   name: "Vitalik",
                                   age: 21,
                                   subjects: ["Math", "Science", "History"],
                                   address: ["city": "Kyiv", "street": "5"],
                                   scores: ["Math": 95, "Science": 88, "History": 92],
                                   hasScholarship: true,
                                   graduationYear: 2024))
                       
        return cell
    }
    
    static var previews: some View {
        Group {
            makeCell()
                .asPreview()
                .frame(height: 150)
        }
    }
}

extension UIViewController {
    @available(iOS 13, *)
    private struct Preview: UIViewControllerRepresentable {
        var viewController: UIViewController

        func makeUIViewController(context: Context) -> UIViewController {
            viewController
        }

        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            // No-op
        }
    }

    @available(iOS 13, *)
    func asPreview() -> some View {
        Preview(viewController: self)
    }
}

// MARK: - UIView Extensions

extension UIView {
    @available(iOS 13, *)
    private struct Preview: UIViewRepresentable {
        var view: UIView

        func makeUIView(context: Context) -> UIView {
            view
        }

        func updateUIView(_ view: UIView, context: Context) {
            // No-op
        }
    }

    @available(iOS 13, *)
    func asPreview() -> some View {
        Preview(view: self)
    }
}

#endif
