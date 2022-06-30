//
//  ContaHomeApp.swift
//  ContaHome
//
//  Created by Pablo Penalva on 27/4/22.
//

import SwiftUI

extension String{
    
       var fileExists: Bool {
          return FileManager().fileExists(atPath: self)
       }
    
    // Get the filename from the String
    func fileName() -> String {
        return URL(fileURLWithPath: self).deletingPathExtension().lastPathComponent
    }
    // Get the file extension from String
    func fileExtension() -> String {
        return URL(fileURLWithPath: self).pathExtension
    }
}

@main

struct ContaHomeApp: App {
    
    @StateObject private var accountStore = AccountStore()
    @StateObject private var postingStore = PostingStore()
    @StateObject private var balanceLineStore = BalanceLineStore()
    @StateObject private var pAndLLineStore = PAndLLineStore()
    
    @State var menuChoice = "0"
    
    var body: some Scene {
        WindowGroup {
            
            switch menuChoice {
            case "0":
                NavigationView {
                    
                    AccountList(accounts: $accountStore.accounts, postings: $postingStore.postings )
                
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
                .onDisappear {
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
            case "31":
                
                NavigationView {
                    
                    
                    BalanceLineList(balanceLines: $balanceLineStore.balanceLines, accounts: $accountStore.accounts)
                
                .onAppear {
                    BalanceLineStore.load { result in
                        switch result {
                        case .failure(let error):
                            fatalError(error.localizedDescription)
                        case .success(let balanceLines):
                            balanceLineStore.balanceLines = balanceLines
                        }
                    }
                }
                .onDisappear {
                    BalanceLineStore.save(balanceLines: balanceLineStore.balanceLines) { result in
                        if case .failure(let error) = result {
                            fatalError(error.localizedDescription)
                        }
                    }
                    
                }
                }
                
            case "32":
                
                NavigationView {
                    
                    
                    PAndLLineList(pAndLLines: $pAndLLineStore.pAndLLines, accounts: $accountStore.accounts) 
                
                .onAppear {
                    PAndLLineStore.load { result in
                        switch result {
                        case .failure(let error):
                            fatalError(error.localizedDescription)
                        case .success(let pAndLLines):
                            pAndLLineStore.pAndLLines = pAndLLines
                        }
                    }
                }
                .onDisappear {
                    PAndLLineStore.save(pAndLLines: pAndLLineStore.pAndLLines) { result in
                        if case .failure(let error) = result {
                            fatalError(error.localizedDescription)
                        }
                    }
                }
                }
            case "41":
                BalancePeticion(accounts: $accountStore.accounts, postings: $postingStore.postings, balanceLines:$balanceLineStore.balanceLines)
                
            case "42":
                PAndLPeticion( accounts: $accountStore.accounts, postings: $postingStore.postings, pAndLLines:$pAndLLineStore.pAndLLines)
         
                
            case "51":
                NavigationView {
                    PostingUpLoad(accounts: $accountStore.accounts, postings: $postingStore.postings) {
                        PostingStore.save(postings: postingStore.postings) { result in
                            if case .failure(let error) = result {
                                fatalError(error.localizedDescription)
                            }
                        }
                    }
                
                .onAppear {
                    PostingStore.load { result in
                        switch result {
                        case .failure(let error):
                            fatalError(error.localizedDescription)
                        case .success(let postings):
                            postingStore.postings = postings
                        }
                    }
                }
                }
            case "52":
                NavigationView {
                    PostingDelete(accounts: $accountStore.accounts, postings: $postingStore.postings) {
                        PostingStore.save(postings: postingStore.postings) { result in
                            if case .failure(let error) = result {
                                fatalError(error.localizedDescription)
                            }
                        }
                    }
                
                .onAppear {
                    PostingStore.load { result in
                        switch result {
                        case .failure(let error):
                            fatalError(error.localizedDescription)
                        case .success(let postings):
                            postingStore.postings = postings
                        }
                    }
                }
                }
            case "53":
                NavigationView {
                    SecurityCopy()
                }
                
                
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
                    
                    Button(action: {
                        menuChoice = "32"
                    }, label: {
                        Text("Profit And Loss Line")
                    })
                    
                }
            }
            CommandMenu("Utilities") {
                
                Menu("CVS upload") {
                    
                    Button(action: {
                        menuChoice = "51"
                    }, label: {
                        Text("UpLoad Postings")
                    })
                    
                    Button(action: {
                        menuChoice = "52"
                    }, label: {
                        Text("Delete Postings")
                    })
                    
                    Button(action: {
                        menuChoice = "53"
                    }, label: {
                        Text("Security Copy")
                    })
                    
                    
                }
            }
        }
    }
}
