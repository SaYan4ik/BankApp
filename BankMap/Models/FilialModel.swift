//
//  FilialModel.swift
//  BankMap
//
//  Created by Александр Янчик on 17.01.23.
//

import Foundation
import ObjectMapper

class FilialModel: Mappable {
    var id: Int?
    var filialName: String?
    var nameType: String?
    var name: String?
    var streetType: String?
    var street: String?
    var numHouse: String?
    var gpsX: String?
    var gpsY: String?
    var warkTime: String?
    var currency: String?

    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        id              <- map["sap_id"]
        filialName      <- map["filial_name"]
        nameType        <- map["name_type"]
        name            <- map["name"]
        streetType      <- map["street_type"]
        street          <- map["street"]
        numHouse        <- map["home_number"]
        gpsX            <- map["GPS_X"]
        gpsY            <- map["GPS_Y"]
    }
}
