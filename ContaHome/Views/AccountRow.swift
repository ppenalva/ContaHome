//
//  AccountRow.swift
//  ContaHome
//
//  Created by Pablo Penalva on 27/4/22.
//

import SwiftUI

struct AccountRow: View {
    var account: Account
    
    
    var body: some View {
        
        HStack {
            Text(account.number)
            Spacer()
            Text(account.name)
        }
    }
}

struct AccountRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AccountRow(account: accounts[0])
            AccountRow(account: accounts[1])
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
