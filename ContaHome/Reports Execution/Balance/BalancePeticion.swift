//
//  BalancePeticion.swift
//  ContaHome
//
//  Created by Pablo Penalva on 24/5/22.
//

import SwiftUI

struct BalancePeticion: View {
    
    @State private var fechaInforme = defaultFechaInforme
    @State private var buttonPressed = false
    
    
    @Binding var accounts: [Account]
    @Binding var postings: [Posting]
    @Binding var balanceLines: [BalanceLine]
    
    static var defaultFechaInforme: Date {
        var components = Calendar.current.dateComponents([.year, .month], from: Date.now)
        components.hour = (components.hour ?? 0) - 1
        return  Calendar.current.date(from: components) ?? Date.now
    }
    
    
    var body: some View {
        NavigationView {
            
            VStack {
                
                DatePicker ("Date", selection: $fechaInforme, in:...Date(), displayedComponents: .date)
                
                
                Button("Execute") { buttonPressed = true }
                NavigationLink("", destination:
                                BalanceExecution ( accounts: $accounts, postings: $postings, balanceLines: $balanceLines, fechaInforme:$fechaInforme),
                               isActive: $buttonPressed)
            }
        }
    }
}

