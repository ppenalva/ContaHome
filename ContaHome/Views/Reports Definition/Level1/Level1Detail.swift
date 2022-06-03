//
//  Level1Detail.swift
//  ContaHome
//
//  Created by Pablo Penalva on 23/5/22.
//

import SwiftUI

struct Level1Detail: View {
    
    @Binding var level1: Level1
    @Binding var level2s: [Level2]
    
    @State private var data = Level1.Data()
    @State private var isPresentingEditView = false
    
    var body: some View {
        Form {
        VStack {
        
            ForEach (level1.level2) { account in
                Text(account.number)
            }
        }
        
        .navigationTitle(level1.name)
        .toolbar {
            Button("Edit") {
                isPresentingEditView = true
                data = level1.data
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
        
            Level1Edit(data: $data, level2s: $level2s)
                    .navigationTitle(level1.name)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingEditView = false
                                level1.update(from: data)
                            }
                        }
                    }
            }
        }
        
    }
}



struct Level1Detail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Level1Detail(level1: .constant(Level1.sampleData[0]),level2s: .constant(Level2.sampleData))
        }
    }
}
