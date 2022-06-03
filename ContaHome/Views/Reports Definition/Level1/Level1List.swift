//
//  Level1List.swift
//  ContaHome
//
//  Created by Pablo Penalva on 23/5/22.
//
import SwiftUI

struct Level1List: View {
    
    @Binding var level1s: [Level1]
    @Binding var level2s: [Level2]
    
    @State private var isPresentingNewLevel1 = false
    @State private var newLevel1Data = Level1.Data()
    
    var body: some View {
        NavigationView {
            List {
                ForEach($level1s) { $level1 in
                    NavigationLink(destination: Level1Detail(level1: $level1, level2s: $level2s)) {
                        Level1Row(level1: level1)
                    }
                }
                .onDelete(perform: deleteLevel1)
            }
            .navigationTitle("LEVEL1s")
            .toolbar {
                Button(action: {
                    isPresentingNewLevel1 = true
                }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $isPresentingNewLevel1) {
                NavigationView {
                    Level1Edit(data: $newLevel1Data, level2s: $level2s)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Dismiss") {
                                    isPresentingNewLevel1 = false
                                    newLevel1Data = Level1.Data()
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Add") {
                                    let newLevel1 = Level1(data: newLevel1Data)
                                    level1s.append(newLevel1)
                                    isPresentingNewLevel1 = false
                                    newLevel1Data = Level1.Data()
                                }
                            }
                        }
                }
            }
        }
    }
    func deleteLevel1( at offsets: IndexSet) {
        level1s.remove(atOffsets:offsets)
    }
}

struct Level1List_Previews: PreviewProvider {
    static var previews: some View {
        Level1List(level1s: .constant(Level1.sampleData),level2s: .constant(Level2.sampleData))
    }
}

