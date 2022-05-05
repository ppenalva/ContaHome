//
//  GroupList.swift
//  ContaHome
//
//  Created by Pablo Penalva on 4/5/22.
//

import SwiftUI

struct GroupList: View {
    
    @Binding var accountGroups: [AccountGroup]
    @State private var isPresentingNewAccountGroup = false
    @State private var newAccountGroupData = AccountGroup.Data()
    
    var body: some View {
        NavigationView {
            List {
                ForEach($accountGroups) { $accountGroup in
                    NavigationLink(destination: GroupDetail(accountGroup: $accountGroup)) {
                        GroupRow(accountGroup: accountGroup)
                    }
                }
            }
            .navigationTitle("GROUPS")
            .toolbar {
                Button(action: {
                    isPresentingNewAccountGroup = true
                }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $isPresentingNewAccountGroup) {
                NavigationView {
                    GroupEdit(data: $newAccountGroupData)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Dismiss") {
                                    isPresentingNewAccountGroup = false
                                    newAccountGroupData = AccountGroup.Data()
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Add") {
                                    let newAccountGroup = AccountGroup(data: newAccountGroupData)
                                    accountGroups.append(newAccountGroup)
                                    isPresentingNewAccountGroup = false
                                    newAccountGroupData = AccountGroup.Data()
                                }
                            }
                        }
                }
            }
        }
    }
}

struct GroupList_Previews: PreviewProvider {
    static var previews: some View {
        GroupList(accountGroups: .constant(AccountGroup.sampleData))
    }
}
