//
//  DailyWeatherData.swift
//  WeatherApp
//
//  Created by admin on 1/17/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

struct DailyWeatherData: Decodable {
    var data: [DailyDetailWeatherData]
}

struct DailyDetailWeatherData: Decodable {
    var time: Double
    var summary: String
    var icon: String
    var temperatureHigh: Double
    
//    var celcius: Double {
//        let temperatureFahrenheit: Double = temperatureHigh
//        let convertCelcius: Double = (temperatureFahrenheit - 32) * 5/9
//        return convertCelcius
//    }
}
