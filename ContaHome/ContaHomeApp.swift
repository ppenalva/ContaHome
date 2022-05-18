//
//  ContaHomeApp.swift
//  ContaHome
//
//  Created by Pablo Penalva on 27/4/22.
//

import SwiftUI

@main

struct ContaHomeApp: App {
    
    @StateObject private var accountStore = AccountStore()
    @StateObject private var postingStore = PostingStore()
    @State private var listAccounts = ListAccount.sampleData
    @State private var accountGroups = AccountGroup.sampleData
    
    @State var menuChoice = "0"
    
 
    
    
    var body: some Scene {
        WindowGroup {
            
            switch menuChoice {
                case "0":
                NavigationView {
                    
                    AccountList(accounts: $accountStore.accounts, postings: $postingStore.postings) {
                        AccountStore.save(accounts: accountStore.accounts) { result in
                            if case .failure(let error) = result {
                                fatalError(error.localizedDescription)
                            }
                        }
                        PostingStore.save(postings: postingStore.postings) { result in
                            if case .failure(let error) = result {
                                fatalError(error.localizedDescription)
                            }
                        }
                    }
                }
                .onAppear {
                    AccountStore.load { result in
                        switch result {
                                           case .failure(let error):
                                               fatalError(error.localizedDescription)
                                           case .success(let accounts):
                            accountStore.accounts = accounts
                                           }
                    }
                    PostingStore.load { result in
                        switch result {
                                           case .failure(let error):
                                               fatalError(error.localizedDescription)
                                           case .success(let postings):
                            postingStore.postings = postings
                                           }
                    }
                }
                
            case "1":
                GroupList(accountGroups: $accountGroups)
                
           case "2":
                
                ReportTwo(accounts: $accountStore.accounts, postings: $postingStore.postings)
                
            default:
                GroupList(accountGroups: $accountGroups)
            }
        }
        
        .commands {
            CommandMenu("Custom Menu") {
                
                Button(action: {
        menuChoice = "0"
                }, label: {
                        Text("Posting")
                })
                
                Button(action: {
        menuChoice = "1"
                }, label: {
                        Text("Reports Definition")
                })
                
                Button(action: {
        menuChoice = "2"
                }, label: {
                        Text("Print Balance")
                })
                
            }
        }
    }
}
