//
//  BalanceExecution.swift
//  ContaHome
//
//  Created by Pablo Penalva on 24/5/22. modificado hoy 30 noviembre
//

import SwiftUI

struct BalanceExecution: View {
    
    @Binding var accounts: [Account]
    @Binding var postings: [Posting]
    @Binding var balanceLines: [BalanceLine]
    @Binding var fechaInforme: Date
    
    @State var altura: Int = 0
    
    var body: some View {
        VStack {
            Button("Print", action: self.onPrint )
            Divider()
            Print_Preview(accounts: $accounts, postings: $postings, balanceLines: $balanceLines, fechaInforme: $fechaInforme, altura: $altura)
        }
    }
    
    private func onPrint() {
        let pi = NSPrintInfo.shared
        pi.topMargin = 0.0
        pi.bottomMargin = 0.0
        pi.leftMargin = 0.0
        pi.rightMargin = 0.0
        pi.orientation = .portrait
        pi.isHorizontallyCentered = false
        pi.isVerticallyCentered = false
        pi.scalingFactor = 1.0
        
        let rootView = Print_Preview(accounts: $accounts, postings: $postings, balanceLines: $balanceLines, fechaInforme: $fechaInforme, altura: $altura)
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
        @Binding var balanceLines: [BalanceLine]
        @Binding var fechaInforme: Date
        @Binding var altura: Int
        
        @State private var isPresentingPostingBalanceExecution = false
        @State private var selectedLine: BalanceLine = BalanceLine(data: BalanceLine.Data())
        
        func importeCuenta ( postings:[Posting], cuenta:[BalanceLine.AccountsInLine]) -> Double  {
            
            var accountArray:[String] = []
            
            for item in  cuenta {
                accountArray.append(item.account)
            }
            
            let importe1 = postings.filter({($0.date <= fechaInforme) && (accountArray.contains( where: $0.firstAccount.elementsEqual))}).map{$0.debitAmount}.reduce(0, +)
            
            let importe2 = postings.filter({($0.date <= fechaInforme) && (accountArray.contains( where: $0.firstAccount.elementsEqual))}).map{$0.creditAmount}.reduce(0, +)
            
            let importe3 = postings.filter({($0.date <= fechaInforme) && (accountArray.contains( where: $0.secondAccount.elementsEqual))}).map{$0.creditAmount}.reduce(0, +)
            
            let importe4 = postings.filter({($0.date <= fechaInforme) && (accountArray.contains( where: $0.secondAccount.elementsEqual))}).map{$0.debitAmount}.reduce(0, +)
            
            let importe = importe1 - importe2 + importe3 - importe4
            
            return importe
        }
        
        var body: some View {

            
                  
              
            Form {
                Text( "BALANCE")
                HStack {
                    Spacer()
                    Text ("As of \(fechaInforme, style: .date)")
                    Spacer()
                }
                Text ("")
                .onAppear() { altura += 24 }
                
                ForEach (balanceLines) { linea  in
                    
                    if linea.accounts.count == 0 {
                        
                        
                        Text ( linea.name)
                            .onAppear(){altura += 8}
                        
                    } else {
                        
                        let a = importeCuenta(postings: postings, cuenta: linea.accounts)
                        
                        HStack {
                            
                            Text ( linea.name)
                            Spacer()
                            Text (String(format: "%.2f", a ))
                            
                        }
                        .onAppear(){altura += 32}
                        .onTapGesture {                                self.selectedLine = linea
                            isPresentingPostingBalanceExecution = true}
                    }
                }
            }
            
            .sheet (isPresented: $isPresentingPostingBalanceExecution) {
                NavigationView {
                    
                    PostingsBalanceExecution(accounts: $accounts, postings: $postings, balanceLines: $balanceLines, selectedLine: $selectedLine,fechaInforme: $fechaInforme)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Dismiss") {
                                    isPresentingPostingBalanceExecution = false
                                }
                            }
                        }
                    
                }
                .frame(width: 800, height: 1200)
            }
           
        }
    }
}

