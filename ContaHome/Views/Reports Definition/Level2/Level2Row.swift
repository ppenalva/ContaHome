//
//  Level2Row.swift
//  ContaHome
//
//  Created by Pablo Penalva on 23/5/22.
//

import SwiftUI

struct Level2Row: View {
    var level2:  Level2
    
    var body: some View {
        HStack {
        
            Text(level2.name)
        }
    }
}

struct Level2Row_Previews: PreviewProvider {
    static var level2s = Level2.sampleData
    
    static var previews: some View {
        Group {
            Level2Row(level2: level2s[0])
            Level2Row(level2: level2s[1])
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
