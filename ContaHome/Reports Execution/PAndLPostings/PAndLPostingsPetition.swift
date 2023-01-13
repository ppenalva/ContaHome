//
//  PAndLPetition.swift
//  ContaHome
//
//  Created by Pablo Penalva on 13/6/22.
//

import SwiftUI

struct PAndLPostingsPetition: View {
    
    @State var fechaInforme1desde = defaultFechaInforme1
    @State var fechaInforme1hasta = defaultFechaInforme2
    @State var fechaInforme2desde = defaultFechaInforme3
    @State var fechaInforme2hasta = defaultFechaInforme4
    
    @State var buttonPressed = false
    
    
    @Binding var accounts: [Account]
    @Binding var postings: [Posting]
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
    
    static var defaultFechaInforme3: Date {
        var components = Calendar.current.dateComponents([.year], from: Date.now)
        components.year = (components.year ?? 0) - 1
        return  Calendar.current.date(from: components) ?? Date.now
    }
    
    static var defaultFechaInforme4: Date {
        var components = Calendar.current.dateComponents([.year, .month], from: Date.now)
        components.year = (components.year ?? 0) - 1
        components.hour = (components.hour ?? 0) - 1
        return  Calendar.current.date(from: components) ?? Date.now
    }
    
    
    var body: some View {
        NavigationView {
            
            VStack {
                
               DatePicker ("Date 1 from:", selection: $fechaInforme1desde, in:...Date(), displayedComponents: .date)
                DatePicker ("Date 1 to:", selection: $fechaInforme1hasta, in:...Date(), displayedComponents: .date)
                DatePicker ("Date 2 from:", selection: $fechaInforme2desde, in:...Date(), displayedComponents: .date)
                DatePicker ("Date 2 to:", selection: $fechaInforme2hasta, in:...Date(), displayedComponents: .date)
                
                
                Button("Execute") { buttonPressed = true }
                NavigationLink("", destination:
                                PAndLPostingsExecution ( accounts: $accounts, postings: $postings, pAndLLines: $pAndLLines, fechaInforme1desde: $fechaInforme1desde,  fechaInforme1hasta: $fechaInforme1hasta, fechaInforme2desde: $fechaInforme2desde, fechaInforme2hasta: $fechaInforme2hasta),
                               isActive: $buttonPressed)
            }
        }
    }
}

