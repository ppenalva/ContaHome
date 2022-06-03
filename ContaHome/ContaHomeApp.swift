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
    //   @StateObject private var accountGropStore = AccountGroupStore()
    
    @State private var level2s = Level2.sampleData
    @State private var level1s = Level1.sampleData
    @State private var reports = Report.sampleData
    
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
                
               
                Level2List(level2s: $level2s, accounts: $accountStore.accounts)
                        
                
                
            case "32":
                Level1List(level1s: $level1s, level2s: $level2s)
            case "33":
                ReportList(reports: $reports, level1s: $level1s)
                
            
            case "41":
                BalancePeticion(fechaInforme: Date(), accounts: $accountStore.accounts, postings: $postingStore.postings, reports:$reports, level1s:$level1s, level2s:$level2s)
            
 //
 //               ReportTwo(accounts: $accountStore.accounts, postings: $postingStore.postings,reports: $reports)
            default:
                ReportList(reports: $reports, level1s: $level1s)
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
                        Text("Level 2")
                    })
                    Button(action: {
                        menuChoice = "32"
                    }, label: {
                        Text("Level 1")
                    })
                    Button(action: {
                        menuChoice = "33"
                    }, label: {
                        Text("Reports")
                    })
                    
                }
            }
        }
    }
}
