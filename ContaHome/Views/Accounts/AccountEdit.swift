//
//  AccountEdit.swift
//  ContaHome
//
//  Created by Pablo Penalva on 5/5/22.
//
import SwiftUI

struct AccountEdit: View {
    


@Binding var data: Account.Data
@State private var newAccountNumber = ""



var body: some View {
    Form {
    
    VStack {
        TextField("Number", text: $data.number)
        TextField("Name", text: $data.name)
       
        
    }

}
}
}

struct AccountEdit_Previews: PreviewProvider {
static var previews: some View {
    AccountEdit(data: .constant(Account.sampleData[0].data))
}
}
