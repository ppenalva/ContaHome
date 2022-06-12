//
//  PostingEditRow.swift
//  ContaHome
//
//  Created by Pablo Penalva on 28/4/22.
//

//import SwiftUI
//
//struct PostingEditRow: View {
//    
////    @Binding var selectedAccount: Account
//    
//    @Binding var data: Posting.Data
//    @Binding var accounts: [Account]
//    
//    var body: some View {
//        VStack {
//            HStack {
//                DatePicker ("Date", selection: $data.date, in:...Date(), displayedComponents: .date)
//                TextField ("Description", text: $data.description)
//                Spacer()
//                TextField("Debit Amount", value: $data.amount, format: .number)
//                TextField("Credit Amount", value: $data.amount, format: .number)
//            }
//            HStack {
//                Picker("Account", selection: $data.secondAccount) {
//                    ForEach(self.accounts, id: \.self) {account in
//                        Text(account.name)
//                    }
//                }
//                Spacer()
//            }
//        }
//    }
//}
//
//struct PostingEditRow_Previews: PreviewProvider {
//    static var postings = Posting.sampleData
//    
//    static var previews: some View {
//        PostingCreditRow(posting: postings[0])
//    }
//}
