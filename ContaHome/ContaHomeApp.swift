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
    @StateObject private var balanceLineStore = BalanceLineStore()
    
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
                
           
                
            case "31":
                
               
                BalanceLineList(balanceLines: $balanceLineStore.balanceLines, accounts: $accountStore.accounts)
                        
                
                
        
            
            case "41":
                BalancePeticion(fechaInforme: Date(), accounts: $accountStore.accounts, postings: $postingStore.postings, balanceLines:$balanceLineStore.balanceLines)
            
            default:
               EmptyView()
            }
        }
        
        .commands {
            CommandMenu("Main Menu") {
                
                Button(action: {
                    menuChoice = "0"
                }, label: {
                    Text("Posting")
                })
                
                Menu("Reports Execution") {
                    
                    Button(action: {
                        menuChoice = "41"
                    }, label: {
                        Text("Balance")
                    })
                    Button(action: {
                        menuChoice = "42"
                    }, label: {
                        Text("Cuenta Resultdos")
                    })
                }
            }
            CommandMenu("Configurations") {
                
                Menu("Reports Configuration") {
                    
                    Button(action: {
                        menuChoice = "31"
                    }, label: {
                        Text("Balance Line")
                    })
                    
                    
                }
            }
        }
    }
}
