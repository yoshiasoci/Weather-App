//
//  KotaData.swift
//  ApiCuaca
//
//  Created by admin on 1/12/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

struct CityResponse: Decodable {
    
    var cityData:  [CityData]
    
    init(from decoder: Decoder) throws {
        var cityData = [CityData]()
        var container = try decoder.unkeyedContainer()
        while !container.isAtEnd {
            if let route = try? container.decode(CityData.self) {
                cityData.append(route)
            } else {
                _ = try? container.decode(DummyData.self)
            }
        }
        self.cityData = cityData
    }
    
    func searchCity(cityName: String?) -> CityData? {
        cityData.first(where: { $0.kabko == cityName })
    }
    
}

private struct DummyData: Decodable { }

struct CityData: Decodable {
    var kabko: String
    var lat: Double
    var long: Double
}

enum CityError: Error {
    case notFound, unknown
}
