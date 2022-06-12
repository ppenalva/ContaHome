//
//  Account.swift
//  ContaHome
//
//  Created by Pablo Penalva on 27/4/22.
//

import Foundation

struct Account: Hashable, Codable, Identifiable {
    var id: UUID
    var name: String
    
    init(
        id: UUID = UUID(),
        name: String
    ) {
        self.id = id
        self.name = name
    }
    
}
extension Account {
    
    struct Data {
        var name: String = ""
    }
    
    var data: Data { Data(
        name: name
    )
    }
    
    mutating func update(from data: Data) {
        name = data.name
    }
    
    init(data: Data) {
        id = UUID()
        name = data.name
    }
    
}

extension Account{
    static let sampleData: [Account] =
    [
        Account(
            name: "Cuenta Primera"
        ),
        Account(
            name: "Cuenta Segunda"
        ),
        Account(
            name: "Cuenta Tercera"
        )
        
    ]
}

