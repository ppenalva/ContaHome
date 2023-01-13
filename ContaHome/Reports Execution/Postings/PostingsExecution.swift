//
//  PostingsExecution.swift
//  ContaHome
//
//  Created by Pablo Penalva on 5/1/23.
//

import SwiftUI

struct PostingsExecution: View {
    
    @Binding var accounts: [Account]
    @Binding var postings: [Posting]
    
    @Binding var dateFrom: Date
    @Binding var dateTo: Date
    @Binding var accountDebit: String
    @Binding var accountCredit: String
    @Binding var description: String
    @Binding var amountFrom: Double
    @Binding var amountTo: Double
    
    @State var altura: Int = 0
    
    @State var newPostingData = Posting.Data()
    
    var body: some View {
        VStack {
            Button("Print") {
                self.onPrint()
            }
            Divider()
            
            Print_Preview(accounts: $accounts, postings: $postings, dateFrom: $dateFrom, dateTo: $dateTo, accountDebit: $accountDebit, accountCredit: $accountCredit, description: $description, amountFrom: $amountFrom, amountTo: $amountTo, altura: $altura, selectedPosting: Posting(data: newPostingData))
            
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
        
        let rootView = Print_Preview(accounts: $accounts, postings: $postings, dateFrom: $dateFrom, dateTo: $dateTo, accountDebit: $accountDebit, accountCredit: $accountCredit, description: $description, amountFrom: $amountFrom, amountTo: $amountTo, altura: $altura, selectedPosting: Posting(data: newPostingData) )
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
        @Binding var postings: [Posting]
        
        @Binding var dateFrom: Date
        @Binding var dateTo: Date
        @Binding var accountDebit: String
        @Binding var accountCredit: String
        @Binding var description: String
        @Binding var amountFrom: Double
        @Binding var amountTo: Double
        @Binding var altura: Int
        
        @State var selectedPosting: Posting
        @State private var editPostingData = Posting.Data()
        @State private var isPresentingEditPostingView = false
        
        private var filteredPostings: [Posting] {
            if accountDebit.isEmpty {
                
                if description.isEmpty {
                    
                    if accountCredit.isEmpty  {
                        return postings.filter {
                            posting in
                            (posting.date >= dateFrom && posting.date <= dateTo
                             &&
                             ((posting.debitAmount >= amountFrom && posting.debitAmount <= amountTo)  ||
                              (posting.creditAmount >= amountFrom && posting.creditAmount <= amountTo))
                            )
                        }
                    } else {
                        return postings.filter {
                            posting in
                            (posting.date >= dateFrom && posting.date <= dateTo
                             &&
                             (posting.firstAccount == accountCredit || posting.secondAccount == accountCredit)
                             &&
                             ((posting.debitAmount >= amountFrom && posting.debitAmount <= amountTo)  ||
                              (posting.creditAmount >= amountFrom && posting.creditAmount <= amountTo))
                            )
                        }
                    }
                } else {
                    if accountCredit.isEmpty  {
                        return postings.filter {
                            posting in
                            (posting.date >= dateFrom && posting.date <= dateTo
                             &&
                             (posting.description.contains(description))
                             &&
                             ((posting.debitAmount >= amountFrom && posting.debitAmount <= amountTo)  ||
                              (posting.creditAmount >= amountFrom && posting.creditAmount <= amountTo))
                            )
                        }
                    } else {
                        return postings.filter {
                            posting in
                            (posting.date >= dateFrom && posting.date <= dateTo
                             &&
                             ((posting.firstAccount == accountCredit && posting.firstAccount == accountCredit)
                              || (posting.secondAccount == accountCredit ))
                             &&
                             (posting.description.contains(description))
                             &&
                             ((posting.debitAmount >= amountFrom && posting.debitAmount <= amountTo)  ||
                              (posting.creditAmount >= amountFrom && posting.creditAmount <= amountTo))
                            )
                        }
                    }
                }
            } else {
                
                if description.isEmpty {
                    
                    if accountCredit.isEmpty  {
                        return postings.filter {
                            posting in
                            (posting.date >= dateFrom && posting.date <= dateTo
                             &&
                             (posting.firstAccount == accountDebit || posting.secondAccount == accountDebit)
                             &&
                             ((posting.debitAmount >= amountFrom && posting.debitAmount <= amountTo)  ||
                              (posting.creditAmount >= amountFrom && posting.creditAmount <= amountTo))
                            )
                        }
                    } else {
                        return postings.filter {
                            posting in
                            (posting.date >= dateFrom && posting.date <= dateTo
                             &&
                             ((posting.firstAccount == accountDebit && posting.secondAccount == accountCredit)
                              || (posting.firstAccount == accountCredit && posting.secondAccount == accountDebit))
                             
                             &&
                             ((posting.debitAmount >= amountFrom && posting.debitAmount <= amountTo)  ||
                              (posting.creditAmount >= amountFrom && posting.creditAmount <= amountTo))
                            )
                        }
                    }
                } else {
                    if accountCredit.isEmpty  {
                        return postings.filter {
                            posting in
                            (posting.date >= dateFrom && posting.date <= dateTo
                             &&
                             (posting.firstAccount == accountDebit || posting.secondAccount == accountDebit)
                             &&
                             (posting.description.contains(description))
                             &&
                             ((posting.debitAmount >= amountFrom && posting.debitAmount <= amountTo)  ||
                              (posting.creditAmount >= amountFrom && posting.creditAmount <= amountTo))
                            )
                        }
                    } else {
                        return postings.filter {
                            posting in
                            (posting.date >= dateFrom && posting.date <= dateTo
                             &&
                             ((posting.firstAccount == accountDebit && posting.secondAccount == accountCredit)
                              || (posting.firstAccount == accountCredit && posting.secondAccount == accountDebit))
                             &&
                             (posting.description.contains(description))
                             &&
                             ((posting.debitAmount >= amountFrom && posting.debitAmount <= amountTo)  ||
                              (posting.creditAmount >= amountFrom && posting.creditAmount <= amountTo))
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
                    
                    Text( "POSTINGS LIST")
                    
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
            .onAppear() { altura += 115 }
            ForEach (filteredPostings) { filteredPosting in
                PostingEditPrint(posting: filteredPosting)
                    .onAppear(){altura += 32}
                    .onTapGesture {
                        self.selectedPosting = filteredPosting
                        editPostingData = filteredPosting.data
                        isPresentingEditPostingView = true
                    }
            }
            
            .sheet(isPresented: $isPresentingEditPostingView) {
                NavigationView {
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
    }
}



