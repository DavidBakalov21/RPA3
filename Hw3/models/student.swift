//
//  student.swift
//  Hw3
//
//  Created by david david on 21.10.2024.
//

import Foundation
struct Student: Codable {
    let id: Int?
    let name: String?
    let age: Int?
    let subjects: [String?]?
    let address: [String: String?]?
    let scores: [String: Int?]?
    let hasScholarship: Bool?
    let graduationYear: Int?
}
