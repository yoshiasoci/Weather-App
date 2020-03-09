//
//  MapWeatherViewModel.swift
//  WeatherApp
//
//  Created by admin on 2/5/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol MapWeatherViewModelable {
    
    var weatherInfoButton: PublishSubject<Void> { get }
    
    var longitude: BehaviorRelay<Double?> { get }
    var latitude: BehaviorRelay<Double?> { get }
    var city: BehaviorRelay<String?> { get }
    
    //MARK: output
    var infoWeatherSubscription: ((_ city : String, _ latitude : Double, _ longitude : Double) -> Void)? { get set }
    
}

class MapWeatherViewModel: MapWeatherViewModelable {
    
    var weatherInfoButton = PublishSubject<Void>()
    
    let longitude = BehaviorRelay<Double?>(value: nil)
    let latitude = BehaviorRelay<Double?>(value: nil)
    let city = BehaviorRelay<String?>(value: nil)
    
    var infoWeatherSubscription: ((_ city: String, _ latitude: Double, _ longitude: Double) -> Void)?
    
    private let dispodeBag = DisposeBag()
    
    init() {
        self.makeSubscription()
    }
    
    // MARK: - Private Method
    
    private func makeSubscription() {
        weatherInfoButton.subscribe(onNext: { [weak self] _ in
        guard let self =  self else { return }
        self.infoWeatherSubscription?(self.city.value!.uppercased(), self.latitude.value!, self.longitude.value!)
        })
        .disposed(by: dispodeBag)
    }
    
}
