//
//  DeletePosting.swift
//  ContaHome
//
//  Created by Pablo Penalva on 10/6/22.
//

import SwiftUI

struct PostingDeletePetition: View {
    
    @State var buttonPressed = false
    
    @Binding var accounts: [Account]
    @Binding var postings: [Posting]
    
    let saveAction: ()->Void
    
    var body: some View {
        
        NavigationView {
            
            Button("Execute") {
                
                postings.removeAll()
                
                
                saveAction()
            }
        }
    }
}

