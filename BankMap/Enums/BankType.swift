//
//  BankType.swift
//  BankMap
//
//  Created by Александр Янчик on 18.01.23.
//

import Foundation
import UIKit

enum BankType:String, CaseIterable {
    case bank = "Bank"
    case atm = "ATM"
    case all = "All"
    
    private var color: UIColor {
        switch self {
            case .bank: return .green
            case .atm: return .green
            case .all: return .green
        }
    }
    
    var tintColor: UIColor {
        return color.withAlphaComponent(0.5)
    }

    var borderColor: UIColor {
        return color.withAlphaComponent(0.9)
    }
}
