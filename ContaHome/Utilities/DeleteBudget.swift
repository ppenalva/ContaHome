//
//  DeleteBudget.swift
//  ContaHome
//
//  Created by Pablo Penalva on 14/12/22.
//

import SwiftUI

struct BudgetDelete: View {
    
    @State var buttonPressed = false
    
    @Binding var accounts: [Account]
    @Binding var budgets: [Budget]
    
    let saveAction: ()->Void
    
    var body: some View {
        
        NavigationView {
            
            Button("Execute") {
                
                budgets.removeAll()
                
                
                saveAction()
            }
        }
    }
}
