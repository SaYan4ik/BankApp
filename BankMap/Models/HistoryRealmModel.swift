//
//  HistoryRealmModel.swift
//  BankMap
//
//  Created by Александр Янчик on 24.01.23.
//

import Foundation
import RealmSwift

class HistoryRealmModel: Object {
    @objc dynamic var date: String = ""
    var request = RequestType.getCoordBanks.rawValue
    var requestEnum: RequestType {
        get {
            return RequestType(rawValue: request) ?? .getCoordBanks
        }
        set {
            request = newValue.rawValue
        }
    }
    
    convenience init(date: String) {
        self.init()
        self.date = date
    }
}
