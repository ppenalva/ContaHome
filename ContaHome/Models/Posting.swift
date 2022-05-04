//
//  Posting.swift
//  ContaHome
//
//  Created by Pablo Penalva on 27/4/22.
//

import Foundation

let dateFormatter = DateFormatter()
 //    dateFormatter.dateFormat = "YYYY-MM-dd"


struct Posting: Hashable, Codable, Identifiable {
    let id: UUID
    var number: String
    var date: Date
    var description: String
    var firstAccount: String
    var firstAccountName: String
    var secondAccount: String
    var secondAccountName: String
    var debitAmount: Double
    var creditAmount: Double
    
    init(
        id: UUID = UUID(),
        number: String,
        date: Date,
        description: String,
        firstAccount: String,
        firstAccountName: String,
        secondAccount: String,
        secondAccountName: String,
        debitAmount: Double,
        creditAmount: Double
    ) {
        self.id = id
        self.number = number
        self.date = date
        self.description = description
        self.firstAccount = firstAccount
        self.firstAccountName = firstAccountName
        self.secondAccount = secondAccount
        self.secondAccountName = secondAccountName
        self.debitAmount = debitAmount
        self.creditAmount = creditAmount
        
    }
    
}



    



extension Posting {
    
    
    
    struct Data {
        var number: String = "0000"
        var date: Date = dateFormatter.date(from: "2000-01-01") ?? Date()
        var description: String = " "
        var firstAccount: String = " "
        var firstAccountName: String = " "
        var secondAccount: String = " "
        var secondAccountName: String = " "
        var debitAmount: Double = 0.00
        var creditAmount: Double = 0.00
    }
    
    var dataPosting: Data { Data(
        number: number,
        date: date,
        description: description,
        firstAccount: firstAccount,
        firstAccountName: firstAccountName,
        secondAccount: secondAccount,
        secondAccountName: secondAccountName,
        debitAmount: debitAmount,
        creditAmount: creditAmount)
    }
    
    mutating func update(from dataPosting: Data) {
        number = dataPosting.number
        date = dataPosting.date
        description = dataPosting.description
        firstAccount = dataPosting.firstAccount
        firstAccountName = dataPosting.firstAccountName
        secondAccount = dataPosting.secondAccount
        secondAccountName = dataPosting.secondAccountName
        debitAmount = dataPosting.debitAmount
        creditAmount = dataPosting.creditAmount
    }
    
    init(dataPosting: Data) {
        id = UUID()
        number = dataPosting.number
        date = dataPosting.date
        description = dataPosting.description
        firstAccount = dataPosting.firstAccount
        firstAccountName = dataPosting.firstAccountName
        secondAccount = dataPosting.secondAccount
        secondAccountName = dataPosting.secondAccountName
        debitAmount = dataPosting.debitAmount
        creditAmount = dataPosting.creditAmount
    }
    
}

extension Posting {
    
    
 
    static let sampleData: [Posting] =
    [
        Posting(
            number: "0001",
            date: dateFormatter.date( from:"2022-04-27") ?? Date(),
            description: "Primer posting",
            firstAccount: "1001",
            firstAccountName: "Cuenta Primera",
            secondAccount: "1002",
            secondAccountName: "Cuenta Segunda",
            debitAmount: 1000.00,
            creditAmount: 0.00
        ),
        Posting(
            number: "0002",
            date: dateFormatter.date(from:"2022-04-27") ?? Date(),
            description: "Primer posting",
            firstAccount: "1001",
            firstAccountName: "Cuenta Primera",
            secondAccount: "1003",
            secondAccountName: "Cuenta Tercera",
            debitAmount: 1000.00,
            creditAmount: 0.00
        ),
        Posting(
            number: "0003",
            date: dateFormatter.date(from:"2022-04-27") ?? Date(),
            description: "Primer posting",
            firstAccount: "1002",
            firstAccountName: "Cuenta Segunda",
            secondAccount: "1003",
            secondAccountName: "Cuenta Tercera",
            debitAmount: 1000.00,
            creditAmount: 0.00
        )
        
    ]
}
