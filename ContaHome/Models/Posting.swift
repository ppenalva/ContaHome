//
//  Posting.swift
//  ContaHome
//
//  Created by Pablo Penalva on 27/4/22.
//

import Foundation

let dateFormatter = DateFormatter()



struct Posting: Hashable, Codable, Identifiable {
    let id: UUID
    var date: Date
    var description: String
    var firstAccount: String
    var secondAccount: String
    var debitAmount: Double
    var creditAmount: Double
    
    init(
        id: UUID = UUID(),
        date: Date,
        description: String,
        firstAccount: String,
        secondAccount: String,
        debitAmount: Double,
        creditAmount: Double

    ) {
        self.id = id
        self.date = date
        self.description = description
        self.firstAccount = firstAccount
        self.secondAccount = secondAccount
        self.debitAmount = debitAmount
        self.creditAmount = creditAmount
    }
    
}

extension Posting {
    
    
    
    struct Data {
        var date: Date = dateFormatter.date(from: "2000-01-01") ?? Date()
        var description: String = " "
        var firstAccount: String = " "
        var secondAccount: String = " "
        var debitAmount: Double = 0.00
        var creditAmount: Double = 0.00
    }
    
    var data: Data { Data(
        date: date,
        description: description,
        firstAccount: firstAccount,
        secondAccount: secondAccount,
        debitAmount: debitAmount,
        creditAmount: creditAmount
       )
    }
    
    mutating func update(from data: Data) {
        date = data.date
        description = data.description
        firstAccount = data.firstAccount
        secondAccount = data.secondAccount
        debitAmount = data.debitAmount
        creditAmount = data.creditAmount
    }
    
    
    init(data: Data) {
        id = UUID()
        date = data.date
        description = data.description
        firstAccount = data.firstAccount
        secondAccount = data.secondAccount
        debitAmount = data.debitAmount
        creditAmount = data.creditAmount
    }
}

extension Posting {
    
    
 
    static let sampleData: [Posting] =
    [
        Posting(
            date: dateFormatter.date( from:"2022-04-27") ?? Date(),
            description: "Primer posting",
            firstAccount: "Cuenta Primera",
            secondAccount: "Cuenta Segunda",
            debitAmount: 1000.00,
            creditAmount: 0.0
        ),
        Posting(
            date: dateFormatter.date(from:"2022-04-27") ?? Date(),
            description: "Primer posting",
            firstAccount: "Cuenta Primera",
            secondAccount: "Cuenta Tercera",
            debitAmount: 1000.00,
            creditAmount: 0.0
        ),
        Posting(
            date: dateFormatter.date(from:"2022-04-27") ?? Date(),
            description: "Primer posting",
            firstAccount: "Cuenta Segunda",
            secondAccount: "Cuenta Tercera",
            debitAmount: 1000.00,
            creditAmount: 0.0
        )
        
    ]
}
