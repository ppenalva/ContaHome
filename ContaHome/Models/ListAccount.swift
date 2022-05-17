//
//  ListAccount.swift
//  ContaHome
//
//  Created by Pablo Penalva on 10/5/22.
//

import Foundation

struct ListAccount: Identifiable {
    var id: UUID
    var number: String
    var name: String
    var amount: Double
    
    init(
        id: UUID = UUID(),
        number: String,
        name: String,
        amount: Double
    ) {
        self.id = id
        self.number = number
        self.name = name
        self.amount = amount
    }
    mutating func update(from listAccount: ListAccount) {
        number = listAccount.number
        name = listAccount.name
        amount = listAccount.amount
    }
}

extension ListAccount{
    static let sampleData: [ListAccount] =
    [
        ListAccount(
            number: "0000",
            name: "",
            amount: 0.0
        )
    ]
}
