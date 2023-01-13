//
//  BalanceLineRow.swift
//  ContaHome
//
//  Created by Pablo Penalva on 6/6/22.
//

import SwiftUI

struct BalanceLineRow: View {
    var balanceLine:  BalanceLine
    
    var body: some View {
        HStack {
        
            Text(balanceLine.name)
        }
    }
}

struct BalanceLineRow_Previews: PreviewProvider {
    static var balanceLines = BalanceLine.sampleData
    
    static var previews: some View {
        Group {
            BalanceLineRow(balanceLine: balanceLines[0])
            BalanceLineRow(balanceLine: balanceLines[1])
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
