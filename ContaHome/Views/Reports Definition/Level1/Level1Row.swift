//
//  Level1Row.swift
//  ContaHome
//
//  Created by Pablo Penalva on 23/5/22.
//

import SwiftUI

struct Level1Row: View {
    var level1:  Level1
    
    var body: some View {
        HStack {
        
            Text(level1.name)
        }
    }
}

struct Level1Row_Previews: PreviewProvider {
    static var level1s = Level1.sampleData
    
    static var previews: some View {
        Group {
            Level1Row(level1: level1s[0])
            Level1Row(level1: level1s[1])
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
