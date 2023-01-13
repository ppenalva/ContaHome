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
    @StateObject private var budgetStore = BudgetStore()
    @StateObject private var balanceLineStore = BalanceLineStore()
    @StateObject private var pAndLLineStore = PAndLLineStore()
    
    
    @State var menuChoice = "0"
    
    var body: some Scene {
        WindowGroup {
            
            switch menuChoice {
            case "0":
                Text( "Welcome to ContaHome")
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
                        BudgetStore.load { result in
                            switch result {
                            case .failure(let error):
                                fatalError(error.localizedDescription)
                            case .success(let budgets):
                                budgetStore.budgets = budgets
                            }
                        }
                        BalanceLineStore.load { result in
                            switch result {
                            case .failure(let error):
                                fatalError(error.localizedDescription)
                            case .success(let balanceLines):
                                balanceLineStore.balanceLines = balanceLines
                            }
                        }
                        PAndLLineStore.load { result in
                            switch result {
                            case .failure(let error):
                                fatalError(error.localizedDescription)
                            case .success(let pAndLLines):
                                pAndLLineStore.pAndLLines = pAndLLines
                            }
                        }
                    
                    }
            case "1":
                NavigationView {
                    
                    AccountList(accounts: $accountStore.accounts, postings: $postingStore.postings )
                
               
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
                
            case "6":
                NavigationView {
                    
                    AccountBudgetList(accounts: $accountStore.accounts, budgets: $budgetStore.budgets )
                .onDisappear {
                    BudgetStore.save(budgets: budgetStore.budgets) { result in
                        if case .failure(let error) = result {
                            fatalError(error.localizedDescription)
                        }
                    }
                }
                }
                
                
            case "31":
                
                NavigationView {
                    
                    
                    BalanceLineList(balanceLines: $balanceLineStore.balanceLines, accounts: $accountStore.accounts)
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
                PAndLPostingsPetition( accounts: $accountStore.accounts, postings: $postingStore.postings, pAndLLines:$pAndLLineStore.pAndLLines)
                
                
            case "43":
                PAndLBudgetsPetition( accounts: $accountStore.accounts, postings: $postingStore.postings, budgets: $budgetStore.budgets, pAndLLines:$pAndLLineStore.pAndLLines)
                
            case "44":
                PostingsPetition( accounts: $accountStore.accounts, postings: $postingStore.postings)
                    .onDisappear {
                        PostingStore.save(postings: postingStore.postings) { result in
                            if case .failure(let error) = result {
                                fatalError(error.localizedDescription)
                            }
                        }
                    }
                
            case "50":
                NavigationView {
                    SecurityCopy()
                }
         
            case "51":
                NavigationView {
                    PostingUpLoad(accounts: $accountStore.accounts, postings: $postingStore.postings) {
                        PostingStore.save(postings: postingStore.postings) { result in
                            if case .failure(let error) = result {
                                fatalError(error.localizedDescription)
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
                }
            
            case "53":
                NavigationView {
                    BudgetUpLoad(accounts: $accountStore.accounts, budgets: $budgetStore.budgets) {
                        BudgetStore.save(budgets: budgetStore.budgets) { result in
                            if case .failure(let error) = result {
                                fatalError(error.localizedDescription)
                            }
                        }
                    }
                }
                
            case "54":
                NavigationView {
                    BudgetDelete(accounts: $accountStore.accounts, budgets: $budgetStore.budgets) {
                        BudgetStore.save(budgets: budgetStore.budgets) { result in
                            if case .failure(let error) = result {
                                fatalError(error.localizedDescription)
                            }
                        }
                    }
                }
            case "55":
                NavigationView {
                    BudgetDownLoad( budgets: $budgetStore.budgets)
                        }
                
            default:
                EmptyView()
            }
        }
        
        .commands {
            CommandMenu("Main Menu") {
                
                Button(action: {
                    menuChoice = "1"
                }, label: {
                    Text("Posting")
                })
                
                Button(action: {
                    menuChoice = "6"
                }, label: {
                    Text("Budget")
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
                    Button(action: {
                        menuChoice = "43"
                    }, label: {
                        Text("P&L vs Budget")
                    })
                    Button(action: {
                        menuChoice = "44"
                    }, label: {
                        Text("Postings List")
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
                        menuChoice = "50"
                    }, label: {
                        Text("Security Copy")
                    })
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
                        Text("UpLoad Budget")
                    })
                    Button(action: {
                        menuChoice = "54"
                    }, label: {
                        Text("Delete Budget")
                    })
                    Button(action: {
                        menuChoice = "55"
                    }, label: {
                        Text("Budget CVS DownLoad")
                    })
                    
                }
            }
        }
    }
       
}
