//
//  Level2List.swift
//  ContaHome
//
//  Created by Pablo Penalva on 23/5/22.
//

import SwiftUI

struct Level2List: View {
    
    @Binding var level2s: [Level2]
    @Binding var accounts: [Account]
    
    
    @State private var isPresentingNewLevel2 = false
    @State private var newLevel2Data = Level2.Data()
    
    var body: some View {
        NavigationView {
            List {
                ForEach($level2s) { $level2 in
                    NavigationLink(destination: Level2Detail(level2: $level2, accounts: $accounts)) {
                        Level2Row(level2: level2)
                    }
                }
                .onDelete(perform: deleteLevel2)
            }
            .navigationTitle("LEVEL2s")
            .toolbar {
                Button(action: {
                    isPresentingNewLevel2 = true
                }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $isPresentingNewLevel2) {
                NavigationView {
                    Level2Edit(data: $newLevel2Data, accounts: $accounts)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Dismiss") {
                                    isPresentingNewLevel2 = false
                                    newLevel2Data = Level2.Data()
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Add") {
                                    let newLevel2 = Level2(data: newLevel2Data)
                                    level2s.append(newLevel2)
                                    isPresentingNewLevel2 = false
                                    newLevel2Data = Level2.Data()
                                }
                            }
                        }
                }
            }
        }
    }
    func deleteLevel2( at offsets: IndexSet) {
        level2s.remove(atOffsets:offsets)
    }
}

struct Level2List_Previews: PreviewProvider {
    static var previews: some View {
        Level2List(level2s: .constant(Level2.sampleData), accounts: .constant(Account.sampleData))
    }
}

