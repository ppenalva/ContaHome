//
//  BudgetPetition.swift
//  ContaHome
//
//  Created by Pablo Penalva on 14/12/22.
//

import SwiftUI

struct BudgetsPeticion: View {

@State private var dateFrom = defaultDateFrom
@State private var dateTo = defaultDateTo


@State private var accountDebit = ""
@State private var accountCredit = ""

@State private var description = ""

@State private var amountFrom = -999999999.99
@State private var amountTo = 99999999.99

@State private var buttonPressed = false


@Binding var accounts: [Account]
@Binding var budgets: [Budget]

static var defaultDateFrom: Date {
    let components = Calendar.current.dateComponents([.year], from: Date.now)
    return  Calendar.current.date(from: components) ?? Date.now
}

static var defaultDateTo: Date {
    var components = Calendar.current.dateComponents([.year, .month], from: Date.now)
    components.hour = (components.hour ?? 0) - 1
    return  Calendar.current.date(from: components) ?? Date.now
}


var body: some View {
    NavigationView {
        
        VStack {
            
            DatePicker ("Date From", selection: $dateFrom, in:...Date(), displayedComponents: .date)
            
            DatePicker ("Date To", selection: $dateTo, in:...Date(), displayedComponents: .date)
            
            HStack {
                Picker("Account Debit", selection: $accountDebit) {
                    ForEach(accounts, id: \.self) {account in
                        Text(account.name) .tag(account.name )
                            .frame(minWidth: 400, idealWidth: 600, maxWidth: 800, minHeight: 20, idealHeight: 20, maxHeight: 20)
                    }
                }
            }
            
            HStack {
                Picker("Account Credit", selection: $accountCredit) {
                    ForEach(accounts, id: \.self) {account in
                        Text(account.name) .tag(account.name )
                            .frame(minWidth: 400, idealWidth: 600, maxWidth: 800, minHeight: 20, idealHeight: 20, maxHeight: 20)
                    }
                }
            }
            HStack {
                Text("Description: ")
                TextField("Description", text: $description)
            }
            HStack {
                Text("Amount from: ")
                TextField("Amount from", value: $amountFrom, format: .number)
                    .frame(minWidth: 100, idealWidth: 150, maxWidth: 200, minHeight: 20, idealHeight: 20, maxHeight: 20)
            }
            HStack {
                Text("Amount to: ")
                TextField("Amount To", value: $amountTo, format: .number)
                    .frame(minWidth: 100, idealWidth: 150, maxWidth: 200, minHeight: 20, idealHeight: 20, maxHeight: 20)
            }
            
            Button("Execute") { buttonPressed = true }
            
                NavigationLink("", destination:
                                BudgetListExecution (accounts: $accounts, budgets: $budgets, dateFrom: $dateFrom, dateTo: $dateTo, accountDebit: $accountDebit, accountCredit: $accountCredit, description: $description, amountFrom: $amountFrom, amountTo: $amountTo),
                               isActive: $buttonPressed)
            
        }
    }
}
}

