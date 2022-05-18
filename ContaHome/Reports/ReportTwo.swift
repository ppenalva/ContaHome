//
//  ReportTwo.swift
//  ContaHome
//
//  Created by Pablo Penalva on 9/5/22.
//

import SwiftUI

struct ReportTwo: View {
    
    @Binding var accounts: [Account]
    @Binding var postings: [Posting]
    
    @State var listLines = [ListReport]()
    
    class ListReport: Identifiable {
        
        var number: String = ""
        var name: String = ""
        var amount: Double = 0.0
        
        init( number: String, name: String, amount: Double) {
            self.number = number
            self.name = name
            self.amount = amount
        }
        
      
    }
    
    func updateListReport() {
        
       
        var totAmount: Double = 0.0
        
       
        
        for account in accounts {
            for posting in postings {
                if posting.firstAccount == account.number {
                    totAmount += posting.debitAmount
                    totAmount -= posting.creditAmount
                    
                }
                if posting.secondAccount == account.number {
                    totAmount -= posting.debitAmount
                    totAmount += posting.creditAmount
                }
            }
        
            let listLine = ListReport( number:account.number, name:account.name, amount: totAmount)
            listLines.append(listLine)
            totAmount = 0.0
        }
    }
   
    
    var body: some View {
        
         VStack {
            
            Text("Balance Report")
             
             List {
            ForEach (listLines) { listLine in

                HStack {
                Text(listLine.number)
                Text(listLine.name)
                Text(String(format: "%.2f", listLine.amount))
                }
              }
            
        }
        .onAppear {updateListReport()}
         }
    }
}







struct ReportTwo_Previews: PreviewProvider {
    static var previews: some View {
        ReportTwo(accounts:.constant(Account.sampleData), postings: .constant(Posting.sampleData))
    }
}
