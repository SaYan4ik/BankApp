//
//  BankAPI.swift
//  BankMap
//
//  Created by Александр Янчик on 12.01.23.
//

import Foundation
import Moya

enum BankAPI {
    case getBankInfo(city: String)
    case getFilialInfo(city: String)
}

extension BankAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://belarusbank.by/api")!
    }
    
    var path: String {
        switch self {
            case .getBankInfo:
                return "/atm"
            case .getFilialInfo:
                return "/filials_info"
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .getBankInfo:
                return .get
            case .getFilialInfo:
                return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Moya.Task {
        guard let parameters else { return .requestPlain}
        
        return .requestParameters(parameters: parameters, encoding: encoding)
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var parameters: [String: Any]? {
        var params = [String: Any]()
        
        switch self {
            case .getBankInfo(let city):
                params["city"] = city
            case .getFilialInfo(let city):
                params["city"] = city
        }
        return params
    }
    
    var encoding: ParameterEncoding {
        switch self {
            case .getBankInfo:
                return URLEncoding.queryString
            case .getFilialInfo:
                return URLEncoding.queryString
        }
    }
}
