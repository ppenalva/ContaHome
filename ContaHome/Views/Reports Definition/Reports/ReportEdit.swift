//
//  ReportEdit.swift
//  ContaHome
//
//  Created by Pablo Penalva on 19/5/22.
//

import SwiftUI

struct ReportEdit: View {
    
    @Binding var data: Report.Data
    @Binding var level1s: [Level1]
    
    @State private var newLevel1 = ""
    
    
    
    var body: some View {
        
        VStack{
        TextField( "Number", text: $data.number)
        TextField( "Name", text: $data.name)
        
            List {
         
            ForEach (data.level1) { level1 in
                Text(level1.number)
            }
            .onDelete (perform: delete)
            }
            HStack {
                Picker( "Level1", selection: $newLevel1) {
                    ForEach(self.level1s, id: \.self) {level1 in
                        Text(level1.number + " " + level1.name).tag(level1.number)
                    }
                }
                    
                Button(action: {
                    withAnimation {
                        let level1 = Report.Level1InReport(number:newLevel1)
                        data.level1.append(level1)
                        newLevel1 = ""
                    }
                }) {
                    Image(systemName: "plus.circle.fill")
                        
                    }
                .disabled(newLevel1.isEmpty)
                }
            }
        }

    func delete(at offsets: IndexSet) {
        data.level1.remove(atOffsets: offsets)
    }
}

struct ReportEdit_Previews: PreviewProvider {
    static var previews: some View {
        ReportEdit(data: .constant(Report.sampleData[0].data), level1s: . constant(Level1.sampleData))
    }
}
