//
//  Account.swift
//  ContaHome
//
//  Created by Pablo Penalva on 27/4/22.
//

import Foundation

struct Account: Hashable, Codable, Identifiable {
    var id: UUID
    var number: String
    var name: String
    var type: String
    
    init(
        id: UUID = UUID(),
        number: String,
        name: String,
        type: String
    ) {
        self.id = id
        self.number = number
        self.name = name
        self.type = type
    }
    
}
extension Account {
    
    struct Data {
        var number: String = "0000"
        var name: String = ""
        var type: String = ""
    }
    
    var data: Data { Data(
        number: number,
        name: name,
        type: type
    )
    }
    
    mutating func update(from data: Data) {
        number = data.number
        name = data.name
        type = data.type
    }
    
    init(data: Data) {
        id = UUID()
        number = data.number
        name = data.name
        type = data.type
    }
    
}

extension Account{
    static let sampleData: [Account] =
    [
        Account(
            number: "1001",
            name: "Cuenta Primera",
            type: "B"
        ),
        Account(
            number: "1002",
            name: "Cuenta Segunda",
            type: "B"
        ),
        Account(
            number: "1003",
            name: "Cuenta Tercera",
            type: "P"
        )
        
    ]
}

