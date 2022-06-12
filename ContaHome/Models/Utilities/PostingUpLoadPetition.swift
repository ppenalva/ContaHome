//
//  PostingUpLoadPetition.swift
//  ContaHome
//
//  Created by Pablo Penalva on 8/6/22.
//

import SwiftUI

struct PostingUpLoadPetition: View {
    
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
                    
                    let myData = readCSV(inputFile: "pp02.csv", separator: "\r\n")
                    
                    for item in myData {
                        
                        let columns = item.components(separatedBy: ";")
                        
                        var newPosting = Posting(data: newPostingData)
                        newPosting.firstAccount = columns[0]
                        newPosting.secondAccount = columns[1]
                        newPosting.debitAmount = (columns[2] as NSString).doubleValue
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "YYYY/MM/dd"
                        newPosting.date = dateFormatter.date(from:columns[3]) ?? Date()
                        newPosting.description = columns[4]
                        
                        postings.append(newPosting)
                        
                        newPostingData = Posting.Data()
                        
                        
                    }
                    saveAction()
                }
            }
        }
    }
}



