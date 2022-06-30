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
    @State private var isPresentingEditPostingView = false
    
    
    @State private var newPostingData = Posting.Data()
    @State private var selectedPostingData = Posting.Data()
    
    private var filteredPostings: [Posting] {
        postings.filter { posting in
            (posting.firstAccount == account.name || posting.secondAccount == account.name)
        }
    }
    
    var body: some View {
        
        List {
            
            ForEach(filteredPostings) { filteredPosting in
                
                if (account.name == filteredPosting.firstAccount) {
                    PostingDebitRow(posting: filteredPosting)
                } else {
                    PostingCreditRow(posting: filteredPosting)
                }
            }
            .onDelete(perform: removePosting)
        }
        
        
        
        .navigationTitle(account.name)
        .toolbar {
            Button(action: {
                isPresentingNewPostingView = true
            }) {
                Image(systemName: "plus")
            }
            
        }
        .sheet(isPresented: $isPresentingNewPostingView) {
            NavigationView  {
                PostingNewRow( data: $newPostingData, accounts: $accounts, postings: $postings, account: $account)
                
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
                                newPosting.firstAccount = account.name
                                newPosting.cpuDate = Date.now
                                postings.append(newPosting)
                                isPresentingNewPostingView = false
                                //                            newPostingData = Posting.Data()
                                newPostingData.description = ""
                                newPostingData.debitAmount = 0.0
                                newPostingData.creditAmount = 0.0
                                newPostingData.firstAccount = ""
                                newPostingData.secondAccount = ""
                            }
                        }
                    }
            }
        }
        
    }
    func removePosting(at offsets: IndexSet) {
        for offset in offsets {
            if let index = postings.firstIndex(of: filteredPostings[offset]) {
                postings.remove(at: index)
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
