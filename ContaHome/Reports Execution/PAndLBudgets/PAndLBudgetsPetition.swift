//
//  PAndLBudgetsPetition.swift
//  ContaHome
//
//  Created by Pablo Penalva on 12/1/23.
//

import SwiftUI

struct PAndLBudgetsPetition: View {
    
    @State var fechaInforme1desde = defaultFechaInforme1
    @State var fechaInforme1hasta = defaultFechaInforme2
    
    @State var buttonPressed = false
    
    
    @Binding var accounts: [Account]
    @Binding var postings: [Posting]
    @Binding var budgets: [Budget]
    @Binding var pAndLLines: [PAndLLine]
    
    static var defaultFechaInforme1: Date {
        let components = Calendar.current.dateComponents([.year], from: Date.now)
        return  Calendar.current.date(from: components) ?? Date.now
    }
    
    static var defaultFechaInforme2: Date {
        var components = Calendar.current.dateComponents([.year, .month], from: Date.now)
        components.hour = (components.hour ?? 0) - 1
        return  Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationView {
            
            VStack {
                
               DatePicker ("Date 1 from:", selection: $fechaInforme1desde, in:...Date(), displayedComponents: .date)
                DatePicker ("Date 1 to:", selection: $fechaInforme1hasta, in:...Date(), displayedComponents: .date)
                
                Button("Execute") { buttonPressed = true }
                NavigationLink("", destination:
                                PAndLBudgetsExecution ( accounts: $accounts, postings: $postings,budgets: $budgets,pAndLLines: $pAndLLines, fechaInforme1desde: $fechaInforme1desde,  fechaInforme1hasta: $fechaInforme1hasta),
                               isActive: $buttonPressed)
            }
        }
    }
}

