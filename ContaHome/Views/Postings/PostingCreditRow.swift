//
//  PostingCreditRow.swift
//  ContaHome
//
//  Created by Pablo Penalva on 28/4/22.
//

import SwiftUI

struct PostingCreditRow: View {
    
    var posting: Posting
    
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    
    var body: some View {
        VStack {
            HStack {
                Text(posting.date, formatter: PostingDebitRow.taskDateFormat)
                Text(posting.description)
                Spacer()
                
                Text(String(format: "%.2f", posting.creditAmount))
                Text(String(format: "%.2f", posting.debitAmount))
            }
            
            HStack {
                Text(posting.secondAccount)
                Spacer()
            }
        }
    }
}

struct PostingCreditRow_Previews: PreviewProvider {
    static var postings = Posting.sampleData
    
    static var previews: some View {
        PostingCreditRow(posting: postings[0])
    }
}
