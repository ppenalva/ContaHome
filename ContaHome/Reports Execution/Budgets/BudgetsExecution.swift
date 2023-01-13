//
//  BudgetExecution.swift
//  ContaHome
//
//  Created by Pablo Penalva on 14/12/22.
//

import SwiftUI

struct BudgetsExecution: View {
    
    @Binding var accounts: [Account]
    @Binding var budgets: [Budget]
    
    @Binding var dateFrom: Date
    @Binding var dateTo: Date
    @Binding var accountDebit: String
    @Binding var accountCredit: String
    @Binding var description: String
    @Binding var amountFrom: Double
    @Binding var amountTo: Double
    
    @State var altura: Int = 0
    
    @State var newBudgetData = Budget.Data()
    
    var body: some View {
        VStack {
            Button("Print") {
                self.onPrint()
            }
            Divider()
            
            Print_Preview(accounts: $accounts, budgets: $budgets, dateFrom: $dateFrom, dateTo: $dateTo, accountDebit: $accountDebit, accountCredit: $accountCredit, description: $description, amountFrom: $amountFrom, amountTo: $amountTo, altura: $altura, selectedBudget: Budget(data: newBudgetData))
            
        }
    }
    
    private func onPrint() {
        let pi = NSPrintInfo.shared
        pi.topMargin = 0.0
        pi.bottomMargin = 0.0
        pi.leftMargin = 0.0
        pi.rightMargin = 0.0
        pi.orientation = .portrait
        pi.horizontalPagination = .fit
        pi.verticalPagination = .automatic
        pi.isHorizontallyCentered = false
        pi.isVerticallyCentered = false
        pi.scalingFactor = 1.0
        
        let rootView = Print_Preview(accounts: $accounts, budgets: $budgets, dateFrom: $dateFrom, dateTo: $dateTo, accountDebit: $accountDebit, accountCredit: $accountCredit, description: $description, amountFrom: $amountFrom, amountTo: $amountTo, altura: $altura, selectedBudget: Budget(data: newBudgetData) )
        let view = NSHostingView(rootView: rootView)
        
        
        
        let contentRect = NSRect(x: 0, y: 0, width: 500, height: altura)
        
        view.frame.size = contentRect.size
        
        altura = 0
        
        let newWindow = NSWindow(
            contentRect: contentRect,
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        newWindow.contentView = view
        
        let myNSBitMapRep = newWindow.contentView!.bitmapImageRepForCachingDisplay(in: contentRect)!
        newWindow.contentView!.cacheDisplay(in: contentRect, to: myNSBitMapRep)
        
        let myNSImage = NSImage(size: myNSBitMapRep.size)
        myNSImage.addRepresentation(myNSBitMapRep)
        
        let nsImageView = NSImageView(frame: contentRect)
        nsImageView.image = myNSImage
        
        let po = NSPrintOperation(view: nsImageView, printInfo: pi)
          
        
        
        po.printInfo.orientation = .portrait
        po.showsPrintPanel = true
        po.showsProgressPanel = true
        
        po.printPanel.options.insert(NSPrintPanel.Options.showsPaperSize)
        po.printPanel.options.insert(NSPrintPanel.Options.showsOrientation)
        
        if po.run() {
            print("In Print completion")
        }
            
    }
    
    struct Print_Preview: View {
        
        
        @Binding var accounts: [Account]
        @Binding var budgets: [Budget]
        
        @Binding var dateFrom: Date
        @Binding var dateTo: Date
        @Binding var accountDebit: String
        @Binding var accountCredit: String
        @Binding var description: String
        @Binding var amountFrom: Double
        @Binding var amountTo: Double
        @Binding var altura: Int
        
        @State var selectedBudget: Budget
        @State private var editBudgetData = Budget.Data()
        @State private var isPresentingEditBudgetView = false
        
        private var filteredBudgets: [Budget] {
            if accountDebit.isEmpty {
                
                if description.isEmpty {
                    
                    if accountCredit.isEmpty  {
                        return budgets.filter {
                            budget in
                            (budget.date >= dateFrom && budget.date <= dateTo
                             &&
                             ((budget.debitAmount >= amountFrom && budget.debitAmount <= amountTo)  ||
                              (budget.creditAmount >= amountFrom && budget.creditAmount <= amountTo))
                            )
                        }
                    } else {
                        return budgets.filter {
                            budget in
                            (budget.date >= dateFrom && budget.date <= dateTo
                             &&
                             (budget.firstAccount == accountCredit || budget.secondAccount == accountCredit)
                             &&
                             ((budget.debitAmount >= amountFrom && budget.debitAmount <= amountTo)  ||
                              (budget.creditAmount >= amountFrom && budget.creditAmount <= amountTo))
                            )
                        }
                    }
                } else {
                    if accountCredit.isEmpty  {
                        return budgets.filter {
                            budget in
                            (budget.date >= dateFrom && budget.date <= dateTo
                             &&
                             (budget.description.contains(description))
                             &&
                             ((budget.debitAmount >= amountFrom && budget.debitAmount <= amountTo)  ||
                              (budget.creditAmount >= amountFrom && budget.creditAmount <= amountTo))
                            )
                        }
                    } else {
                        return budgets.filter {
                            budget in
                            (budget.date >= dateFrom && budget.date <= dateTo
                             &&
                             ((budget.firstAccount == accountCredit && budget.firstAccount == accountCredit)
                              || (budget.secondAccount == accountCredit ))
                             &&
                             (budget.description.contains(description))
                             &&
                             ((budget.debitAmount >= amountFrom && budget.debitAmount <= amountTo)  ||
                              (budget.creditAmount >= amountFrom && budget.creditAmount <= amountTo))
                            )
                        }
                    }
                }
            } else {
                
                if description.isEmpty {
                    
                    if accountCredit.isEmpty  {
                        return budgets.filter {
                            budget in
                            (budget.date >= dateFrom && budget.date <= dateTo
                             &&
                             (budget.firstAccount == accountDebit || budget.secondAccount == accountDebit)
                             &&
                             ((budget.debitAmount >= amountFrom && budget.debitAmount <= amountTo)  ||
                              (budget.creditAmount >= amountFrom &&     budget.creditAmount <= amountTo))
                            )
                        }
                    } else {
                        return budgets.filter {
                            budget in
                            (budget.date >= dateFrom && budget.date <= dateTo
                             &&
                             ((budget.firstAccount == accountDebit && budget.secondAccount == accountCredit)
                              || (budget.firstAccount == accountCredit && budget.secondAccount == accountDebit))
                             
                             &&
                             ((budget.debitAmount >= amountFrom && budget.debitAmount <= amountTo)  ||
                              (budget.creditAmount >= amountFrom && budget.creditAmount <= amountTo))
                            )
                        }
                    }
                } else {
                    if accountCredit.isEmpty  {
                        return budgets.filter {
                            budget in
                            (budget.date >= dateFrom && budget.date <= dateTo
                             &&
                             (budget.firstAccount == accountDebit || budget.secondAccount == accountDebit)
                             &&
                             (budget.description.contains(description))
                             &&
                             ((budget.debitAmount >= amountFrom && budget.debitAmount <= amountTo)  ||
                              (budget.creditAmount >= amountFrom && budget.creditAmount <= amountTo))
                            )
                        }
                    } else {
                        return budgets.filter {
                            budget in
                            (budget.date >= dateFrom && budget.date <= dateTo
                             &&
                             ((budget.firstAccount == accountDebit && budget.secondAccount == accountCredit)
                              || (budget.firstAccount == accountCredit && budget.secondAccount == accountDebit))
                             &&
                             (budget.description.contains(description))
                             &&
                             ((budget.debitAmount >= amountFrom && budget.debitAmount <= amountTo)  ||
                              (budget.creditAmount >= amountFrom && budget.creditAmount <= amountTo))
                            )
                        }
                    }
                }
            }
        }
        var body: some View {
            
            VStack {
                
                HStack {
                    
                    Spacer()
                    
                    Text( "BUDGETS LIST")
                    
                    Spacer()
                }
                
                HStack {
                    
                    Text( "Date from: \( dateFrom, style: .date)")
                    Spacer()
                    Text( "Date to: \( dateTo, style: .date)")
                    Spacer()
                }
                
                HStack {
                    Text( "Debit Account: \(accountDebit)")
                    Spacer()
                    Text( "Credit Account: \(accountCredit)")
                    Spacer()
                }
                
                HStack {
                    Text( "Description: \(description)")
                    Spacer()
                }
                
                HStack {
                    Text( "Amount from: \(String(format: "%.2f", amountFrom))")
                    Spacer()
                    Text( "Amount to: \(String(format: "%.2f", amountTo))")
                    Spacer()
                }
                Text("")
            }
            .onAppear() { altura += 96 }
            ForEach (filteredBudgets) { filteredBudget in
                BudgetEditPrint(budget: filteredBudget)
                    .onAppear(){altura += 32}
                    .onTapGesture {
                        self.selectedBudget = filteredBudget
                        editBudgetData = filteredBudget.data
                        isPresentingEditBudgetView = true
                    }
            }
            
            .sheet(isPresented: $isPresentingEditBudgetView) {
                NavigationView {
                    BudgetEditRow( data: $editBudgetData, accounts: $accounts)
                    
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Dismiss") {
                                    isPresentingEditBudgetView = false
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Confirm") {
                                    let editBudget = Budget(data: editBudgetData)
                                    if let index = budgets.firstIndex(of: selectedBudget){
                                        budgets[index] = editBudget
                                    }
                                    isPresentingEditBudgetView = false
                                    
                                }
                            }
                        }
                }
            }
        }
    }
}



