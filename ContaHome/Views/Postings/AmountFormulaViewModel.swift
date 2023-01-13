//
//  AmountFormulaViewModel.swift
//  ContaHome
//
//  Created by Pablo Penalva on 14/12/22.
//

import SwiftUI

class AmountFormulaViewModel: ObservableObject {
    
    @Published var expresionDebitAmount: String = ""
   @Published var expresionCreditAmount: String = ""
    
    
    func evaluateDebitFormula() -> Double {
        let mathExpression =  NSExpression(format:String(expresionDebitAmount).replacingOccurrences(of: ",", with: "."))
    let result = mathExpression.expressionValue(with: nil, context: nil) as! Double
        return result
    }
    
    func evaluateCreditFormula() -> Double {
        let mathExpression =  NSExpression(format:String(expresionCreditAmount).replacingOccurrences(of: ",", with: "."))
    let result = mathExpression.expressionValue(with: nil, context: nil) as! Double
        return result
    }
    
}
