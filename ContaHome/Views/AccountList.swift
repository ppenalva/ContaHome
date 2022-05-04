//
//  AccountList.swift
//  ContaHome
//
//  Created by Pablo Penalva on 27/4/22.
//

import SwiftUI

struct AccountList: View {
    @State var accounts = Account.sampleData
    @State var postings = Posting.sampleData
  
    
    var body: some View {
        NavigationView {
            List(accounts) { account in
                NavigationLink {
                    AccountDetail(account: account, postings: $postings, accounts: $accounts)
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
