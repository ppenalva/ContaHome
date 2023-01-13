//
//  BudgetCreditRow.swift
//  ContaHome
//
//  Created by Pablo Penalva on 12/12/22.
//

import SwiftUI

struct BudgetCreditRow: View {
    
    var budget: Budget
    
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    
    var body: some View {
        VStack {
            HStack {
                Text(budget.date, formatter: BudgetDebitRow.taskDateFormat)
                Text(budget.description)
                Spacer()
                
                Text(String(format: "%.2f", budget.creditAmount))
                Text(String(format: "%.2f", budget.debitAmount))
            }
            
            HStack {
                Text(budget.secondAccount)
                Spacer()
            }
        }
    }
}

struct BudgetCreditRow_Previews: PreviewProvider {
    static var budgets = Budget.sampleData
    
    static var previews: some View {
        BudgetCreditRow(budget: budgets[0])
    }
}
