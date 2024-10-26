//
//  subjectCell.swift
//  Hw3
//
//  Created by david david on 25.10.2024.
//

import Foundation
import UIKit
import SnapKit

class SubjectCell: UITableViewCell {
    let subjectLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let scoreLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
        setupView()
        setupLayout()
        }
    init() {
        super.init(style: .default, reuseIdentifier: "subjectCard")
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = .gray
        addSubview(subjectLabel)
        addSubview(scoreLabel)
    }
    
    func setupLayout() {
        subjectLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
        }
        scoreLabel.snp.makeConstraints {
            $0.leading.equalTo(subjectLabel.snp.trailing)
            $0.centerY.equalToSuperview()
        }
    }
    
    func setupCell( score: Int, name: String) {
        subjectLabel.text = name+": "
        scoreLabel.text = String(score)
    }

}
