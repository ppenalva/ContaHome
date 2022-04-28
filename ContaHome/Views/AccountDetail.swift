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
            (posting.firstAccount == account.number || posting.secondAccount == account.number)

    }
    }
   
    
    
    
    
    var body: some View {
        
        ForEach (filteredPostings) { posting in
        
        }
        
                List(filteredPostings) { posting in
                NavigationLink {
                } label: {
                    if (account.number == posting.firstAccount) {
                    PostingDebitRow(posting: posting)
                    } else {
                        PostingCreditRow(posting: posting)
                    }
            
            }
           
        }
       .navigationTitle(account.number + " " + account.name)
    }
}

struct AccountDetail_Previews: PreviewProvider {
    static var previews: some View {
        AccountDetail(account: accounts[1])
    }
}
