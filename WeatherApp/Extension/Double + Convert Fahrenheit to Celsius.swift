//
//  Double + Convert Fahrenheit to Celsius.swift
//  WeatherApp
//
//  Created by admin on 2/17/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

extension Double {
    init(convertToCelsius: Double) {
        let convertCelcius: Double = (convertToCelsius - 32) * 5/9
        self = convertCelcius
    }
}
