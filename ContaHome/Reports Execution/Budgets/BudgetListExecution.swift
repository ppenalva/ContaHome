//
//  BudgetListExecution.swift
//  ContaHome
//
//  Created by Pablo Penalva on 12/1/23.
//

import SwiftUI

struct BudgetListExecution: View {
    @Binding var accounts: [Account]
    @Binding var budgets: [Budget]
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
               
                    
                BudgetsExecution(accounts: $accounts, budgets: $budgets, dateFrom: $dateFrom, dateTo: $dateTo, accountDebit: $accountDebit, accountCredit:$accountCredit, description: $description, amountFrom: $amountFrom, amountTo: $amountTo)
                    
                
            }
        }
    }
}
