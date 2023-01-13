//
//  PostingListExecution.swift
//  ContaHome
//
//  Created by Pablo Penalva on 11/1/23.
//

import SwiftUI

struct PostingListExecution: View {
    
    @Binding var accounts: [Account]
    @Binding var postings: [Posting]
    @Binding var dateFrom: Date
    @Binding var dateTo: Date
    @Binding var accountDebit: String
    @Binding var accountCredit: String
    @Binding var description: String
    @Binding var amountFrom: Double
    @Binding var amountTo: Double
    
    var body: some View {
        List {
            VStack {
               
                    
                PostingsExecution(accounts: $accounts, postings: $postings, dateFrom: $dateFrom, dateTo: $dateTo, accountDebit: $accountDebit, accountCredit:$accountCredit, description: $description, amountFrom: $amountFrom, amountTo: $amountTo)
                    
                
            }
        }
    }
}

