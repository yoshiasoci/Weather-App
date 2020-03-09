//
//  City.swift
//  WeatherApp
//
//  Created by admin on 2/5/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

protocol CityRequestDataable {
    
    func requestCityData(cityName: String?, onComplete: @escaping (Result<CityData?, CityError>) -> Void )
    
}

//jika suatu saat ada fitur city request from api protocol CityServiceabla masih bisa menanganinya

class CityRequestDataFromJSON: CityRequestDataable {
    
    //private var cityRequestJSON = CityRequestDataAccess(jsonRequestService: JSONRequestDataAccess())
    let cityRequestListDataResponse: CityRequestListDataResponseable
    
    init(cityRequestListDataResponse: CityRequestListDataResponseable) {
        self.cityRequestListDataResponse = cityRequestListDataResponse
    }
    
    // MARK: - Protocol conformance
    
    func requestCityData(cityName: String?, onComplete: @escaping (Result<CityData?, CityError>) -> Void) {
        guard let cityName = cityName else { return }
        cityRequestListDataResponse.getCityListData { result in
            switch result {
            case .failure(let error):
                let error = error as? CityError
                onComplete(.failure(error ?? .unknown))
            case .success(let cityData):
                guard let cityData = cityData?.searchCity(cityName: cityName) else {
                    onComplete(.failure(.notFound))
                    return
                }
                onComplete(.success(cityData))
            }
        }
    }
    
}
