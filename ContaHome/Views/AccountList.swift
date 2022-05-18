//
//  AccountList.swift
//  ContaHome
//
//  Created by Pablo Penalva on 27/4/22.
//

import SwiftUI

struct AccountList: View {
    @Binding var accounts: [Account]
    @Binding var postings: [Posting]
    @Environment(\.scenePhase) private var scenePhase
    
    @State  private var selectedAccount = Account(id: UUID(), number: "", name: "", type: "")
    
    @State private var isPresentingNewAccount = false
    @State private var newAccountData = Account.Data()
    let saveAction: ()->Void
   
    
    
    var body: some View {
        
        List {
            ForEach($accounts) { $account in
                NavigationLink(destination:
                                AccountDetail( account: $account, postings: $postings, accounts: $accounts, selectedAccount: $selectedAccount)) {
                    AccountRow(account: account)
                }
            }
            .onDelete(perform: deleteAccount)
        }
       
        .navigationTitle("Account")
        
        .toolbar {
            Button(action: {
                isPresentingNewAccount = true
            }) {
                Image(systemName: "plus")
            }
            
            Button(action: {
                saveAction()
            }) {
                Image(systemName: "square.and.arrow.down")
            }
            
        }
        .sheet(isPresented: $isPresentingNewAccount) {
            NavigationView {
                AccountEdit(data: $newAccountData)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                isPresentingNewAccount = false
                                newAccountData = Account.Data()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Add") {
                                let newAccount = Account(data: newAccountData)
                                accounts.append(newAccount)
                                isPresentingNewAccount = false
                                newAccountData = Account.Data()
                            }
                        }
                    }
            }
        }
    }
    func deleteAccount( at offsets: IndexSet) {
        accounts.remove(atOffsets:offsets)
    }
}



struct AccountList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AccountList(accounts: .constant(Account.sampleData), postings: .constant(Posting.sampleData), saveAction: {})
        }
    }
}
