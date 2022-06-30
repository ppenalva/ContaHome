//
//  PostingNewRow.swift
//  ContaHome
//
//  Created by Pablo Penalva on 10/6/22.
//

import Foundation
import SwiftUI

struct PostingNewRow: View {
    
    @State private var popupTagsPresented = false
    @State var predictableValues: [String] = []
    @State var myPredictedValues: [Posting] = []
    @State var textFieldInput: String = ""
    
    
    @Binding var data: Posting.Data
    @Binding var accounts: [Account]
    @Binding var postings: [Posting]
    @Binding var account: Account
    
    
    
    var body: some View {
        
        VStack {
            HStack {
                
                DatePicker ("Date", selection: $data.date, in:...Date(), displayedComponents: .date)
                
                //            TextField ("Description", text: $data.description)
                PredictingTextField(postings: self.$postings, predictedValues: self.$myPredictedValues, textFieldInput: self.$data.description, account: self.$account)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onChange(of: data.description, perform: { newTag in
                        popupTagsPresented = true
                    })
                    .popover(isPresented: $popupTagsPresented, arrowEdge: .top) {
                        VStack {
                            ForEach(myPredictedValues, id: \.self){ suggestion in
                                Button{
                                    textFieldInput = suggestion.description
                                    data.description = suggestion.description
                                    data.debitAmount = suggestion.debitAmount
                                    data.creditAmount = suggestion.creditAmount
                                    data.secondAccount = suggestion.secondAccount
                                    
                                    // process text
                                }label: {
                                    Label(suggestion.description, systemImage: "someIcon")
                                }
                                .buttonStyle(.borderless)
                            }
                            
                        }
                    }
                    .frame(minWidth: 400, idealWidth: 600, maxWidth: 800, minHeight: 20, idealHeight: 20, maxHeight: 20)
                
                Spacer()
                TextField("Debit Amount", value: $data.debitAmount, format: .number)
                    .frame(minWidth: 100, idealWidth: 200, maxWidth: 300, minHeight: 20, idealHeight: 20, maxHeight: 20)
                TextField("Credit Amount", value: $data.creditAmount, format: .number)
                    .frame(minWidth: 100, idealWidth: 200, maxWidth: 300, minHeight: 20, idealHeight: 20, maxHeight: 20)
            }
            .frame(width: 1000, height: 40)
            
            HStack {
                Picker("Account", selection: $data.secondAccount) {
                    ForEach(accounts, id: \.self) {account in
                        Text(account.name) .tag(account.name )
                            .frame(minWidth: 400, idealWidth: 600, maxWidth: 800, minHeight: 20, idealHeight: 20, maxHeight: 20)
                    }
                }
                Spacer()
            }
            .frame(width: 1000, height: 40)
        }
    }
}

/// TextField capable of making predictions based on provided predictable values
struct PredictingTextField: View {
    
    /// All possible predictable values. Can be only one.
    @Binding var postings: Array<Posting>
    
    /// This returns the values that are being predicted based on the predictable values
    @Binding var predictedValues: Array<Posting>
    
    /// Current input of the user in the TextField. This is Binded as perhaps there is the urge to alter this during live time. E.g. when a predicted value was selected and the input should be cleared
    @Binding var textFieldInput: String
    
    @Binding var account: Account
    
    /// The time interval between predictions based on current input. Default is 0.1 second. I would not recommend setting this to low as it can be CPU heavy.
    @State var predictionInterval: Double?
    
    /// Placeholder in empty TextField
    var textFieldTitle: String?
    
    @State private var isBeingEdited: Bool = false
    
    init(postings: Binding<Array<Posting>>, predictedValues: Binding<Array<Posting>>, textFieldInput: Binding<String>, account: Binding<Account>,textFieldTitle: String? = "", predictionInterval: Double? = 0.1){
        
        self._postings = postings
        self._predictedValues = predictedValues
        self._textFieldInput = textFieldInput
        self._account = account
        
        self.textFieldTitle = textFieldTitle
        self.predictionInterval = predictionInterval
    }
    
    var body: some View {
        TextField(self.textFieldTitle ?? "", text: self.$textFieldInput, onEditingChanged: { editing in self.realTimePrediction(status: editing)}, onCommit: { self.makePrediction()})
    }
    
    /// Schedules prediction based on interval and only a if input is being made
    private func realTimePrediction(status: Bool) {
        self.isBeingEdited = status
        if status == true {
            Timer.scheduledTimer(withTimeInterval: self.predictionInterval ?? 1, repeats: true) { timer in
                self.makePrediction()
                
                if self.isBeingEdited == false {
                    timer.invalidate()
                }
            }
        }
    }
    
    /// Capitalizes the first letter of a String
    private func capitalizeFirstLetter(smallString: String) -> String {
        return smallString.prefix(1).capitalized + smallString.dropFirst()
    }
    
    /// Makes prediciton based on current input
    private func makePrediction() {
        self.predictedValues = []
        let sortedPostings = postings
            .filter { $0.firstAccount == account.name }
            .sorted {$0.cpuDate > $1.cpuDate}
        if !self.textFieldInput.isEmpty{
            for value in sortedPostings {
                if self.textFieldInput.split(separator: " ").count > 1 {
                    //                self.makeMultiPrediction(value: value.description)
                }else {
                    if (value.description).contains(self.textFieldInput) || (value.description).contains(self.capitalizeFirstLetter(smallString: self.textFieldInput)){
                        if !self.predictedValues.description.contains(String(value.description)) {
                            self.predictedValues.append(value)
                        }
                    }
                }
            }
        }
    }
    /// Makes predictions if the input String is splittable
    //    private func makeMultiPrediction(value: String) {
    //        for subString in self.textFieldInput.split(separator: " ") {
    //            if value.contains(String(subString)) || value.contains(self.capitalizeFirstLetter(smallString: String(subString))){
    //                if !self.predictedValues.description.contains(value) {
    //                    self.predictedValues.append(value)
    //                }
    //            }
    //        }
    //    }
}

struct PostingNewRow_Previews: PreviewProvider {
    static var postings = Posting.sampleData
    
    static var previews: some View {
        PostingCreditRow(posting: postings[0])
    }
}
