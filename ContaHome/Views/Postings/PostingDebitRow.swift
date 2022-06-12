//
//  PostingRow.swift
//  ContaHome
//
//  Created by Pablo Penalva on 27/4/22.
//

import SwiftUI

struct PostingDebitRow: View {
    
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
                    Text(String(format: "%.2f", posting.debitAmount))
                Text(String(format: "%.2f", posting.creditAmount))
                            }
            HStack {
                Text(posting.secondAccount)
                Spacer()
                
            }
            
        }
        .frame(width: 300, height: 50, alignment: .trailing)
    }
}

struct PostingDebitRow_Previews: PreviewProvider {
    static var postings = Posting.sampleData
    
    static var previews: some View {
        PostingDebitRow(posting: postings[0])
    }
}
