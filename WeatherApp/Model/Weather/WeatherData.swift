//
//  ResponseWeather.swift
//  ApiCuaca
//
//  Created by admin on 1/10/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    var timezone: String
    var currently: CurrenlyWeatherData
    var hourly: HourlyWeatherData
    var daily: DailyWeatherData
}

enum WeatherError: Error {
    case parameterNotValid, unknown
}

