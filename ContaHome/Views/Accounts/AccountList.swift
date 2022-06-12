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
    
    @State  private var selectedAccount = Account(id: UUID(), name: "")
    
    @State private var isPresentingNewAccount = false
    @State private var newAccountData = Account.Data()
    
    @State private var amount = 0.0
    
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
            .onMove(perform: moveAccount)
        }
        
    .navigationTitle("ACCOUNTS")
    
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

    
    func deleteAccount( at offsets: IndexSet) {
        accounts.remove(atOffsets:offsets)
    }
    func moveAccount( from source: IndexSet, to destination: Int) {
        accounts.move(fromOffsets: source, toOffset: destination)
    }
}



struct AccountList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AccountList(accounts: .constant(Account.sampleData), postings: .constant(Posting.sampleData),  saveAction: {})
        }
    }
}
