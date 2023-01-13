//
//  BudgetsPAndLBudgetsExecution.swift
//  ContaHome
//
//  Created by Pablo Penalva on 12/1/23.
//

import SwiftUI

struct BudgetsPAndLBudgetsExecution: View {
    @Binding var accounts: [Account]
    @Binding var budgets: [Budget]
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
                    
                    BudgetsExecution(accounts: $accounts, budgets: $budgets, dateFrom: $fechaDesde, dateTo: $fechaHasta, accountDebit: $item.account, accountCredit:$accountCredit, description: $description, amountFrom: $amountFrom, amountTo: $amountTo)
                    
                }
            }
        }
    }
}

