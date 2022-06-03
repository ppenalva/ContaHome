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
    
    @Binding var reports: [Report]
    @Binding var level1s: [Level1]
    @Binding var level2s: [Level2]
   
    
    @State var report = "01"
    
    var body: some View {
        NavigationView {
        
        VStack {
            
            DatePicker ("Date", selection: $fechaInforme, in:...Date(), displayedComponents: .date)
       
        
            Button("Execute") { buttonPressed = true }
            NavigationLink("", destination:
                            BalanceExecution (accounts: $accounts, postings: $postings, reports: $reports, level1s: $level1s, level2s:$level2s, report: $report, fechaInforme:$fechaInforme),
                               isActive: $buttonPressed)
                                
            
           
        }
    }
}
}

//struct BalancePeticion_Previews: PreviewProvider {
//    static var previews: some View {
//        BalancePeticion(fechaInforme: Date())
//    
//    }
//}
