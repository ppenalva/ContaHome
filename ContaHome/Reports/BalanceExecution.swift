//
//  BalanceExecution.swift
//  ContaHome
//
//  Created by Pablo Penalva on 24/5/22.
//

import SwiftUI

struct BalanceExecution: View {
    
    @Binding var accounts: [Account]
    @Binding var postings: [Posting]
    
    @Binding var reports: [Report]
    @Binding var level1s: [Level1]
    @Binding var level2s: [Level2]
    
    @Binding var report: String
    @Binding var fechaInforme: Date
    
    
    @State private var totLevel2 = 0.0
    
    
    
    
  
    func importeCuenta ( postings:[Posting], cuenta: String) -> Double  {
        
        let importe1 = postings.filter({$0.date <= fechaInforme && $0.firstAccount == cuenta }).map{$0.debitAmount}.reduce(0, +)
        let importe2 = postings.filter({$0.date <= fechaInforme && $0.firstAccount == cuenta }).map{$0.creditAmount}.reduce(0, +)
        let importe3 = postings.filter({$0.date <= fechaInforme && $0.secondAccount == cuenta }).map{$0.debitAmount}.reduce(0, +)
        let importe4 = postings.filter({$0.date <= fechaInforme && $0.secondAccount == cuenta }).map{$0.creditAmount}.reduce(0, +)
        let importe = importe1 - importe2 - importe3 + importe4
        
        return importe
    }
    
    
    
   
    //        for account in accounts {
    //            for posting in postingFiltered {
    //                if posting.firstAccount == account.number {
    //                    totAmount += posting.debitAmount
    //                    totAmount -= posting.creditAmount
    //                }
    //                if posting.secondAccount == account.number {
    //                    totAmount -= posting.debitAmount
    //                    totAmount += posting.creditAmount
    //                }
    //            }
    //
    //
    //            listLines.append(ListReport( number:account.number, name:account.name, amount: totAmount))
    //            totAmount = 0.0
    //        }
    //
    //    }
    
    var body: some View {
        
  //
        
     
        
        ForEach (reports.filter {$0.number == report}) { listado in
            Text(listado.name)
            
           
            
            ForEach ( listado.level1 ) { nivel1 in
                ForEach (level1s.filter {$0.number == nivel1.number}) { level1 in
                    Text (level1.name)
                   
                    
                    ForEach (level1.level2) { nivel2 in
                        ForEach(level2s.filter{$0.number == nivel2.number}) { level2 in
                            Text( level2.name)
                            
                        
                            
                            ForEach (level2.accounts) { account in
                                
                                let a = importeCuenta(postings: postings, cuenta: account.number)



                                if (a != 0.0) {
                                   HStack {
                                    Text (account.number)
                                  //  Text (account.name)
                                    Text (String(format: "%.2f", a))
                                   }
                                } else {
                                    Text("")
                                }
                            }
                        }
//                        if ( totLevel2 != 0.0) {
//                            Text(String(format: "%.2f",totLevel2))
//                            totLevel2 = 0.0
//                        }
                    }
                }
            }
        }
    }
}










//struct ReportTwo_Previews: PreviewProvider {
//    static var previews: some View {
//        ReportTwo(accounts:.constant(Account.sampleData), postings: .constant(Posting.sampleData), reports: .constant(Report.sampleData))
//    }
//}
