//
//  GroupRow.swift
//  ContaHome
//
//  Created by Pablo Penalva on 4/5/22.
//

import SwiftUI

struct GroupRow: View {
    var accountGroup: AccountGroup
    
    var body: some View {
        HStack {
            Text(accountGroup.number)
            Spacer()
            Text(accountGroup.name)
        }
    }
}

struct AccountRow_Previews: PreviewProvider {
    static var accountGroups = AccountGroup.sampleData
    
    static var previews: some View {
        Group {
            GroupRow(accountGroup: accountGroups[0])
            GroupRow(accountGroup: accountGroups[1])
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
