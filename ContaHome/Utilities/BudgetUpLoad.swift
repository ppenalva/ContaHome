//
//  BudgetUpLoad.swift
//  ContaHome
//
//  Created by Pablo Penalva on 14/12/22.
//

import SwiftUI

struct BudgetUpLoad: View {
    
    @State var buttonPressed = false
    
    @State private var newBudgetData = Budget.Data()

    
    @Binding var accounts: [Account]
    @Binding var budgets: [Budget]
    
    
    
    func readCSV(inputFile: String, separator: String) -> [String] {
        // Split the file name
        let fileExtension = inputFile.fileExtension()
        let fileName = inputFile.fileName()
        
        // Get the file URL
        let fileURL = try! FileManager.default.url(for: .desktopDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let inputFile = fileURL.appendingPathComponent(fileName).appendingPathExtension(fileExtension)
        
        // Get Data
        do {
            let savedData = try String(contentsOf: inputFile)
            return savedData.components(separatedBy: separator)
        } catch {
            return ["Error file couldn't be found"]
        }
    }
    
    let saveAction: ()->Void
    
    var body: some View {
        NavigationView {
            
            VStack {
                
                Button("Execute") {
                    
                    let myData = readCSV(inputFile: "budget.csv", separator: "\r\n")
                    
                    for item in myData {
                        
                        
                        let columns = item.components(separatedBy: ";")
                        
                        var newBudget = Budget(data: newBudgetData)
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "MM/dd/yy"
                        newBudget.date = dateFormatter.date(from:columns[0]) ?? Date()
                        newBudget.id = UUID()
                        
                        newBudget.description = columns[1]
                        
                        newBudget.firstAccount = columns[2]
                        
                        newBudget.secondAccount = columns[3]
                        
                        newBudget.debitAmount = (Double(columns[4]) ?? 0.0)
                        
                        newBudget.creditAmount = (Double(columns[5]) ?? 0.0)
                        
                        newBudget.cpuDate = Date.now
                
                        budgets.append(newBudget)
                        
                        newBudgetData = Budget.Data()
                        
                        
                    }
                    saveAction()
                }
            }
        }
    }
}


