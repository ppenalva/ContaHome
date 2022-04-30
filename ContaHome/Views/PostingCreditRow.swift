//
//  PostingCreditRow.swift
//  ContaHome
//
//  Created by Pablo Penalva on 28/4/22.
//

import SwiftUI

struct PostingCreditRow: View {
    var posting: Posting
    
    var body: some View {
        
        VStack {
            HStack {
                Text(posting.date)
                
                
                Text(posting.description)
                Spacer()
                Text(String(format: "%.2f", posting.creditAmount))
                Text(String(format: "%.2f", posting.debitAmount))
                
            }
            HStack {
                Text(posting.firstAccount)
                Text(posting.firstAccountName)
                
                Spacer()
                
            }
        }
    }
}


struct PostingCreditRow_Previews: PreviewProvider {
    static var previews: some View {
        PostingCreditRow(posting: postings[0])
    }
}
