//
//  CurrenlyWeatherData.swift
//  ApiCuaca
//
//  Created by admin on 1/11/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

struct CurrenlyWeatherData: Decodable {
    var summary: String
    var temperature: Double
    var icon: String
    
//    var celcius: Double {
//        let temperatureFahrenheit: Double = temperature
//        let convertCelcius: Double = (temperatureFahrenheit - 32) * 5/9
//        return convertCelcius
//    }
}
