//
//  BudgetDebitRow.swift
//  ContaHome
//
//  Created by Pablo Penalva on 12/12/22.
//

import SwiftUI

struct BudgetDebitRow: View {
    
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
                
                    Text(String(format: "%.2f", budget.debitAmount))
                    Text(String(format: "%.2f", budget.creditAmount))
                            }
            HStack {
                Text(budget.secondAccount)
                Spacer()
                
            }
            
        }
    }
}

struct BudgetDebitRow_Previews: PreviewProvider {
    static var budgets = Budget.sampleData
    
    static var previews: some View {
        BudgetDebitRow(budget: budgets[0])
    }
}
