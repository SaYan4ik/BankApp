//
//  MetalType.swift
//  BankMap
//
//  Created by Александр Янчик on 19.01.23.
//

import Foundation
import UIKit

enum MetalType: Int, CaseIterable {
    case gold = 0
    case silver = 1
    case platinum = 2
    
    func getName() -> String {
        switch self {
            case .gold:
                return "Gold"
            case .silver:
                return "Silver"
            case .platinum:
                return "Platinum"
        }
    }
}
