//
//  PostingPAndLExecution.swift
//  ContaHome
//
//  Created by Pablo Penalva on 11/1/23.
//

import SwiftUI

struct PostingsPAndLPostingsExecution: View {
    
    @Binding var accounts: [Account]
    @Binding var postings: [Posting]
    @Binding var pAndLLines: [PAndLLine]
    @Binding var selectedLine: PAndLLine
    @Binding var fechaDesde: Date
    @Binding var fechaHasta: Date
    
    @State private var accountCredit: String = ""
    @State private var description: String = ""
    @State private var amountFrom: Double = -99999999.99
    @State private var amountTo: Double = 99999999.99
    
    
    
    var body: some View {
        List {
            VStack {
                ForEach ($selectedLine.accounts) { $item in
                    
                    PostingsExecution(accounts: $accounts, postings: $postings, dateFrom: $fechaDesde, dateTo: $fechaHasta, accountDebit: $item.account, accountCredit:$accountCredit, description: $description, amountFrom: $amountFrom, amountTo: $amountTo)
                    
                }
            }
        }
    }
}

