//
//  PostingEditRow.swift
//  ContaHome
//
//  Created by Pablo Penalva on 28/4/22.
//

import SwiftUI

struct PostingEditRow: View {
    @Binding var posting: Posting
    
    var body: some View {
        
        VStack {
            HStack {
                TextField ("Date", text: $posting.date)
                
                
                TextField ("Description", text: $posting.description)
                Spacer()
                
                //                TextField("Debit Amount",text:String( format: "%.1f",$posting.debitAmount)
                //            Text(String(format: "%.2f", posting.debitAmount))
                //
            }
            HStack {
                TextField("Account", text: $posting.firstAccount)
                //              Text(posting.firstAccountName)
                
                Spacer()
                
            }
        }
    }
}


struct PostingEditRow_Previews: PreviewProvider {
    static var previews: some View {
        PostingCreditRow(posting: postings[0])
    }
}
