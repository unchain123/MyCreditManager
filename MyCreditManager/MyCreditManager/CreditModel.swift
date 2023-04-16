//
//  CreditModel.swift
//  MyCreditManager
//
//  Created by unchain on 2023/04/16.
//

import Foundation

enum GradeTable: String {
    case aPlus = "A+"
    case a = "A"
    case bPlus = "B+"
    case b = "B"
    case cPlus = "C+"
    case c = "C"
    case dPlus = "D+"
    case d = "D"
    case f = "F"

    var point: Double {
        switch self {
        case .aPlus:
            return 4.5
        case .a:
            return 4
        case .bPlus:
            return 3.5
        case .b:
            return 3
        case .cPlus:
            return 2.5
        case .c:
            return 2
        case .dPlus:
            return 1.5
        case .d:
            return 1
        case .f:
            return 0
        }
    }
}
