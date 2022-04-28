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
                    
            
                Text(posting.description)
                    Spacer()
                Text(String(format: "%.2f", posting.debitAmount))
            Text(String(format: "%.2f", posting.creditAmount))
            
            }
            HStack {
                Text(posting.firstAccount)
                }
    Spacer()
        
            
            }
        }
    }


struct PostingRow_Previews: PreviewProvider {
    static var previews: some View {
        PostingRow(posting: postings[0])
    }
}
