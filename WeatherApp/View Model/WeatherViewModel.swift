//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by admin on 1/23/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Moya

protocol WeatherPopulateable {
    func populateWeatherViewEmpty()
    func populateWeatherView(city: String?, temperature: Double?, weatherSummary: String?, weatherImageString: String?, hideCelciusLabel: Bool, hideDetailButton: Bool)
}

protocol WeatherViewModelable: NewFeatureable {
    
    //MARK: protocol service
    var weatherService: WeatherServiceable { get }
    var cityService: CityRequestDataable { get }

    //MARK: input
    var showDetailButton: PublishSubject<Void> { get }
    var searchCityButton: PublishSubject<Void> { get }
    var searchCityButtonNeedLoading: PublishSubject<Bool> { get }
    var detailWeatherSubscription: (([DailyDetailWeatherData]) -> Void)? { get set }
        
    //MARK: output
    var cityLabel: BehaviorSubject<String?> { get }
    var temperatureLabel: BehaviorRelay<String?> { get }
    var weatherInfoLabel: BehaviorRelay<String?> { get }
    var weatherImageString: BehaviorRelay<UIImage?> { get }
    var hideCelciusLabel: BehaviorRelay<Bool> { get }
    var hideDetailButton: BehaviorRelay<Bool> { get }
    var dailyDetailWeatherData: BehaviorRelay<[DailyDetailWeatherData]> { get set }
    
}

class WeatherViewModel: WeatherViewModelable, WeatherPopulateable {
    
    var dailyDetailWeatherData = BehaviorRelay<[DailyDetailWeatherData]>(value: []) 
    
    var detailWeatherSubscription: (([DailyDetailWeatherData]) -> Void)?
    
    var cityLabel: BehaviorSubject<String?> = BehaviorSubject<String?>(value: nil)
    let temperatureLabel = BehaviorRelay<String?>(value: "")
    let weatherInfoLabel = BehaviorRelay<String?>(value: "")
    let weatherImageString = BehaviorRelay<UIImage?>(value: UIImage(named: "indonesia"))
    let hideCelciusLabel = BehaviorRelay<Bool>(value: true)
    let hideDetailButton = BehaviorRelay<Bool>(value: true)
    
    var showDetailButton = PublishSubject<Void>()
    var searchCityButton = PublishSubject<Void>()
    var searchCityButtonNeedLoading = PublishSubject<Bool>()
    
    private let disposeBag = DisposeBag()

    var weatherService: WeatherServiceable
    var cityService: CityRequestDataable
    
    init(weatherService: WeatherServiceable, cityService: CityRequestDataable) {
        self.weatherService = weatherService
        self.cityService = cityService
        self.makeSubscription()
    }
    
    // MARK: - Protocol Conformance
    
    func populateWeatherViewEmpty() {
        populateWeatherView(city: "Kota tidak ada !!", temperature: nil, weatherSummary: "", weatherImageString: "indonesia", hideCelciusLabel: true, hideDetailButton: true)
    }
    
    func populateWeatherView(city: String? = nil, temperature: Double?, weatherSummary: String?, weatherImageString: String?, hideCelciusLabel: Bool, hideDetailButton: Bool) {
        if let city = city {
            self.cityLabel.onNext(city.uppercased())
        }
        
        self.temperatureLabel.accept(temperature == nil ? nil : "\(Int(temperature!))")
        self.weatherInfoLabel.accept(weatherSummary)
        
        if let weatherImageString = weatherImageString {
            self.weatherImageString.accept(UIImage(named: weatherImageString))
        }
        
        self.hideCelciusLabel.accept(hideCelciusLabel)
        self.hideDetailButton.accept(hideDetailButton)
    }

    // MARK: - Private Method
    
    private func requestCityData() {
        self.searchCityButtonNeedLoading.onNext(true)
        
        self.cityService.requestCityData(cityName: try? self.cityLabel.value()?.uppercased()) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(_):
                self.populateWeatherViewEmpty()
                self.searchCityButtonNeedLoading.onNext(false)
            case .success(let city):
                self.requestWeatherData(lat: city?.lat, long: city?.long)
                //self.getDailyDetailWeatherDataFromCityDataJSON(lat: city?.lat, long: city?.long)
            }
        }
    }
    
    private func requestWeatherData(lat: Double?, long: Double?) {
        guard let lat = lat, let long = long else {
            return
        }
        
        self.weatherService.requestWeatherData(lat: lat, long: long) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(_):
                self.populateWeatherViewEmpty()
            case .success(let weatherData):
                self.populateWeatherView(
                    temperature: Double(convertToCelsius: (weatherData?.currently.temperature)!),
                    weatherSummary: weatherData?.currently.summary,
                    weatherImageString: weatherData?.currently.icon,
                    hideCelciusLabel: false,
                    hideDetailButton: false)
                self.dailyDetailWeatherData.accept(weatherData!.daily.data)
            }
            self.searchCityButtonNeedLoading.onNext(false)
        }
    }

    private func makeSubscription() {
        
        //Show Daily Detail Weather
        showDetailButton.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.detailWeatherSubscription?(self.dailyDetailWeatherData.value)
        }).disposed(by: disposeBag)
        
        //Search Weather by City from JSON
        searchCityButton.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.requestCityData()
        }).disposed(by: disposeBag)
        
    }
    
}


protocol NewFeatureable {
    func requestWeatherIfNeeded(lat: Double?, long: Double?, onRequest: () -> Void, onComplete: @escaping () -> Void)
}

extension NewFeatureable where Self: WeatherViewModelable & WeatherPopulateable {
    
    func requestWeatherIfNeeded(lat: Double?, long: Double?, onRequest: () -> Void, onComplete: @escaping () -> Void){
        //guard let lat = self.weather.latitude.value, let long = self.weather.longitude.value else { return }
        onRequest()
        self.weatherService.requestWeatherData(lat: lat, long: long) { result in
            switch result {
            case .failure(_):
                self.populateWeatherViewEmpty()
            case .success(let weatherData):
                self.populateWeatherView(
                    city: try? self.cityLabel.value()?.uppercased(),
                    temperature: Double(convertToCelsius: (weatherData?.currently.temperature)!),
                    weatherSummary: weatherData?.currently.summary,
                    weatherImageString: weatherData?.currently.icon,
                    hideCelciusLabel: false,
                    hideDetailButton: false)
                self.dailyDetailWeatherData.accept(weatherData!.daily.data)
            }
            onComplete()
        }
    }
    
}

