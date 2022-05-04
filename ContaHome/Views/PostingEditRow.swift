//
//  PostingEditRow.swift
//  ContaHome
//
//  Created by Pablo Penalva on 28/4/22.
//

import SwiftUI

struct PostingEditRow: View {
    
    @Binding var data: Posting.Data
    @Binding var accounts: [Account]
   
    
    var body: some View {
        VStack {
            HStack {
                
               
                
                DatePicker ("Date", selection: $data.date, in:...Date(), displayedComponents: .date)
 
                
                
                TextField ("Description", text: $data.description)
                Spacer()
                
                //                TextField("Debit Amount",text:String( format: "%.1f",$posting.debitAmount)
                //            Text(String(format: "%.2f", posting.debitAmount))
                //
            }
            HStack {
               
                NavigationView{
                    Form {
                        Section{
                
                Picker("Account", selection: $data.secondAccount) {
                    ForEach(accounts, id: \.id) {account in
                        Text(account.number)
                    }
                }
                }
                }
                }
                
                Spacer()
                
            }
        }
    }
}


struct PostingEditRow_Previews: PreviewProvider {
    static var postings = Posting.sampleData
    
    static var previews: some View {
        PostingCreditRow(posting: postings[0])
    }
}
