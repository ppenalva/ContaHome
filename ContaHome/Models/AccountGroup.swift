//
//  AccountGroup.swift
//  ContaHome
//
//  Created by Pablo Penalva on 4/5/22.
//

import Foundation


import Foundation

struct AccountGroup: Identifiable, Codable {
    var id: UUID
    var number: String
    var name: String
    var group: [AccountInGroup]
    
    init(
        id: UUID = UUID(),
        number: String,
        name: String,
        group: [String]
    ) {
        self.id = id
        self.number = number
        self.name = name
        self.group = group.map { AccountInGroup(number: $0) }
        
    }
}

extension AccountGroup {
    struct AccountInGroup: Identifiable, Codable {
        let id : UUID
        var number: String
        
        init(id: UUID = UUID(), number: String) {
            self.id = id
            self.number = number
        }
    }

    
    struct Data {
        var number: String = "0000"
        var name: String = ""
        var group: [AccountInGroup] = []
    }
    
    var data: Data { Data(
        number: number,
        name: name,
        group: group)
    }

    mutating func update(from data: Data) {
        number = data.number
        name = data.name
        group = data.group
    }

    init(data: Data) {
        id = UUID()
        number = data.number
        name = data.name
        group = data.group
    }
    
}
extension AccountGroup{
    static let sampleData: [AccountGroup] =
    [
        AccountGroup(
            number: "0001",
            name: "Primer Grupo",
            group: ["1001", "1002"]
        ),
        AccountGroup(
            number: "0002",
            name: "Segundo Grupo",
            group: ["1003"]
        )
    ]
}
