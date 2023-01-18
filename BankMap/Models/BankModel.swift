//
//  BankModel.swift
//  BankMap
//
//  Created by Александр Янчик on 12.01.23.
//

import Foundation
import ObjectMapper

class BankModel: Mappable {
    var id: Int = 0
    var area: String = ""
    var addressType: String = ""
    var city: String = ""
    var address: String = ""
    var numHouse: String = ""
    var gpsX: String = ""
    var gpsY: String = ""
    var warkTime: String = ""
    var currency: String = ""

    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        id              <- map["id"]
        area            <- map["area"]
        addressType     <- map["city_type"]
        city            <- map["city"]
        address         <- map["address"]
        numHouse        <- map["house"]
        gpsX            <- map["gps_x"]
        gpsY            <- map["gps_y"]
        warkTime        <- map["work_time"]
        currency        <- map["currency"]
    }
}
