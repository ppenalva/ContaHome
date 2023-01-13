//
//  P&LLineRow.swift
//  ContaHome
//
//  Created by Pablo Penalva on 13/6/22.
//

import SwiftUI

struct PAndLLineRow: View {
    var pAndLLine:  PAndLLine
    
    var body: some View {
        HStack {
        
            Text(pAndLLine.name)
        }
    }
}

struct PAndLLineRow_Previews: PreviewProvider {
    static var pAndLLines = PAndLLine.sampleData
    
    static var previews: some View {
        Group {
            PAndLLineRow(pAndLLine: pAndLLines[0])
            PAndLLineRow(pAndLLine: pAndLLines[1])
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
