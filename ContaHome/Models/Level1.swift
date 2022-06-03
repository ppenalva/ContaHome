//
//  Level1.swift
//  ContaHome
//
//  Created by Pablo Penalva on 19/5/22.
//

import Foundation

struct Level1: Hashable, Codable, Identifiable {
    var id: UUID
    var number: String
    var name: String
    var level2: [Level2InLevel1]
    
    init(
        id: UUID = UUID(),
        number: String,
        name: String,
        level2: [String]
    ) {
        self.id = id
        self.number = number
        self.name = name
        self.level2 = level2.map { Level2InLevel1(number: $0) }
        
    }
}

extension Level1 {
    struct Level2InLevel1: Hashable, Identifiable, Codable {
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
        var level2: [Level2InLevel1] = []
    }
    
    var data: Data { Data(
        number: number,
        name: name,
        level2: level2)
    }

    mutating func update(from data: Data) {
        number = data.number
        name = data.name
        level2 = data.level2
    }

    init(data: Data) {
        id = UUID()
        number = data.number
        name = data.name
        level2 = data.level2
    }
    
}
extension Level1{
    static let sampleData: [Level1] =
    [
        Level1(
            number: "10",
            name: "Activos",
            level2: ["101", "102"]
        ),
        Level1(
            number: "20",
            name: "Pasivos y Capital",
            level2: ["201", "202"]
        ),
        Level1(
            number: "30",
            name: "Entradas",
            level2: ["301"]
        ),
        Level1(
            number: "40",
            name: "Salidas",
            level2: ["401", "402","403" , "404"]
        ),
        Level1(
            number: "50",
            name: "Resultado",
            level2: ["501"]
        )
    ]
}

