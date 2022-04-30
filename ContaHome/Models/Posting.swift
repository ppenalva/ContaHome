//
//  Posting.swift
//  ContaHome
//
//  Created by Pablo Penalva on 27/4/22.
//

import Foundation

struct Posting: Hashable, Codable, Identifiable {
    var id: Int
    var number: String
    var date: String
    var description: String
    var firstAccount: String
    var firstAccountName: String
    var secondAccount: String
    var secondAccountName: String
    var debitAmount: Double
    var creditAmount: Double
    }
