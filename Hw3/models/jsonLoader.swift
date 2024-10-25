//
//  jsonLoader.swift
//  Hw3
//
//  Created by david david on 24.10.2024.
//

import Foundation
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
