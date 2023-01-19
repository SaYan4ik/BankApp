//
//  MetalModel.swift
//  BankMap
//
//  Created by Александр Янчик on 19.01.23.
//

import Foundation
import ObjectMapper

class MetalModel: Mappable {
    var goldTen: String = ""
    var goldTwenty: String = ""
    var goldFifty: String = ""
    var silverTen: String = ""
    var silverTwenty: String = ""
    var silverFifty: String = ""
    var platinumTen: String = ""
    var platinumTwenty: String = ""
    var platinumFifty: String = ""
    var city: String = ""
    var cityType: String = ""
    var filialName: String = ""
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        goldTen           <- map["ZOL_10_out"]
        goldTwenty        <- map["ZOL_20_out"]
        goldFifty         <- map["ZOL_50_out"]
        silverTen         <- map["SIL_10_out"]
        silverTwenty      <- map["SIL_20_out"]
        silverFifty       <- map["SIL_50_out"]
        platinumTen       <- map["PL_10_out"]
        platinumTwenty    <- map["PL_20_out"]
        platinumFifty     <- map["PL_30_out"]
        city              <- map["name"]
        cityType          <- map["name_type"]
        filialName        <- map["filials_text"]
        
    }
}
