//
//  BalancePeticion.swift
//  ContaHome
//
//  Created by Pablo Penalva on 24/5/22.
//

import SwiftUI

struct BalancePeticion: View {
    
    @State var fechaInforme: Date
    @State var buttonPressed = false
    
    
    @Binding var accounts: [Account]
    @Binding var postings: [Posting]
    @Binding var balanceLines: [BalanceLine]
    
    
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

