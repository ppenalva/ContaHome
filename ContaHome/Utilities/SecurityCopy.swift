//
//  SecurityCopy.swift
//  ContaHome
//
//  Created by Pablo Penalva on 20/6/22.
//

import SwiftUI

struct SecurityCopy: View {
    
    @State private var a = ""
    @State private var b = ""
    @State private var c = ""
    @State private var d = ""
    @State private var e = ""
    
    var body: some View {
        
        NavigationView {
            
    
            
            VStack {
                
                Button("Execute") {
                    
                     a = (copyFile(at: "/Users/pablo/Library/Containers/com.pablo.penalva.ContaHome/Data/Documents/accounts.data", to: "/Users/pablo/Library/Containers/com.pablo.penalva.ContaHome/Data/Documents/accountsCopy.data"))
                     b = (copyFile(at: "/Users/pablo/Library/Containers/com.pablo.penalva.ContaHome/Data/Documents/balanceLines.data", to: "/Users/pablo/Library/Containers/com.pablo.penalva.ContaHome/Data/Documents/balanceLinesCopy.data"))
                     c = (copyFile(at: "/Users/pablo/Library/Containers/com.pablo.penalva.ContaHome/Data/Documents/postings.data", to: "//Users/pablo/Library/Containers/com.pablo.penalva.ContaHome/Data/Documents/postingsCopy.data"))
                     d = (copyFile(at: "/Users/pablo/Library/Containers/com.pablo.penalva.ContaHome/Data/Documents/pAndLLines.data", to: "/Users/pablo/Library/Containers/com.pablo.penalva.ContaHome/Data/Documents/pAndLLinesCopy.data"))
                    e = (copyFile(at: "/Users/pablo/Library/Containers/com.pablo.penalva.ContaHome/Data/Documents/budgets.data", to: "/Users/pablo/Library/Containers/com.pablo.penalva.ContaHome/Data/Documents/budgetsCopy.data"))
                    
                }
                Text(a)
                Text(b)
                Text(c)
                Text(d)
                Text(e)
            }
        }
    }
    func copyFile(at src: String, to dest: String) -> String {
        
        
        
        // get the instance of the file manager
        let fm = FileManager()
        
        do {
            // remove the file from destination if it exists there
            if dest.fileExists {
                try fm.removeItem(atPath: dest)
            }
            
            // this method finally copies it to the destiantion
            try fm.copyItem(atPath: src, toPath: dest)
            
        } catch {
            return "Copy file failed."
        }
        
        return "Copy file success!"
    }
}
