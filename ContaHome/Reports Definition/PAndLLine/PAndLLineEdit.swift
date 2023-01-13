//
//  P&LLineEdit.swift
//  ContaHome
//
//  Created by Pablo Penalva on 13/6/22.
//

import SwiftUI

struct PAndLLineEdit: View {
    
    @Binding var data: PAndLLine.Data
    @Binding var accounts: [Account]
    
    @State private var newAccounts = ""
    
    var body: some View {
        
        VStack {

            TextField("Name", text: $data.name)
            List {
                ForEach (data.accounts ) { accounts in
                    Text(accounts.account)
                }
                .onDelete(perform: delete)
            }
            
            HStack {
                
                Picker("Account", selection: $newAccounts) {
                    ForEach(self.accounts, id: \.self) {account in
                        Text(account.name).tag(account.name)                            }
                }
                
                Button(action: {
                    withAnimation {
                        let accounts = PAndLLine.AccountsInLine(account:newAccounts)
                        data.accounts.append(accounts)
                        newAccounts = ""
                    }
                }) {
                    Image(systemName: "plus.circle.fill")
                }
                .disabled(newAccounts.isEmpty)
                
            }
        }
    }
    func delete(at offsets: IndexSet) {
        data.accounts.remove(atOffsets: offsets)
    }
}


struct PAndLLineEdit_Previews: PreviewProvider {
    static var previews: some View {
        PAndLLineEdit(data: .constant(PAndLLine.sampleData[0].data), accounts: .constant(Account.sampleData))
    }
}
