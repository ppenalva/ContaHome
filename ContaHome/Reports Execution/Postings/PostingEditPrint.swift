//
//  PostingEditPrint.swift
//  ContaHome
//
//  Created by Pablo Penalva on 8/1/23.
//

import SwiftUI

struct PostingEditPrint: View {
    
    var posting: Posting
    
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    
    var body: some View {
        VStack {
            HStack {
                Text(posting.date, formatter: PostingEditPrint.taskDateFormat)
                Text(posting.description)
                Spacer()
                
                    Text(String(format: "%.2f", posting.debitAmount))
                    Text(String(format: "%.2f", posting.creditAmount))
                            }
            HStack {
                Text(posting.firstAccount)
                Spacer()
                Text(posting.secondAccount)
            }
            
        }
    }
}

struct PostingEditPrint_Previews: PreviewProvider {
    static var postings = Posting.sampleData
    
    static var previews: some View {
        PostingDebitRow(posting: postings[0])
    }
}
