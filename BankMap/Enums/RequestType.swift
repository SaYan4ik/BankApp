//
//  RequestType.swift
//  BankMap
//
//  Created by Александр Янчик on 24.01.23.
//

import Foundation

enum RequestType: String, CaseIterable {
    case getCoordBanks = "Get cooardinate about banks and atm"
    case getInfoGems = "Get info about gems"
    case getInfoMetalls = "Get info about mettals"
    case getNews = "Get news"
}
