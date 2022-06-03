//
//  Level2.swift
//  ContaHome
//
//  Created by Pablo Penalva on 19/5/22.
//

import Foundation

struct Level2: Hashable, Codable, Identifiable {
    var id: UUID
    var number: String
    var name: String
    var accounts: [AccountsInLevel2]
    
    init(
        id: UUID = UUID(),
        number: String,
        name: String,
        accounts: [String]
    ) {
        self.id = id
        self.number = number
        self.name = name
        self.accounts = accounts.map { AccountsInLevel2(number: $0) }
        
    }
}

extension Level2 {
    struct AccountsInLevel2: Hashable, Identifiable, Codable {
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
        var accounts: [AccountsInLevel2] = []
    }
    
    var data: Data { Data(
        number: number,
        name: name,
        accounts: accounts)
    }

    mutating func update(from data: Data) {
        number = data.number
        name = data.name
        accounts = data.accounts
    }

    init(data: Data) {
        id = UUID()
        number = data.number
        name = data.name
        accounts = data.accounts
    }
    
}
extension Level2{
    static let sampleData: [Level2] =
    [
        Level2(
            number: "101",
            name: "Caja y Cuentas de Bancos",
            accounts: ["10101", "10102","10103","10104"]
        ),
        Level2(
            number: "102",
            name: "Otros Activos",
            accounts: ["10201", "10202","10203","10204","10205","10206","10206"]
        ),
        Level2(
            number: "201",
            name: "Prestamos",
            accounts: [""]
        ),
        Level2(
            number: "202",
            name: "Capital",
            accounts: ["20201", "30101","30102", "40101","40102","40103","40104","40201",
                    "40301","40301","40302","40401","40402","40402","40403"]
        ),
        Level2(
            number: "301",
            name: "Entradas",
            accounts: ["30101","30102"]
        ),
        Level2(
            number: "401",
            name: "Compras",
            accounts: ["40101","40102","40103","40104"]
        ),
        Level2(
            number: "402",
            name: "Otros Gastos",
            accounts: ["40201"]
        ),
        Level2(
            number: "403",
            name: "Vehiculos",
            accounts: ["40301","40302"]
        ),
        Level2(
            number: "404",
            name: "Vivienda",
            accounts: ["40401","40402","40403"]
        ),
        Level2(
            number: "501",
            name: "Neto",
            accounts: [ "30101","30102", "40101","40102","40103","40104","40201",
                    "40301","40301","40302","40401","40402","40402","40403"]
        )
    ]
}

