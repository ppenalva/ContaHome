//
//  Account.swift
//  ContaHome
//
//  Created by Pablo Penalva on 27/4/22.
//

import Foundation

struct Account: Hashable, Codable, Identifiable {
    var id: Int
    var number: String
    var name: String
    var type: String
    }
