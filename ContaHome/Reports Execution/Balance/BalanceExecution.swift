//
//  BalanceExecution.swift
//  ContaHome
//
//  Created by Pablo Penalva on 24/5/22.
//

import SwiftUI

struct BalanceExecution: View {
    
    @Binding var accounts: [Account]
    @Binding var postings: [Posting]
    @Binding var balanceLines: [BalanceLine]
    @Binding var fechaInforme: Date
    
    
    var body: some View {
        VStack {
            Button("Print", action: self.onPrint )
            Divider()
            Print_Preview(accounts: $accounts, postings: $postings, balanceLines: $balanceLines, fechaInforme: $fechaInforme)
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
        
        let rootView = Print_Preview(accounts: $accounts, postings: $postings, balanceLines: $balanceLines, fechaInforme: $fechaInforme)
        let view = NSHostingView(rootView: rootView)
        view.frame.size = CGSize(width: 500, height: 500)
        let po = NSPrintOperation(view: view, printInfo: pi)
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
        
        
        
        func importeCuenta ( postings:[Posting], cuenta:[BalanceLine.AccountsInLine]) -> Double  {
            
            var accountArray:[String] = []
            for item in  cuenta {
                accountArray.append(item.account)
            }
            
            let importe1 = postings.filter({($0.date <= fechaInforme) && (accountArray.contains( where: $0.firstAccount.contains))}).map{$0.debitAmount}.reduce(0, +)
        
            let importe2 = postings.filter({($0.date <= fechaInforme) && (accountArray.contains( where: $0.firstAccount.contains))}).map{$0.creditAmount}.reduce(0, +)
            
            let importe3 = postings.filter({($0.date <= fechaInforme) && (accountArray.contains( where: $0.secondAccount.contains))}).map{$0.creditAmount}.reduce(0, +)
            
            let importe4 = postings.filter({($0.date <= fechaInforme) && (accountArray.contains( where: $0.secondAccount.contains))}).map{$0.debitAmount}.reduce(0, +)
            
            let importe = importe1 - importe2 + importe3 - importe4
            
            return importe
        }
        
        
        var body: some View {
            
            VStack {
                Text ("Balance Sheet")
                Text (" As of \(fechaInforme)")
                
            }
            
            ForEach (balanceLines) { linea  in
                if linea.accounts.count == 0 {
                    
                    Text ( linea.name)
                    
                } else {
                    
                    let a = importeCuenta(postings: postings, cuenta: linea.accounts)
                    
                    HStack {
                        
                        Text ( linea.name)
                        Spacer()
                        Text (String(format: "%.2f", a ))
                        
                    }
                }
            }
        }
    }
}
