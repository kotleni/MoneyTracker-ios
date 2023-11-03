//
//  MathExpressionError.swift
//  MoneyTracker
//
//  Created by Viktor Varenik on 27.08.2022.
//

import Foundation

enum MathExpressionError: LocalizedError {
    case invalidExpression
    case invalidOperator(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidExpression:
            return "mathexpressionerror_invalid".localized
        case .invalidOperator(let opera):
            return "mathexpressionerror_invalidoperator".localizedWithPlaceholder(arguments: opera)
        }
    }
}
