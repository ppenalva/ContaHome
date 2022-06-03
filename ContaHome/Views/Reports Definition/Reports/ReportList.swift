//
//  ReportList.swift
//  ContaHome
//
//  Created by Pablo Penalva on 19/5/22.
//

import SwiftUI

struct ReportList: View {
    
    @Binding var reports: [Report]
    @Binding var level1s: [Level1]
    
    
    @State private var isPresentingNewReport = false
    @State private var newReportData = Report.Data()
    
    var body: some View {
        NavigationView {
            List {
                ForEach($reports) { $report in
                    NavigationLink(destination: ReportDetail(report: $report, level1s: $level1s)) {
                        ReportRow(report: report)
                    }
                }
                .onDelete(perform: deleteReport)
            }
            .navigationTitle("REPORTS")
            .toolbar {
                Button(action: {
                    isPresentingNewReport = true
                }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $isPresentingNewReport) {
                NavigationView {
                    ReportEdit(data: $newReportData, level1s: $level1s)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Dismiss") {
                                    isPresentingNewReport = false
                                    newReportData = Report.Data()
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Add") {
                                    let newReport = Report(data: newReportData)
                                    reports.append(newReport)
                                    isPresentingNewReport = false
                                    newReportData = Report.Data()
                                }
                            }
                        }
                }
            }
        }
    }
    func deleteReport( at offsets: IndexSet) {
        reports.remove(atOffsets:offsets)
    }
}

struct ReportList_Previews: PreviewProvider {
    static var previews: some View {
        ReportList(reports: .constant(Report.sampleData), level1s: .constant(Level1.sampleData))
    }
}

