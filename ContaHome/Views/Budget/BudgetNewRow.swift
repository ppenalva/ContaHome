//
//  BudgetNewRow.swift
//  ContaHome
//
//  Created by Pablo Penalva on 12/12/22.
//

import Foundation
import SwiftUI

struct BudgetNewRow: View {
    
    @Binding var data: Budget.Data
    @Binding var accounts: [Account]
    @Binding var budgets: [Budget]
    @Binding var account: Account
    
    @StateObject var viewModel: AmountFormulaViewModel = .init()
    
    var body: some View {
        
        VStack {
            HStack {
                
                DatePicker ("Date", selection: $data.date, in:...Date(), displayedComponents: .date)
                    .frame(minWidth: 150, idealWidth: 150, maxWidth: 150, minHeight: 20, idealHeight: 20, maxHeight: 20)
                
                TextField("Description", text: $data.description)
                    .frame(minWidth: 200, idealWidth: 800, maxWidth: 1000, minHeight: 20, idealHeight: 20, maxHeight: 20)
                
                Spacer()
                
                TextField("Debit Amount", value: $data.debitAmount, format: .number)
                    .frame(minWidth: 100, idealWidth: 150, maxWidth: 200, minHeight: 20, idealHeight: 20, maxHeight: 20)
                TextField("Credit Amount", value: $data.creditAmount, format: .number)
                    .frame(minWidth: 100, idealWidth: 150, maxWidth: 200, minHeight: 20, idealHeight: 20, maxHeight: 20)
            }
            .frame(width: 600, height: 40)
            
            HStack {
                Spacer()
                
                TextField("Formula Debit Amount", text: $viewModel.expresionDebitAmount)
                    .onSubmit {
                        data.debitAmount = viewModel.evaluateDebitFormula()
                    }
                    .frame(minWidth: 100, idealWidth: 150, maxWidth: 200, minHeight: 20, idealHeight: 20, maxHeight: 20)
                TextField("Formula Credit Amount", text: $viewModel.expresionCreditAmount)
                    .onSubmit {
                        data.creditAmount = viewModel.evaluateCreditFormula()
                    }
                    .frame(minWidth: 100, idealWidth: 150, maxWidth: 200, minHeight: 20, idealHeight: 20, maxHeight: 20)
            }
            .frame(width: 600, height: 40)
            
            HStack {
                Picker("Account", selection: $data.secondAccount) {
                    ForEach(accounts, id: \.self) {account in
                        Text(account.name) .tag(account.name )
                            .frame(minWidth: 400, idealWidth: 600, maxWidth: 800, minHeight: 20, idealHeight: 20, maxHeight: 20)
                    }
                }
                Spacer()
            }
            .frame(width: 650, height: 40)
        }
        .frame(width: 700, height: 150)
    }
}


struct BudgetNewRow_Previews: PreviewProvider {
    static var budgets = Budget.sampleData
    
    static var previews: some View {
        BudgetCreditRow(budget: budgets[0])
    }
}
