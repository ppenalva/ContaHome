//
//  GroupEdit.swift
//  ContaHome
//
//  Created by Pablo Penalva on 5/5/22.
//

import SwiftUI

struct GroupEdit: View {
    
    @Binding var data: AccountGroup.Data
    @State private var newAccountNumber = ""
    
    
    
    var body: some View {
        Form {
            NavigationView {
        VStack {
            TextField("Number", text: $data.number)
            TextField("Name", text: $data.name)
            ForEach (data.group) { account in
                Text(account.number)
            }
            .onDelete { indices in
                data.group.remove(atOffsets: indices)
            }
            HStack {
                TextField( "new account", text: $newAccountNumber)
                Button(action: {
                    withAnimation {
                        let group = AccountGroup.AccountInGroup(number:newAccountNumber)
                        data.group.append(group)
                        newAccountNumber = ""
                    }
                }) {
                    Image(systemName: "plus.circle.fill")
                        
                    }
                .disabled(newAccountNumber.isEmpty)
                }
            }
        }

    }
    }
}

struct GroupEdit_Previews: PreviewProvider {
    static var previews: some View {
        GroupEdit(data: .constant(AccountGroup.sampleData[0].data))
    }
}
