//
//  PAndLExecution.swift
//  ContaHome
//
//  Created by Pablo Penalva on 13/6/22.
//

import SwiftUI

struct PAndLExecution: View {
    
    @Binding var accounts: [Account]
    @Binding var postings: [Posting]
    @Binding var pAndLLines: [PAndLLine]
    
    @Binding var fechaInforme1desde: Date
    @Binding var fechaInforme1hasta: Date
    @Binding var fechaInforme2desde: Date
    @Binding var fechaInforme2hasta: Date
    
    var body: some View {
        VStack {
            Button("Print", action: self.onPrint )
            Divider()
            Print_Preview(accounts: $accounts, postings: $postings, pAndLLines: $pAndLLines, fechaInforme1desde: $fechaInforme1desde, fechaInforme1hasta: $fechaInforme1hasta, fechaInforme2desde: $fechaInforme2desde, fechaInforme2hasta: $fechaInforme2hasta)
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
        
        let rootView = Print_Preview(accounts: $accounts, postings: $postings, pAndLLines: $pAndLLines, fechaInforme1desde: $fechaInforme1desde,fechaInforme1hasta: $fechaInforme1hasta, fechaInforme2desde: $fechaInforme2desde, fechaInforme2hasta: $fechaInforme2hasta )
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
        @Binding var pAndLLines: [PAndLLine]
        @Binding var fechaInforme1desde: Date
        @Binding var fechaInforme1hasta: Date
        @Binding var fechaInforme2desde: Date
        @Binding var fechaInforme2hasta: Date
        
        
        func importeUnoCuenta ( postings:[Posting], cuenta:[PAndLLine.AccountsInLine]) -> Double  {
            
            var accountArray:[String] = []
            for item in  cuenta {
                accountArray.append(item.account)
            }
            
            let importe1 = postings.filter({($0.date >= fechaInforme1desde)&&($0.date <= fechaInforme1hasta) && (accountArray.contains( where: $0.firstAccount.contains))}).map{$0.debitAmount}.reduce(0, +)
        
            let importe2 = postings.filter({($0.date >= fechaInforme1desde)&&($0.date <= fechaInforme1hasta) && (accountArray.contains( where: $0.firstAccount.contains))}).map{$0.creditAmount}.reduce(0, +)
        
            let importe3 = postings.filter({($0.date >= fechaInforme1desde)&&($0.date <= fechaInforme1hasta) && (accountArray.contains( where: $0.secondAccount.contains))}).map{$0.debitAmount}.reduce(0, +)
        
            let importe4 = postings.filter({($0.date >= fechaInforme1desde)&&($0.date <= fechaInforme1hasta) && (accountArray.contains( where: $0.secondAccount.contains))}).map{$0.creditAmount}.reduce(0, +)
        
            let importeUno = importe1 - importe2 + importe3 - importe4
            
            return importeUno
        }
        
        
        func importeDosCuenta ( postings:[Posting], cuenta:[PAndLLine.AccountsInLine]) -> Double  {
            
            var accountArray:[String] = []
            for item in  cuenta {
                accountArray.append(item.account)
            }
            
            let importe1 = postings.filter({($0.date >= fechaInforme2desde)&&($0.date <= fechaInforme2hasta) && (accountArray.contains( where: $0.firstAccount.contains))}).map{$0.debitAmount}.reduce(0, +)
        
            let importe2 = postings.filter({($0.date >= fechaInforme2desde)&&($0.date <= fechaInforme2hasta) && (accountArray.contains( where: $0.firstAccount.contains))}).map{$0.creditAmount}.reduce(0, +)
        
            let importe3 = postings.filter({($0.date >= fechaInforme2desde)&&($0.date <= fechaInforme2hasta) && (accountArray.contains( where: $0.secondAccount.contains))}).map{$0.debitAmount}.reduce(0, +)
        
            let importe4 = postings.filter({($0.date >= fechaInforme2desde)&&($0.date <= fechaInforme2hasta) && (accountArray.contains( where: $0.secondAccount.contains))}).map{$0.creditAmount}.reduce(0, +)
        
            let importeDos = importe1 - importe2 + importe3 - importe4
            
            return importeDos
        }
        
        var body: some View {
            
            VStack {
                Text ("Profit and loss ")
                HStack{
                Text (" Periodo 1 del \(fechaInforme1desde) hasta \(fechaInforme1hasta)")
                    Text (" Periodo 2 del \(fechaInforme2desde) hasta \(fechaInforme2hasta)")
                }
            }
            
            ForEach (pAndLLines) { linea  in
                if linea.accounts.count == 0 {
                    
                    Text ( linea.name)
                    
                } else {
                    
                    let a = importeUnoCuenta(postings: postings, cuenta: linea.accounts)
                    let b = importeDosCuenta(postings: postings, cuenta: linea.accounts)
                    let c = a - b
                    let d = c / a
                    
                    HStack {
                        
                        Text ( linea.name)
                        Spacer()
                        Text (String(format: "%.2f", a ))
                        Text (String(format: "%.2f", b ))
                        Text (String(format: "%.2f", c ))
                        Text (String(format: "%.2f", d ))
                    }
                }
            }
        }
    }
}
