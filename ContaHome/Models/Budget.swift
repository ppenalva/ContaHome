//
//  Budget.swift
//  ContaHome
//
//  Created by Pablo Penalva on 11/12/22.
//

import Foundation

struct Budget: Hashable, Codable, Identifiable {
    var id: UUID
    var date: Date
    var description: String
    var firstAccount: String
    var secondAccount: String
    var debitAmount: Double
    var creditAmount: Double
    var cpuDate: Date
    
    init(
        id: UUID = UUID(),
        date: Date,
        description: String,
        firstAccount: String,
        secondAccount: String,
        debitAmount: Double,
        creditAmount: Double,
        cpuDate: Date

    ) {
        self.id = id
        self.date = date
        self.description = description
        self.firstAccount = firstAccount
        self.secondAccount = secondAccount
        self.debitAmount = debitAmount
        self.creditAmount = creditAmount
        self.cpuDate = cpuDate
    }
    
}

extension Budget {
    
    
    
    struct Data {
        var date: Date = dateFormatter.date(from: "2000-01-01") ?? Date.now
        var description: String = " "
        var firstAccount: String = " "
        var secondAccount: String = " "
        var debitAmount: Double = 0.00
        var creditAmount: Double = 0.00
        var cpuDate: Date = Date()
    }
    
    var data: Data { Data(
        date: date,
        description: description,
        firstAccount: firstAccount,
        secondAccount: secondAccount,
        debitAmount: debitAmount,
        creditAmount: creditAmount,
        cpuDate: cpuDate
       )
    }
    
    mutating func update(from data: Data) {
        date = data.date
        description = data.description
        firstAccount = data.firstAccount
        secondAccount = data.secondAccount
        debitAmount = data.debitAmount
        creditAmount = data.creditAmount
        cpuDate = data.cpuDate
    }
    
    
    init(data: Data) {
        id = UUID()
        date = data.date
        description = data.description
        firstAccount = data.firstAccount
        secondAccount = data.secondAccount
        debitAmount = data.debitAmount
        creditAmount = data.creditAmount
        cpuDate = data.cpuDate
    }
}

extension Budget {
    
    
 
    static let sampleData: [Budget] =
    [
        Budget(
            date: dateFormatter.date( from:"2022-04-27") ?? Date(),
            description: "Primer budget",
            firstAccount: "Cuenta Primera",
            secondAccount: "Cuenta Segunda",
            debitAmount: 1000.00,
            creditAmount: 0.0,
            cpuDate: Date()
        ),
        Budget(
            date: dateFormatter.date(from:"2022-04-27") ?? Date(),
            description: "Primer budget",
            firstAccount: "Cuenta Primera",
            secondAccount: "Cuenta Tercera",
            debitAmount: 1000.00,
            creditAmount: 0.0,
            cpuDate: Date()
        ),
        Budget(
            date: dateFormatter.date(from:"2022-04-27") ?? Date(),
            description: "Primer budget",
            firstAccount: "Cuenta Segunda",
            secondAccount: "Cuenta Tercera",
            debitAmount: 1000.00,
            creditAmount: 0.0,
            cpuDate: Date()
        )
        
    ]
}
