//
//  P&LLineList.swift
//  ContaHome
//
//  Created by Pablo Penalva on 13/6/22.
//

import SwiftUI

struct PAndLLineList: View {
    
    @Binding var pAndLLines: [PAndLLine]
    @Binding var accounts: [Account]
    
    @Environment(\.scenePhase) private var scenePhase
    
    
    @State private var isPresentingNewPAndLLine = false
    @State private var newPAndLLineData = PAndLLine.Data()
    
    var body: some View {
    
            List {
                ForEach($pAndLLines) { $pAndLLine in
                    NavigationLink(destination: PAndLLineDetail(pAndLLine: $pAndLLine, accounts: $accounts)) {
                        PAndLLineRow(pAndLLine: pAndLLine)
                    }
                }
                .onDelete(perform: deletePAndLLine)
                .onMove(perform: movePAndLLine)
            }
            .navigationTitle("Profit and Lose LINES")
            
            .toolbar {
                Button(action: {
                    isPresentingNewPAndLLine = true
                }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $isPresentingNewPAndLLine) {
                NavigationView {
                    PAndLLineEdit(data: $newPAndLLineData, accounts: $accounts)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Dismiss") {
                                    isPresentingNewPAndLLine = false
                                    newPAndLLineData = PAndLLine.Data()
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Add") {
                                    let newPAndLLine = PAndLLine(data: newPAndLLineData)
                                    pAndLLines.append(newPAndLLine)
                                    isPresentingNewPAndLLine = false
                                    newPAndLLineData = PAndLLine.Data()
                                }
                            }
                        }
                }
            }
        }
    
    func deletePAndLLine( at offsets: IndexSet) {
        pAndLLines.remove(atOffsets:offsets)
    }
    func movePAndLLine( from source: IndexSet, to destination: Int) {
    pAndLLines.move(fromOffsets: source, toOffset: destination)
    }
}

struct PAndLLineList_Previews: PreviewProvider {
    static var previews: some View {
        PAndLLineList(pAndLLines: .constant(PAndLLine.sampleData), accounts: .constant(Account.sampleData))
    }
}

