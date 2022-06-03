//
//  Report.swift
//  ContaHome
//
//  Created by Pablo Penalva on 19/5/22.
//

import Foundation

struct Report: Hashable, Codable, Identifiable {
    var id: UUID
    var number: String
    var name: String
    var level1: [Level1InReport]
    
    init(
        id: UUID = UUID(),
        number: String,
        name: String,
        level1: [String]
    ) {
        self.id = id
        self.number = number
        self.name = name
        self.level1 = level1.map { Level1InReport(number: $0) }
        
    }
}

extension Report {
    struct Level1InReport: Hashable, Identifiable, Codable {
        let id : UUID
        var number: String
        
        init(id: UUID = UUID(), number: String) {
            self.id = id
            self.number = number
        }
    }

    
    struct Data {
        var number: String = ""
        var name: String = ""
        var level1: [Level1InReport] = []
    }
    
    var data: Data { Data(
        number: number,
        name: name,
        level1: level1)
    }

    mutating func update(from data: Data) {
        number = data.number
        name = data.name
        level1 = data.level1
    }

    init(data: Data) {
        id = UUID()
        number = data.number
        name = data.name
        level1 = data.level1
    }
    
}
extension Report{
    static let sampleData: [Report] =
    [
        Report(
            number: "01",
            name: "Balance",
            level1: ["10", "20"]
        ),
        Report(
            number: "02",
            name: "Cuenta Resultados",
            level1: ["30", "40", "50"]
        )
    ]
}
