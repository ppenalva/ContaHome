//
//  P&LLineDetail.swift
//  ContaHome
//
//  Created by Pablo Penalva on 13/6/22.
//

import SwiftUI

struct PAndLLineDetail: View {
    
    @Binding var pAndLLine: PAndLLine
    @Binding var accounts: [Account]
    
    @State private var data = PAndLLine.Data()
    @State private var isPresentingEditView = false
    
    var body: some View {
        Form {
            VStack {
                
                ForEach (pAndLLine.accounts) { account in
                    Text(account.account)
                }
            }
            
            .navigationTitle(pAndLLine.name)
            .toolbar {
                Button("Edit") {
                    isPresentingEditView = true
                    data = pAndLLine.data
                }
            }
            .sheet(isPresented: $isPresentingEditView) {
              
                    PAndLLineEdit(data: $data, accounts: $accounts)
                        .navigationTitle(pAndLLine.name)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancel") {
                                    isPresentingEditView = false
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Done") {
                                    isPresentingEditView = false
                                    pAndLLine.update(from: data)
                                }
                            }
                        }
                
            }
        }
        
    }
}



struct PAndLLineDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PAndLLineDetail(pAndLLine: .constant(PAndLLine.sampleData[0]), accounts: .constant(Account.sampleData))
        }
    }
}
