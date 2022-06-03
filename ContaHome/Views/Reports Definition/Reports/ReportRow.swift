//
//  ReportsRow.swift
//  ContaHome
//
//  Created by Pablo Penalva on 19/5/22.
//

import SwiftUI

struct ReportRow: View {
    var report: Report
    
    var body: some View {
        HStack {
        
            Text(report.name)
        }
    }
}

struct ReportRow_Previews: PreviewProvider {
    static var reports = Report.sampleData
    
    static var previews: some View {
        Group {
            ReportRow(report: reports[0])
            ReportRow(report: reports[1])
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
