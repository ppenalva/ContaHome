//
//  PAndLLine.swift
//  ContaHome
//
//  Created by Pablo Penalva on 13/6/22.
//

import Foundation

struct PAndLLine: Hashable, Codable, Identifiable {
    var id: UUID
    var name: String
    var accounts: [AccountsInLine]
    
    init(
        id: UUID = UUID(),
        name: String,
        accounts: [String]
    ) {
        self.id = id
        self.name = name
        self.accounts = accounts.map { AccountsInLine(account: $0 ) }
        
    }
}

extension PAndLLine {
    struct AccountsInLine: Hashable, Identifiable, Codable {
        let id : UUID
        var account: String
        
        init(id: UUID = UUID(), account: String) {
            self.id = id
            self.account = account
        }
    }

    
    struct Data {
        var name: String = ""
        var accounts: [AccountsInLine] = []
    }
    
    var data: Data { Data(
        name: name,
        accounts: accounts)
    }

    mutating func update(from data: Data) {
        name = data.name
        accounts = data.accounts
    }

    init(data: Data) {
        id = UUID()
        name = data.name
        accounts = data.accounts
    }
    
}
extension PAndLLine{
    static let sampleData: [PAndLLine] =
    [
        PAndLLine(
            name: "Sueldos",
            accounts: []
        )
        
    ]
}

