//
//  AccountDetail.swift
//  ContaHome
//
//  Created by Pablo Penalva on 27/4/22.
//

import SwiftUI

struct AccountDetail: View {
    var account: Account
    
    var filteredPostings: [Posting] {
        postings.filter { posting in
            (posting.debitAccount == account.number || posting.creditAccount == account.number)
        }
    }
    
    var body: some View {
        List(filteredPostings) { posting in
                NavigationLink {
                    
                } label: {
                    PostingRow(posting: posting)
            }
        }
    }
}

struct AccountDetail_Previews: PreviewProvider {
    static var previews: some View {
        AccountDetail(account: accounts[0])
    }
}
