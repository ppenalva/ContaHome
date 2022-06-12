//
//  Balance.swift
//  ContaHome
//
//  Created by Pablo Penalva on 6/6/22.
//

import Foundation

struct BalanceLine: Hashable, Codable, Identifiable {
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

extension BalanceLine {
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
extension BalanceLine{
    static let sampleData: [BalanceLine] =
    [
        BalanceLine(
            name: "ACTIVOS",
            accounts: []
        ),
        BalanceLine(
            name: "Caja y Cuentas de Bancos",
            accounts: []
        ),
        
        BalanceLine(
            name: "La Caixa",
            accounts: ["Cuenta uno"]
        ),
        
        BalanceLine(
            name: "Banco de Sabadell",
            accounts: ["Cuenta dos"]
        ),

        BalanceLine(
            name: "Total Caja y Cuentas de Bancos",
            accounts: ["Cuenta uno","Cuenta dos"]
        ),
        
        BalanceLine(
            name: "Otros Activos",
            accounts: []
        ),
        
        BalanceLine(
            name: "Barca",
            accounts: ["Cuenta tres"]
        ),
        
        BalanceLine(
            name: "Piso Mallorca 164",
            accounts: ["Cuenta cuatro"]
        ),
        
        BalanceLine(
            name: "Total otros activos",
            accounts: ["Cuenta tres","Cuenta cuatro"]
        ),
        
        BalanceLine(
            name: "TOTAL ACTIVOS",
            accounts: ["Cuenta uno","Cuenta dos","Cuenta tres","Cuenta cuatro"]
        ),
        
        BalanceLine(
            name: "DEUDAS Y CAPITAL",
            accounts: []
        ),
        
        BalanceLine(
            name: "Deudas",
            accounts: []
        ),
        
        BalanceLine(
            name: "Capital",
            accounts: ["Cuenta cinco"]
        )
    ]
}

