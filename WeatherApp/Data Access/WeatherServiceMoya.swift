//
//  WeatherServiceMoya.swift
//  WeatherApp
//
//  Created by admin on 1/22/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import Moya


enum WeatherServiceMoya {
    case searchWeatherMoya(latitude: Double, longitude: Double)
}

extension WeatherServiceMoya: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.darksky.net/forecast/ac96287661f1aa411bb843d352b7a9a6/")!
    }
    
    var path: String {
        switch self {
            
        case .searchWeatherMoya(let latitude, let longitude):
            return "\(latitude),\(longitude)"

        }
    }
    
    var method: Moya.Method {
        switch self {
        
        case .searchWeatherMoya(_, _):
            return .get
        
        }
    }
    
    var sampleData: Data {
        switch self {
            
        case .searchWeatherMoya(let latitude, let longitude):
            return "\(latitude),\(longitude)".data(using: .utf8)!

        }
    }
    
    var task: Task {
        switch self {

        case .searchWeatherMoya:
            return .requestPlain
        }
        
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
}
