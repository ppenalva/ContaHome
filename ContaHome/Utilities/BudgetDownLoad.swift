//
//  BudgetDownLoad.swift
//  ContaHome
//
//  Created by Pablo Penalva on 15/12/22.
//

import SwiftUI

struct BudgetDownLoad: View {
    
    @Binding var budgets: [Budget]
    
    @State var fileData: String = ""
    
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    
    func createFileData() -> String {
        
        for budget in (budgets) {
            
            fileData += BudgetDownLoad.taskDateFormat.string(from: budget.date) + ","
            fileData += budget.description + ","
            fileData += budget.firstAccount + ","
            fileData += budget.secondAccount + ","
            fileData += String(format: "%.2f", budget.debitAmount) + ","
            fileData += String(format: "%.2f", budget.creditAmount) + "\r\n"
        }
        return fileData
    }
    
    var body: some View {
        NavigationView {
            
            VStack {
                
                Button("Execute") {
                    
                    
                    
                        //First make sure you know your file path, you can get it from user input or whatever
                        //Keep the path clean of the name for now
                        var filePath = "/Users/pablo/Library/Containers/com.pablo.penalva.ContaHome/Data/Pruebas/"
                        //then you need to pick your file name
                        let fileName = "AwesomeFile.csv"
                        
                        // Create a FileManager instance this will help you make a new folder if you don't have it already
                        let fileManager = FileManager.default
                    // Fill de fileData with String Data
                    fileData = createFileData()
                    
                        //Create your target directory
                        do {
                            try fileManager.createDirectory(atPath: filePath, withIntermediateDirectories: true, attributes: nil)
                            //Now it's finally time to complete the path
                            filePath += fileName
                        }
                        catch let error as NSError {
                            print("Ooops! Something went wrong: \(error)")
                        }
                        
                        //Then simply write to the file
                        do {
                            // Write contents to file
                            try fileData.write(toFile: filePath, atomically: true, encoding: String.Encoding.utf8)
                            print("Writing CSV to: \(filePath)")
                        }
                        catch let error as NSError {
                            print("Ooops! Something went wrong: \(error)")
                        }
                        
                    }
                }
            }
        }
    }





