//
//  GemModel.swift
//  BankMap
//
//  Created by Александр Янчик on 19.01.23.
//

import Foundation
import ObjectMapper

class GemModel: Mappable {
    var attestat: String = ""
    var name: String = ""
    var grani: String = ""
    var weight: String = ""
    var color: String = ""
    var cost: String = ""
    var city: String = ""
    var cityType: String = ""
    var filialName: String = ""

    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        attestat    <- map["attestat"]
        name        <- map["name_ru"]
        grani       <- map["grani"]
        weight      <- map["weight"]
        color       <- map["color"]
        cost        <- map["cost"]
        city        <- map["name"]
        cityType    <- map["name_type"]
        filialName  <- map["filials_text"]
    }
}
