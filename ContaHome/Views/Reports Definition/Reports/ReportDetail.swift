//
//  ReportDetail.swift
//  ContaHome
//
//  Created by Pablo Penalva on 19/5/22.
//

import SwiftUI

struct ReportDetail: View {
    
    @Binding var report: Report
    @Binding var level1s: [Level1]
    
    @State private var data = Report.Data()
    @State private var isPresentingEditView = false
    
    var body: some View {
        Form {
        VStack {
            
            ForEach (report.level1) { account in
                Text(account.number)
            }
        }
        
        .navigationTitle(report.name)
        .toolbar {
            Button("Edit") {
                isPresentingEditView = true
                data = report.data
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationView {
                ReportEdit(data: $data, level1s: $level1s)
                    .navigationTitle(report.name)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingEditView = false
                                report.update(from: data)
                            }
                        }
                    }
            }
        }
        }
        
    }
}



struct ReportDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ReportDetail(report: .constant(Report.sampleData[0]), level1s: .constant(Level1.sampleData))
        }
    }
}
