//
//  ReportTwo.swift
//  ContaHome
//
//  Created by Pablo Penalva on 9/5/22.
//

import SwiftUI

struct ReportTwo: View {

    struct AccountBalancesList {
    var number: String = ""
    var name: String = ""
    var balanceAmount: Double = 0.0
    var total = 0.0
    
        
        mutating func calculo() {
            @Binding var accounts: [Account]
            @Binding var postings: [Posting]
    //        var accountBalancesList: [AccountBalancesList]
            
    //        for account in $accounts {
    //            for posting in $postings {
                    
                    
                }
  //              accountBalancesList.name = account.name
  //          }
            
  //      }
        
        
        
        
    }

   
    
var body: some View {
        

    Text("Hello World")
    
}
}






struct ReportTwo_Previews: PreviewProvider {
    static var previews: some View {
        ReportTwo()
    }
}
