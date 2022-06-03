//
//  Level2Detail.swift
//  ContaHome
//
//  Created by Pablo Penalva on 23/5/22.
//

import SwiftUI

struct Level2Detail: View {
    
    @Binding var level2: Level2
    @Binding var accounts: [Account]
    
    @State private var data = Level2.Data()
    @State private var isPresentingEditView = false
    
    var body: some View {
        Form {
            VStack {
                
                ForEach (level2.accounts) { account in
                    Text(account.number)
                }
            }
            
            .navigationTitle(level2.name)
            .toolbar {
                Button("Edit") {
                    isPresentingEditView = true
                    data = level2.data
                }
            }
            .sheet(isPresented: $isPresentingEditView) {
              
                    Level2Edit(data: $data, accounts: $accounts)
                        .navigationTitle(level2.name)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancel") {
                                    isPresentingEditView = false
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Done") {
                                    isPresentingEditView = false
                                    level2.update(from: data)
                                }
                            }
                        }
                
            }
        }
        
    }
}



struct Level2Detail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Level2Detail(level2: .constant(Level2.sampleData[0]), accounts: .constant(Account.sampleData))
        }
    }
}
