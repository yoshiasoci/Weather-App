//
//  Weather.swift
//  WeatherApp
//
//  Created by admin on 2/5/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import Moya

protocol WeatherServiceable {
    
    func requestWeatherData(lat: Double?, long: Double?, onComplete: @escaping (Result<WeatherData?, WeatherError>) -> Void)
    //func requestDetailDailyWeatherData(lat: Double!, long: Double!, onComplete: @escaping (Result<[DailyDetailWeatherData]?, WeatherError>) -> Void)
    
}

//jika suatu saat terjadi weather request by json protocol Weatherserviceable masih bisa menghandlenya

class WeatherServiceAPI: WeatherServiceable {
    
    private let weatherProvider = MoyaProvider<WeatherServiceMoya>()
    
    // MARK: - Protocol conformance
    
    func requestWeatherData(lat: Double?, long: Double?, onComplete: @escaping (Result<WeatherData?, WeatherError>) -> Void) {
        guard let lat = lat, let long = long else {
            onComplete(.failure(.parameterNotValid))
            return
        }
        self.weatherProvider.request(.searchWeatherMoya(latitude: lat, longitude: long)) { (result) in
            switch result {
                case .failure(_):
                    onComplete(.failure(.unknown))
                case .success(let response):
                    let weatherData = try? JSONDecoder().decode(WeatherData.self, from: response.data)
//                    let weathers = weatherData
//
//                    var dailyData = weathers?.daily.data ?? []
//                    dailyData.removeFirst(2)
                    //self.dailyDetailWeatherData.accept(dailyData)
                    onComplete(.success(weatherData))
            }
        }
    }
    
    
//    func requestDetailDailyWeatherData(lat: Double!, long: Double!, onComplete: @escaping (Result<[DailyDetailWeatherData]?, WeatherError>) -> Void) {
//        guard let lat = lat, let long = long else {
//            onComplete(.failure(.parameterNotValid))
//            return
//        }
//        self.weatherProvider.request(.searchWeatherMoya(latitude: lat, longitude: long)) { (result) in
//            switch result {
//                case .failure(_):
//                    onComplete(.failure(.unknown))
//                case .success(let response):
//                    let weatherData = try? JSONDecoder().decode(WeatherData.self, from: response.data)
//                    onComplete(.success(weatherData?.daily.data))
//            }
//        }
//    }
    
    
}
