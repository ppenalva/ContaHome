//
//  AccountRow.swift
//  ContaHome
//
//  Created by Pablo Penalva on 27/4/22.
// cambio de prueba y ahora otro

import SwiftUI

struct AccountRow: View {
    var account: Account
    
    var body: some View {
        
            Text(account.name)

        .frame(width: 200, height: 15, alignment: .leading)
    }
}

struct Account_Previews: PreviewProvider {
    static var accounts = Account.sampleData
    
    static var previews: some View {
        Group {
            AccountRow(account: accounts[0])
            AccountRow(account: accounts[1])
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
