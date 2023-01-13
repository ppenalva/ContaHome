//
//  AccountBudgetDetail.swift
//  ContaHome
//
//  Created by Pablo Penalva on 12/12/22.
//

import SwiftUI

struct AccountBudgetDetail: View {
    
    @Binding var account: Account
    
    @Binding var budgets: [Budget]
    @Binding var accounts: [Account]
    
    @State var selectedBudget: Budget
    
    
    @State private var isPresentingNewBudgetView = false
    @State private var isPresentingEditBudgetView = false
    
    @State private var newBudgetData = Budget.Data()
    @State private var editBudgetData = Budget.Data()
    
    private var filteredBudgets: [Budget] {
        budgets.filter { budget in
            (budget.firstAccount == account.name || budget.secondAccount == account.name)
        }
    }
    
    func importeCuenta ( budgets:[Budget], cuenta: String ) -> Double  {
        
        
        let importe1 = budgets.filter({cuenta == $0.firstAccount}).map{$0.debitAmount}.reduce(0, +)
        let importe2 = budgets.filter({cuenta == $0.firstAccount}).map{$0.creditAmount}.reduce(0, +)
        let importe3 = budgets.filter({cuenta == $0.secondAccount}).map{$0.creditAmount}.reduce(0, +)
        let importe4 = budgets.filter({cuenta == $0.secondAccount}).map{$0.debitAmount}.reduce(0, +)
        
        let importe = importe1 - importe2 + importe3 - importe4
        
        return importe
    }
    
    var body: some View {
        
        List {
            
            ForEach (filteredBudgets) { filteredBudget in
                
                HStack {
                    
                    if (account.name == filteredBudget.firstAccount) {
                        BudgetDebitRow(budget: filteredBudget)
                        
                    } else {
                        BudgetCreditRow(budget: filteredBudget)
                    }
                    
                }
                .onTapGesture {
                    self.selectedBudget = filteredBudget
                    editBudgetData = filteredBudget.data
                    isPresentingEditBudgetView = true
                }
            }
            .onDelete(perform: removeBudget)
            
        }
        .navigationTitle("\(account.name)     \(String(format: "%.2f", importeCuenta(budgets: budgets, cuenta: account.name)))")
        
        .toolbar {
            Button(action: {
                isPresentingNewBudgetView = true
            }) {
                Image(systemName: "plus")
            }
            
        }
        .sheet(isPresented: $isPresentingNewBudgetView) {
            NavigationView  {
                BudgetNewRow( data: $newBudgetData, accounts: $accounts, budgets: $budgets, account: $account)
                
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                isPresentingNewBudgetView = false
                                newBudgetData = Budget.Data()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Add") {
                                var newBudget = Budget(data: newBudgetData)
                                newBudget.firstAccount = account.name
                                newBudget.cpuDate = Date.now
                                budgets.append(newBudget)
                                isPresentingNewBudgetView = false
                                
                                newBudgetData.description = ""
                                newBudgetData.debitAmount = 0.0
                                newBudgetData.creditAmount = 0.0
                                newBudgetData.firstAccount = ""
                                newBudgetData.secondAccount = ""
                            }
                        }
                    }
            }
        }
        
        .sheet(isPresented: $isPresentingEditBudgetView) {
            NavigationView  {
                BudgetEditRow( data: $editBudgetData, accounts: $accounts)
                
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                isPresentingEditBudgetView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Confirm") {
                                let editBudget = Budget(data: editBudgetData)
                                if let index = budgets.firstIndex(of: selectedBudget){
                                    budgets[index] = editBudget
                                }
                                isPresentingEditBudgetView = false
                                
                            }
                        }
                    }
            }
        }
    }
    func removeBudget(at offsets: IndexSet) {
        for offset in offsets {
            if let index = budgets.firstIndex(of: filteredBudgets[offset]) {
                budgets.remove(at: index)
            }
        }
    }
}

//struct AccountDetail_Previews: PreviewProvider {
//    static var accounts = Account.sampleData
//    static var previews: some View {
//        NavigationView {
//            AccountDetail(account: accounts[0], postings: .constant(Posting.sampleData), accounts: .constant(Account.sampleData), selectedAccount: accounts[1] )
//        }
//    }
//}
