//
//  Level2Edit.swift
//  ContaHome
//
//  Created by Pablo Penalva on 23/5/22.
//

import SwiftUI

struct Level2Edit: View {
    
    @Binding var data: Level2.Data
    @Binding var accounts: [Account]
    
    @State private var newAccounts = ""
    
    var body: some View {
        
        VStack {
            TextField("Number", text: $data.number)
            TextField("Name", text: $data.name)
            List {
                ForEach (data.accounts ) { accounts in
                    Text(accounts.number)
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
                        let accounts = Level2.AccountsInLevel2(number:newAccounts)
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


struct Level2Edit_Previews: PreviewProvider {
    static var previews: some View {
        Level2Edit(data: .constant(Level2.sampleData[0].data), accounts: .constant(Account.sampleData))
    }
}
