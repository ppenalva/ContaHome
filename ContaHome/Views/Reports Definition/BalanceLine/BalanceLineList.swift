//
//  BalanceLineList.swift
//  ContaHome
//
//  Created by Pablo Penalva on 6/6/22.
//

import SwiftUI

struct BalanceLineList: View {
    
    @Binding var balanceLines: [BalanceLine]
    @Binding var accounts: [Account]
    
    
    @State private var isPresentingNewBalanceLine = false
    @State private var newBalanceLineData = BalanceLine.Data()
    
    var body: some View {
        NavigationView {
            List {
                ForEach($balanceLines) { $balanceLine in
                    NavigationLink(destination: BalanceLineDetail(balanceLine: $balanceLine, accounts: $accounts)) {
                        BalanceLineRow(balanceLine: balanceLine)
                    }
                }
                .onDelete(perform: deleteBalanceLine)
            }
            .navigationTitle("BALANCE LINES")
            .toolbar {
                Button(action: {
                    isPresentingNewBalanceLine = true
                }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $isPresentingNewBalanceLine) {
                NavigationView {
                    BalanceLineEdit(data: $newBalanceLineData, accounts: $accounts)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Dismiss") {
                                    isPresentingNewBalanceLine = false
                                    newBalanceLineData = BalanceLine.Data()
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Add") {
                                    let newBalanceLine = BalanceLine(data: newBalanceLineData)
                                    balanceLines.append(newBalanceLine)
                                    isPresentingNewBalanceLine = false
                                    newBalanceLineData = BalanceLine.Data()
                                }
                            }
                        }
                }
            }
        }
    }
    func deleteBalanceLine( at offsets: IndexSet) {
        balanceLines.remove(atOffsets:offsets)
    }
}

struct BalanecLineList_Previews: PreviewProvider {
    static var previews: some View {
        BalanceLineList(balanceLines: .constant(BalanceLine.sampleData), accounts: .constant(Account.sampleData))
    }
}

