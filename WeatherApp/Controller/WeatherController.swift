//
//  WeatherController.swift
//  WeatherApp
//
//  Created by admin on 1/15/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class WeatherController: UIViewController {
    
    @IBOutlet weak var citySearchTextField: UITextField!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherInfoLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var celsiusLabel: UILabel!
    @IBOutlet weak var showDetailButton: UIButton!
    @IBOutlet weak var searchCityButton: UIButton!
    
    //deklarasi protocol
    var viewModelWeather: WeatherViewModelable
    let disposeBag = DisposeBag()
    let loading = Loading()
    
    init(viewModel: WeatherViewModelable) {
        self.viewModelWeather = viewModel
        super.init(nibName: "WeatherView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()

//        viewModelWeather.requestWeatherIfNeeded(
//            onRequest: { [weak self] in
//            guard let self = self else { return }
//            self.loading.startLoading() },
//
//            onComplete: { [weak self] in
//            guard let self = self else { return }
//            self.loading.stopLoading()
//        })

        //tittle navigation bar
        navigationItem.title = "Report Weather"
    }
    
    private func bindData() {
        
        //binding data yang akan di eksekusi adalah yang paling atas duluan
        
        //action button ketika di tap
        self.searchCityButton.rx.tap
            .bind(to: self.viewModelWeather.searchCityButton)
            .disposed(by: disposeBag)
        
        self.showDetailButton.rx.tap
            .bind(to: self.viewModelWeather.showDetailButton)
            .disposed(by: disposeBag)
        
        viewModelWeather.searchCityButtonNeedLoading
            .subscribe{ [weak self] needLoading in
                guard let self = self else { return }
                if needLoading.element ?? false {
                    self.loading.startLoading()
                } else {
                    self.loading.stopLoading()
                }
            }.disposed(by: disposeBag)
        
        viewModelWeather.cityLabel
            .bind(to: citySearchTextField.rx.text)
            .disposed(by: disposeBag)
        
        self.citySearchTextField.rx.text
            .orEmpty
            .bind(to: self.viewModelWeather.cityLabel)
            .disposed(by: disposeBag)
        
        //binding label
        viewModelWeather.cityLabel
            .asObservable()
            .map{ $0 }
            .bind(to: self.cityLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModelWeather.weatherInfoLabel
            .asObservable()
            .map{ $0 }
            .bind(to: self.weatherInfoLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModelWeather.weatherImageString
            .asObservable()
            .map{ $0 }
            .bind(to: self.weatherImage.rx.image)
            .disposed(by: disposeBag)
        
        viewModelWeather.temperatureLabel
            .asObservable()
            .map{ $0 }
            .bind(to: self.temperatureLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModelWeather.hideDetailButton
            .asObservable()
            .bind(to: self.showDetailButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModelWeather.hideCelciusLabel
            .asObservable()
            .bind(to: self.celsiusLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
    }
    
    //hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }

}
