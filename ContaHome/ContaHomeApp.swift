//
//  ContaHomeApp.swift
//  ContaHome
//
//  Created by Pablo Penalva on 27/4/22.
//

import SwiftUI

@main

struct ContaHomeApp: App {
    @State private var accountGroups = AccountGroup.sampleData
    
    
    @State var menuChoice = "0"
    var body: some Scene {
        WindowGroup {
            if menuChoice == "0" {
                ContentView()
            } else {
                GroupList(accountGroups: $accountGroups)
            }
        }
        .commands {
            CommandMenu("Custom Menu") {
                
                Button(action: {
        menuChoice = "0"
                }, label: {
                        Text("Posting")
                })
                
                Button(action: {
        menuChoice = "1"
                }, label: {
                        Text("Reports")
            })
            }
        }
    }
}
