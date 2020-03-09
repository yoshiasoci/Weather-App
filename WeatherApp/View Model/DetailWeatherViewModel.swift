//
//  DetailWeatherViewModel.swift
//  WeatherApp
//
//  Created by admin on 1/29/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol DetailWeatherViewModelable {
    var dailyDetailWeatherData: BehaviorRelay<[DailyDetailWeatherData]> { get }
}

class DetailWeatherViewModel: DetailWeatherViewModelable {
    
    var dailyDetailWeatherData = BehaviorRelay<[DailyDetailWeatherData]>(value: [])
    
}


//// MARK: - DetailWeatherCollectionCell
//protocol DetailWeatherPopulateable {
//    func populateToCollectionViewCell(weatherImageString: String?, date: String?, temperature: Double?, summary: String?)
//}
//
//protocol DetailWeatherCollectionViewModelable {
//    var weatherImageString: BehaviorRelay<UIImage?> { get }
//    var temperatureLabel: BehaviorRelay<String?> { get }
//    var dateLabel: BehaviorRelay<String?> { get }
//    var summaryLabel: BehaviorRelay<String?> { get }
//}
//
//class DetailWeatherCollectionViewModel: DetailWeatherCollectionViewModelable, DetailWeatherPopulateable {
//
//    let weatherImageString = BehaviorRelay<UIImage?>(value: UIImage(named: "indonesia"))
//    let temperatureLabel = BehaviorRelay<String?>(value: "")
//    let dateLabel = BehaviorRelay<String?>(value: "")
//    let summaryLabel = BehaviorRelay<String?>(value: "")
//
//    func populateToCollectionViewCell(weatherImageString: String?, date: String?, temperature: Double?, summary: String?) {
//
//        if let weatherImageString = weatherImageString {
//            self.weatherImageString.accept(UIImage(named: weatherImageString))
//        }
//
//        self.temperatureLabel.accept(temperature == nil ? nil : "\(Int(temperature!))")
//        self.dateLabel.accept(date)
//        self.summaryLabel.accept(summary)
//    }
//
//}
