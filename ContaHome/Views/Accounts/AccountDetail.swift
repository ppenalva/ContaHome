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
    
    @State var selectedPosting: Posting
    
    
    @State private var isPresentingNewPostingView = false
    @State private var isPresentingEditPostingView = false
    
    @State private var newPostingData = Posting.Data()
    @State private var editPostingData = Posting.Data()
    
    private var filteredPostings: [Posting] {
        postings.filter { posting in
            (posting.firstAccount == account.name || posting.secondAccount == account.name)
        }
    }
    
    func importeCuenta ( postings:[Posting], cuenta: String ) -> Double  {
        
        
        let importe1 = postings.filter({cuenta == $0.firstAccount}).map{$0.debitAmount}.reduce(0, +)
        let importe2 = postings.filter({cuenta == $0.firstAccount}).map{$0.creditAmount}.reduce(0, +)
        let importe3 = postings.filter({cuenta == $0.secondAccount}).map{$0.creditAmount}.reduce(0, +)
        let importe4 = postings.filter({cuenta == $0.secondAccount}).map{$0.debitAmount}.reduce(0, +)
        
        let importe = importe1 - importe2 + importe3 - importe4
        
        return importe
    }
    
    var body: some View {
        
        List {
            
            ForEach (filteredPostings) { filteredPosting in
                
                HStack {
                    
                    if (account.name == filteredPosting.firstAccount) {
                        PostingDebitRow(posting: filteredPosting)
                        
                    } else {
                        PostingCreditRow(posting: filteredPosting)
                    }
                    
                }
                .onTapGesture {
                    self.selectedPosting = filteredPosting
                    editPostingData = filteredPosting.data
                    isPresentingEditPostingView = true
                }
            }
            .onDelete(perform: removePosting)
            
        }
        .navigationTitle("\(account.name)     \(String(format: "%.2f", importeCuenta(postings: postings, cuenta: account.name)))")
        
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
                                
                                newPostingData.description = ""
                                newPostingData.debitAmount = 0.0
                                newPostingData.creditAmount = 0.0
                                newPostingData.firstAccount = ""
                                newPostingData.secondAccount = ""
                            }
                            .disabled(newPostingData.secondAccount.isEmpty)
                        }
                    }
            }
        }
        
        .sheet(isPresented: $isPresentingEditPostingView) {
            NavigationView  {
                PostingEditRow( data: $editPostingData, accounts: $accounts)
                
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                isPresentingEditPostingView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Confirm") {
                                let editPosting = Posting(data: editPostingData)
                                if let index = postings.firstIndex(of: selectedPosting){
                                    postings[index] = editPosting
                                }
                                isPresentingEditPostingView = false
                                
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
