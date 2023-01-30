//
//  RequestType.swift
//  BankMap
//
//  Created by Александр Янчик on 24.01.23.
//

import Foundation

enum RequestType: String, CaseIterable {
    case getCoordFilials = "Get cooardinate about filials"
    case getCoordAtm = "Get cooardinate about atm"
    case getInfoGems = "Get info about gems"
    case getInfoMetals = "Get info about mettals"
    case getNews = "Get news"
}
