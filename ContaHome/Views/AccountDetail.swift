//
//  AccountDetail.swift
//  ContaHome
//
//  Created by Pablo Penalva on 27/4/22.
//

import SwiftUI

struct AccountDetail: View {
    
    var account: Account
    @Binding var postings: [Posting]
    @Binding var accounts: [Account]
    @State private var isPresentingNewPostingView = false
    @State private var newPostingData = Posting.Data()
    
    var filteredPostings: [Posting] {
        postings.filter { posting in
            (posting.firstAccount == account.number || posting.secondAccount == account.number)
        }
    }
    
    var body: some View {
        
        List(filteredPostings) { posting in
            NavigationLink {
            } label: {
                if (account.number == posting.firstAccount) {
                    PostingDebitRow(posting: posting)
                } else {
                    PostingCreditRow(posting: posting)
                }
            }
            
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
            NavigationView {
                PostingEditRow(data: $newPostingData, accounts: $accounts)
                
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                isPresentingNewPostingView = false
                                newPostingData = Posting.Data()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Add") {
                                var newPosting = Posting(dataPosting: newPostingData)
                                newPosting.firstAccount = account.number
                                newPosting.firstAccountName = account.name
                                postings.append(newPosting)
                                isPresentingNewPostingView = false
                                newPostingData = Posting.Data()
                            }
                        }
                    }
            }
        }
    }
}

//struct AccountDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            AccountDetail(accounts: .constant(Account.sampleData.accounts[0]))
//        }
//    }
//}
