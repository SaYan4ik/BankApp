//
//  BankProvider.swift
//  BankMap
//
//  Created by Александр Янчик on 12.01.23.
//

import Foundation
import Moya
import Moya_ObjectMapper

final class GetBankInfo {
    private let provider = MoyaProvider<BankAPI>(plugins: [NetworkLoggerPlugin()])
    
    func getInfo(city: String, complition: @escaping ([BankModel]) -> Void, failure: (() -> Void)? = nil) {
        
        provider.request(.getBankInfo(city: city)) { result in
            switch result {
                case .success(let response):
                    guard let bank = try? response.mapArray(BankModel.self) else { return }
                    let respCode = response.response?.statusCode
                    let request = HistoryRealmModel(date: Date.now, statusCode: respCode ?? 0)
                    request.requestEnum = .getCoordAtm
                    RealmManager<HistoryRealmModel>().write(object: request)
                    complition(bank)
                case .failure(let error):
                    print(error.localizedDescription)
                    failure?()
            }
        }
    }
    
    func getFilialInfo(city: String, complition: @escaping ([FilialModel]) -> Void, failure: (() -> Void)? = nil) {
        provider.request(.getFilialInfo(city: city)) { result in
            switch result {
                case .success(let response):
                    guard let filial = try? response.mapArray(FilialModel.self) else { return }
                    let respCode = response.response?.statusCode
                    let request = HistoryRealmModel(date: Date.now, statusCode: respCode ?? 0)
                    request.requestEnum = .getCoordFilials
                    RealmManager<HistoryRealmModel>().write(object: request)
                    complition(filial)
                case .failure(let error):
                    print(error.localizedDescription)
                    failure?()
            }
        }
    }
    
    func getGemsInfo(city: String, complition: @escaping ([GemModel]) -> Void, failure: (() -> Void)? = nil) {
        provider.request(.getGemsInfo(city: city)) { result in
            switch result {
                case .success(let response):
                    guard let gems = try? response.mapArray(GemModel.self) else { return }
                    let respCode = response.response?.statusCode
                    let request = HistoryRealmModel(date: Date.now, statusCode: respCode ?? 0)
                    request.requestEnum = .getInfoGems
                    RealmManager<HistoryRealmModel>().write(object: request)
                    complition(gems)
                case .failure(let error):
                    print(error.localizedDescription)
                    failure?()
            }
        }
    }
    
    func getMetalsInfo(city: String, complition: @escaping ([MetalModel]) -> Void, failure: (() -> Void)? = nil) {
        provider.request(.getMetalsInfo(city: city)) { result in
            switch result {
                case .success(let response):
                    guard let metals = try? response.mapArray(MetalModel.self) else { return }
                    let respCode = response.response?.statusCode
                    let request = HistoryRealmModel(date: Date.now, statusCode: respCode ?? 0)
                    request.requestEnum = .getInfoMetals
                    RealmManager<HistoryRealmModel>().write(object: request)
                    complition(metals)
                case .failure(let error):
                    print(error.localizedDescription)
                    failure?()
            }
        }
    }
    
    func getNewsForBank(complition: @escaping ([NewsModel]) -> Void, failure: (() -> Void)? = nil) {
        provider.request(.getBankNews) { result in
            switch result {
                case .success(let response):
                    guard let news = try? response.mapArray(NewsModel.self) else { return }
                    let respCode = response.response?.statusCode
                    let request = HistoryRealmModel(date: Date.now, statusCode: respCode ?? 0)
                    request.requestEnum = .getNews
                    RealmManager<HistoryRealmModel>().write(object: request)
                    complition(news)
                case .failure(let error):
                    print(error.localizedDescription)
                    failure?()
            }
        }
    }
    
    
}
