//
//  BalanceLineEdit.swift
//  ContaHome
//
//  Created by Pablo Penalva on 6/6/22.
//

import SwiftUI

struct BalanceLineEdit: View {
    
    @Binding var data: BalanceLine.Data
    @Binding var accounts: [Account]
    
    @State private var newAccounts = ""
    
    var body: some View {
        
        VStack {
//            TextField("Number", text: $data.number)
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
                        Text(account.number + " " + account.name).tag(account.number)                            }
                }
                
                Button(action: {
                    withAnimation {
                        let accounts = BalanceLine.AccountsInLine(account:newAccounts)
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


struct BalanceLineEdit_Previews: PreviewProvider {
    static var previews: some View {
        BalanceLineEdit(data: .constant(BalanceLine.sampleData[0].data), accounts: .constant(Account.sampleData))
    }
}
