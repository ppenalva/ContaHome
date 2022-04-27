//
//  PostingRow.swift
//  ContaHome
//
//  Created by Pablo Penalva on 27/4/22.
//

import SwiftUI

struct PostingRow: View {
    var posting: Posting
    
    var body: some View {
        
        VStack {
            HStack {
                Text(posting.date)
                Spacer()
                Text(posting.description)
                Spacer()
                Text(String(format: "%.2f", posting.amount))
            }
            HStack {
                Text(posting.debitAccount)
    
                Spacer()
                Text(posting.creditAccount)
            
            }
        }
    }
}

struct PostingRow_Previews: PreviewProvider {
    static var previews: some View {
        PostingRow(posting: postings[0])
    }
}
