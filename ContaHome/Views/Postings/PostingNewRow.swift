//
//  PostingNewRow.swift
//  ContaHome
//
//  Created by Pablo Penalva on 10/6/22.
//

import SwiftUI

struct PostingNewRow: View {
    
    @Binding var data: Posting.Data
    @Binding var accounts: [Account]
    
    static var defaultDate: Date {
        return Date.now
    }
    
    var body: some View {
        VStack {
            HStack {
                DatePicker ("Date", selection: $data.date, in:...Date(), displayedComponents: .date)
                TextField ("Description", text: $data.description)
                    .frame(minWidth: 400, idealWidth: 600, maxWidth: 800, minHeight: 20, idealHeight: 20, maxHeight: 20)
                Spacer()
                TextField("Debit Amount", value: $data.debitAmount, format: .number)
                    .frame(minWidth: 100, idealWidth: 200, maxWidth: 300, minHeight: 20, idealHeight: 20, maxHeight: 20)
                TextField("Credit Amount", value: $data.creditAmount, format: .number)
                    .frame(minWidth: 100, idealWidth: 200, maxWidth: 300, minHeight: 20, idealHeight: 20, maxHeight: 20)
                    }
            .frame(width: 1000, height: 40)
            
            HStack {
                Picker("Account", selection: $data.secondAccount) {
                    ForEach(accounts, id: \.self) {account in
                        Text(account.name) .tag(account.name )
                            .frame(minWidth: 400, idealWidth: 600, maxWidth: 800, minHeight: 20, idealHeight: 20, maxHeight: 20)
                    }
                }
                Spacer()
            }
            .frame(width: 1000, height: 40)
        }
    }
}
struct PostingNewRow_Previews: PreviewProvider {
    static var postings = Posting.sampleData
    
    static var previews: some View {
        PostingCreditRow(posting: postings[0])
    }
}
