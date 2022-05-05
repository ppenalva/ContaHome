//
//  GroupEdit.swift
//  ContaHome
//
//  Created by Pablo Penalva on 4/5/22.
//

import SwiftUI

struct GroupDetail: View {
    
    @Binding var accountGroup: AccountGroup
    
    @State private var data = AccountGroup.Data()
    @State private var isPresentingEditView = false
    
    var body: some View {
        Form {
        VStack {
            Text(accountGroup.name)
            ForEach (accountGroup.group) { account in
                Text(account.number)
            }
        }
        
        .navigationTitle(accountGroup.name)
        .toolbar {
            Button("Edit") {
                isPresentingEditView = true
                data = accountGroup.data
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationView {
                GroupEdit(data: $data)
                    .navigationTitle(accountGroup.name)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingEditView = false
                                accountGroup.update(from: data)
                            }
                        }
                    }
            }
        }
        }
        
    }
}



struct GroupDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GroupDetail(accountGroup: .constant(AccountGroup.sampleData[0]))
        }
    }
}
