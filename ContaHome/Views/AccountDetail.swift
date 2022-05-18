//
//  AccountDetail.swift
//  ContaHome
//
//  Created by Pablo Penalva on 27/4/22.
//

import SwiftUI

struct AccountDetail: View {
    
    @Binding var account: Account
    
    @Binding var postings: [Posting]
    @Binding var accounts: [Account]
    @Binding var selectedAccount: Account
    
    
    @State private var isPresentingNewPostingView = false
    @State private var newPostingData = Posting.Data()
    
    var filteredPostings: [Posting] {
        postings.filter { posting in
            (posting.firstAccount == account.number || posting.secondAccount == account.number)
        }
    }
    
    var body: some View {
        List {
            ForEach(filteredPostings) { posting in
                NavigationLink {
                } label: {
                    if (account.number == posting.firstAccount) {
                        PostingDebitRow(posting: posting)
                    } else {
                        PostingCreditRow(posting: posting)
                    }
                }
            }
            .onDelete(perform: deletePosting)
           
        }
        
        .navigationTitle(account.number + " " + account.name)
        .toolbar {
            Button(action: {
                isPresentingNewPostingView = true
            }) {
                Image(systemName: "plus")
            }
        }
        .sheet(isPresented: $isPresentingNewPostingView) {
            NavigationView  {
                PostingEditRow( selectedAccount: $selectedAccount, data: $newPostingData, accounts: $accounts)
                
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                isPresentingNewPostingView = false
                                newPostingData = Posting.Data()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Add") {
                                var newPosting = Posting(data: newPostingData)
                                newPosting.firstAccount = account.number
                                newPosting.firstAccountName = account.name
                                newPosting.secondAccount = selectedAccount.number
                                newPosting.secondAccountName = selectedAccount.name
                                postings.append(newPosting)
                                isPresentingNewPostingView = false
                                newPostingData = Posting.Data()
                            }
                        }
                    }
            }
        }
    }
    func deletePosting( at offsets: IndexSet) {
        postings.remove(atOffsets:offsets)
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
