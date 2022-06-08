//
//  BalanceLineDetail.swift
//  ContaHome
//
//  Created by Pablo Penalva on 6/6/22.
//

import SwiftUI

struct BalanceLineDetail: View {
    
    @Binding var balanceLine: BalanceLine
    @Binding var accounts: [Account]
    
    @State private var data = BalanceLine.Data()
    @State private var isPresentingEditView = false
    
    var body: some View {
        Form {
            VStack {
                
                ForEach (balanceLine.accounts) { account in
                    Text(account.account)
                }
            }
            
            .navigationTitle(balanceLine.name)
            .toolbar {
                Button("Edit") {
                    isPresentingEditView = true
                    data = balanceLine.data
                }
            }
            .sheet(isPresented: $isPresentingEditView) {
              
                    BalanceLineEdit(data: $data, accounts: $accounts)
                        .navigationTitle(balanceLine.name)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancel") {
                                    isPresentingEditView = false
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Done") {
                                    isPresentingEditView = false
                                    balanceLine.update(from: data)
                                }
                            }
                        }
                
            }
        }
        
    }
}



struct BalanceLineDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BalanceLineDetail(balanceLine: .constant(BalanceLine.sampleData[0]), accounts: .constant(Account.sampleData))
        }
    }
}
