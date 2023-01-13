//
//  AccountBudgetList.swift
//  ContaHome
//
//  Created by Pablo Penalva on 12/12/22.
//

import SwiftUI

struct AccountBudgetList: View {
    
    @Binding var accounts: [Account]
    @Binding var budgets: [Budget]
    
    @State private var data = Account.Data()
    
    var body: some View {
        
        List {
            ForEach($accounts) { $account in
                NavigationLink(destination:
                                AccountBudgetDetail( account: $account, budgets: $budgets, accounts: $accounts, selectedBudget: Budget(data: Budget.Data()) )) {
                    AccountRow(account: account)
                }
            }
        }
        
        .navigationTitle("ACCOUNTS")
    }
    }


struct AccountBudgetList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AccountBudgetList(accounts: .constant(Account.sampleData), budgets: .constant(Budget.sampleData))
        }
    }
}
