//
//  NewsModel.swift
//  BankMap
//
//  Created by Александр Янчик on 24.01.23.
//

import Foundation
import ObjectMapper

class NewsModel: Mappable {
    var nameRu: String = ""
    var htmlRu: String = ""
    var startDate: String = ""
    var link: String = ""
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        nameRu              <- map["name_ru"]
        htmlRu              <- map["html_ru"]
        startDate           <- map["start_date"]
        link                <- map["start_date"]
    }
}
