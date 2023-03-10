//
//  HistoryRealmModel.swift
//  BankMap
//
//  Created by Александр Янчик on 24.01.23.
//

import Foundation
import RealmSwift

class HistoryRealmModel: Object {
    
    @objc dynamic var date = Date()
    @objc dynamic var statusCode: Int = 0
    @objc dynamic var requestHist = RequestType.getCoordFilials.rawValue
    
//    var requestEnum: RequestType {
//        get {
//            return RequestType(rawValue: request) ?? .getCoordFilials
//        }
//        set {
//            request = newValue.rawValue
//        }
//    }
    
    convenience init(date: Date, statusCode: Int, requestHist: RequestType.RawValue ) {
        self.init()
        self.date = date
        self.statusCode = statusCode
        self.requestHist = requestHist
    }
}
