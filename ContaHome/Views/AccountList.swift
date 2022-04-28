//
//  AccountList.swift
//  ContaHome
//
//  Created by Pablo Penalva on 27/4/22.
//

import SwiftUI

struct AccountList: View {
    
    
    
    var body: some View {
        NavigationView {
            List(accounts) { account in
                NavigationLink {
                    AccountDetail(account: account)
                } label: {
                    AccountRow(account: account)
                }
                
            }
        }
        .navigationTitle("Account")
    }
}

struct AccountList_Previews: PreviewProvider {
    static var previews: some View {
        AccountList()
    }
}
