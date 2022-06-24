//
//  PostingUpLoadPetition.swift
//  ContaHome
//
//  Created by Pablo Penalva on 8/6/22.
//

import SwiftUI

struct PostingUpLoad: View {
    
    @State var buttonPressed = false
    
    @State private var newPostingData = Posting.Data()

    
    @Binding var accounts: [Account]
    @Binding var postings: [Posting]
    
    
    
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
                    
                    let myData = readCSV(inputFile: "pp04.csv", separator: "\r\n")
                    
                    for item in myData {
                        
                        
                        let columns = item.components(separatedBy: ";")
                        
                        var newPosting = Posting(data: newPostingData)
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "MM/dd/yy"
                        newPosting.date = dateFormatter.date(from:columns[0]) ?? Date()
                        
                        newPosting.firstAccount = columns[1]
                        
                        newPosting.description = columns[2]
                        
                        newPosting.secondAccount = columns[3]
                        
                        let valor = (Double(columns[4]) ?? 0.0)
                        
                        if (valor > 0.0) {
                            newPosting.debitAmount = valor
                            newPosting.creditAmount = 0.0
                        } else {
                            newPosting.creditAmount = (valor  * -1)
                            newPosting.debitAmount = 0.0
                        }
                            
                        
                
                
                        postings.append(newPosting)
                        
                        newPostingData = Posting.Data()
                        
                        
                    }
                    saveAction()
                }
            }
        }
    }
}



