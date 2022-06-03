//
//  Level1Edit.swift
//  ContaHome
//
//  Created by Pablo Penalva on 23/5/22.
//

import SwiftUI

struct Level1Edit: View {
    
    @Binding var data: Level1.Data
    @Binding var level2s: [Level2]
    
    @State private var newLevel2 = ""

    var body: some View {
       
        VStack {
            TextField("Number", text: $data.number)
            TextField("Name", text: $data.name)
            
            List {
        
            ForEach (data.level2) { level2 in
                Text(level2.number)
            }
            .onDelete (perform: delete)
            }
            HStack {
                
                Picker("Level2", selection: $newLevel2) {
                    ForEach(self.level2s, id: \.self) {level2 in
                        Text(level2.number + " " + level2.name).tag(level2.number)                            }
                }
                
                Button(action: {
                    withAnimation {
                        let level2 = Level1.Level2InLevel1(number:newLevel2)
                        data.level2.append(level2)
                        newLevel2 = ""
                    }
                }) {
                    Image(systemName: "plus.circle.fill")
                }
                .disabled(newLevel2.isEmpty)
                
                }
            }
        }
    func delete(at offsets: IndexSet) {
        data.level2.remove(atOffsets: offsets)
    }
    
}

struct Level1Edit_Previews: PreviewProvider {
    static var previews: some View {
        Level1Edit(data: .constant(Level1.sampleData[0].data), level2s: .constant(Level2.sampleData))
    }
}
