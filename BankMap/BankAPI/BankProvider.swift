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
                    complition(bank)
                case .failure(let error):
                    print(error.localizedDescription)
                    failure?()
            }
        }
    }
    
    func getFilialInfo(complition: @escaping ([FilialModel]) -> Void, failure: (() -> Void)? = nil) {
        provider.request(.getFilialInfo) { result in
            switch result {
                case .success(let response):
                    guard let filial = try? response.mapArray(FilialModel.self) else { return }
                    complition(filial)
                case .failure(let error):
                    print(error.localizedDescription)
                    failure?()
            }
        }
    }
    
}
