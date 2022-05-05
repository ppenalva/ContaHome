//
//  GroupEdit.swift
//  ContaHome
//
//  Created by Pablo Penalva on 4/5/22.
//

import SwiftUI

struct GroupDetail: View {
    
    var accountGroup: AccountGroup
    
    @Binding var accounts: [Account]
    
    
    
    @State private var isPresentingNewGroupView = false
    @State private var newGoupData = AccountGroup.Data()
    
    
    var body: some View {
        
        Text("\(accountGroup.name)")
        ForEach (accountGroup.group) { account in
            Text("\(account.number)")
        }
    }
}


//struct AccountDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            AccountDetail(accounts: .constant(Account.sampleData.accounts[0]))
//        }
//    }
//}
