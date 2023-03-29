//
//  PAndLBudgetsExecution.swift
//  ContaHome
//
//  Created by Pablo Penalva on 12/1/23.
//

import SwiftUI

struct PAndLBudgetsExecution: View {
    
    @Binding var accounts: [Account]
    @Binding var postings: [Posting]
    @Binding var budgets: [Budget]
    @Binding var pAndLLines: [PAndLLine]
    
    @State var altura: Int = 0
    
    
    @Binding var fechaInforme1desde: Date
    @Binding var fechaInforme1hasta: Date
    
    var body: some View {
        VStack {
            Button("Print", action: self.onPrint )
            Divider()
            Print_Preview(accounts: $accounts, postings: $postings, budgets: $budgets, pAndLLines: $pAndLLines, fechaInforme1desde: $fechaInforme1desde, fechaInforme1hasta: $fechaInforme1hasta, altura: $altura)
        }
    }
    
    private func onPrint() {
        let pi = NSPrintInfo.shared
        pi.topMargin = 0.0
        pi.bottomMargin = 0.0
        pi.leftMargin = 20.0
        pi.rightMargin = 20.0
        pi.orientation = .portrait
        pi.isHorizontallyCentered = false
        pi.isVerticallyCentered = false
        pi.scalingFactor = 1.0
        
        let rootView =  Print_Preview(accounts: $accounts, postings: $postings, budgets: $budgets, pAndLLines: $pAndLLines, fechaInforme1desde: $fechaInforme1desde, fechaInforme1hasta: $fechaInforme1hasta, altura: $altura)
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
        @Binding var budgets: [Budget]
        @Binding var pAndLLines: [PAndLLine]
        @Binding var fechaInforme1desde: Date
        @Binding var fechaInforme1hasta: Date
        @Binding var altura: Int
        
        @State private var isPresentingBudgetPAndL1Execution = false
        @State private var isPresentingBudgetPAndL2Execution = false
        @State private var selectedLine: PAndLLine = PAndLLine(data: PAndLLine.Data())
        
        
        func importeUnoCuenta ( postings:[Posting], cuenta:[PAndLLine.AccountsInLine]) -> Double  {
            
            var accountArray:[String] = []
            for item in  cuenta {
                accountArray.append(item.account)
            }
            
            let importe1 = postings.filter({($0.date >= fechaInforme1desde)&&($0.date <= fechaInforme1hasta) && (accountArray.contains( where: $0.firstAccount.elementsEqual))}).map{$0.debitAmount}.reduce(0, +)
        
            let importe2 = postings.filter({($0.date >= fechaInforme1desde)&&($0.date <= fechaInforme1hasta) && (accountArray.contains( where: $0.firstAccount.elementsEqual))}).map{$0.creditAmount}.reduce(0, +)
        
            let importe3 = postings.filter({($0.date >= fechaInforme1desde)&&($0.date <= fechaInforme1hasta) && (accountArray.contains( where: $0.secondAccount.elementsEqual))}).map{$0.debitAmount}.reduce(0, +)
        
            let importe4 = postings.filter({($0.date >= fechaInforme1desde)&&($0.date <= fechaInforme1hasta) && (accountArray.contains( where: $0.secondAccount.elementsEqual))}).map{$0.creditAmount}.reduce(0, +)
        
            let importeUno = importe1 - importe2 + importe3 - importe4
            
            return importeUno
        }
        
        
        func importeDosCuenta ( budgets:[Budget], cuenta:[PAndLLine.AccountsInLine]) -> Double  {
            
            var accountArray:[String] = []
            for item in  cuenta {
                accountArray.append(item.account)
            }
            
            let importe1 = budgets.filter({($0.date >= fechaInforme1desde)&&($0.date <= fechaInforme1hasta) && (accountArray.contains( where: $0.firstAccount.elementsEqual))}).map{$0.debitAmount}.reduce(0, +)
        
            let importe2 = budgets.filter({($0.date >= fechaInforme1desde)&&($0.date <= fechaInforme1hasta) && (accountArray.contains( where: $0.firstAccount.elementsEqual))}).map{$0.creditAmount}.reduce(0, +)
        
            let importe3 = budgets.filter({($0.date >= fechaInforme1desde)&&($0.date <= fechaInforme1hasta) && (accountArray.contains( where: $0.secondAccount.elementsEqual))}).map{$0.debitAmount}.reduce(0, +)
        
            let importe4 = budgets.filter({($0.date >= fechaInforme1desde)&&($0.date <= fechaInforme1hasta) && (accountArray.contains( where: $0.secondAccount.elementsEqual))}).map{$0.creditAmount}.reduce(0, +)
        
            let importeDos = importe1 - importe2 + importe3 - importe4
            
            return importeDos
        }
        
        var body: some View {
            
            Form {
                Text ("Profit and loss ")
                HStack{
                    Text (" Real del \(fechaInforme1desde, style: .date) hasta \(fechaInforme1hasta, style: .date)")
                    Text (" Budget del \(fechaInforme1desde, style: .date) hasta \(fechaInforme1hasta, style: .date)")
                }
            Text("")
                .onAppear() { altura += 24 }
            
            ForEach (pAndLLines) { linea  in
                if linea.accounts.count == 0 {
                    
                    Text ( linea.name)
                        .onAppear(){altura += 32}
                    
                } else {
                    
                    let a = importeUnoCuenta(postings: postings, cuenta: linea.accounts)
                    let b = importeDosCuenta(budgets: budgets, cuenta: linea.accounts)
                    let c = a - b
                    
                    HStack {
                        
                        Text ( linea.name)
                        Spacer()
                        Text (String(format: "%.2f", a ))
                            .onTapGesture {                                self.selectedLine = linea
                                isPresentingBudgetPAndL1Execution = true}
                        Text (String(format: "%.2f", b ))
                            .onTapGesture {                                self.selectedLine = linea
                                isPresentingBudgetPAndL2Execution = true}
                        Text (String(format: "%.2f", c ))
                    }
                    .onAppear(){altura += 8}
                    }
                }
            }
            .sheet (isPresented: $isPresentingBudgetPAndL1Execution) {
                NavigationView {
                    
                    PostingsPAndLPostingsExecution(accounts: $accounts, postings: $postings, pAndLLines: $pAndLLines, selectedLine: $selectedLine,fechaDesde: $fechaInforme1desde, fechaHasta: $fechaInforme1hasta)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Dismiss") {
                                    isPresentingBudgetPAndL1Execution = false
                                }
                            }
                        }
                    
                }
                .frame(width: 800, height: 1200)
            }
            .sheet (isPresented: $isPresentingBudgetPAndL2Execution) {
                NavigationView {
                    
                    BudgetsPAndLBudgetsExecution(accounts: $accounts, budgets: $budgets, pAndLLines: $pAndLLines, selectedLine: $selectedLine,fechaDesde: $fechaInforme1desde, fechaHasta: $fechaInforme1hasta)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Dismiss") {
                                    isPresentingBudgetPAndL2Execution = false
                                }
                            }
                        }
                    
                }
                .frame(width: 800, height: 1200)
            }
        }
    }
}
