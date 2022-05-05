//
//  GroupList.swift
//  ContaHome
//
//  Created by Pablo Penalva on 4/5/22.
//

import SwiftUI

struct GroupList: View {
    
    @State var accountGroups = AccountGroup.sampleData
    @State var accounts = Account.sampleData
    
    var body: some View {
        NavigationView {
            List(accountGroups) { accountGroup in
                NavigationLink {
                    GroupDetail(accountGroup: accountGroup, accounts: $accounts)
                } label: {
                    GroupRow(accountGroup: accountGroup)
                }
                
            }
           
            .navigationTitle("AccountGroup")
        }
    }
}

//struct AccountList_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountList()
//    }
//}
