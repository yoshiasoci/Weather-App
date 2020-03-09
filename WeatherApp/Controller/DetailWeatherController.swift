//
//  DetailWeatherController.swift
//  WeatherApp
//
//  Created by admin on 1/15/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class DetailWeatherController: UIViewController {
    
    let disposeBag = DisposeBag()
    var viewModelDetailWeather: DetailWeatherViewModelable
    
    init(viewModel: DetailWeatherViewModelable) {
        self.viewModelDetailWeather = viewModel
        super.init(nibName: "DetailWeatherView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var weatherCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        weatherCollectionView.register(UINib(nibName: "DetailWeatherCollectionView", bundle: nil), forCellWithReuseIdentifier: "DetailWeatherCollectionViewCell")
        bindData()
        
    }
    
    private func bindData() {

        viewModelDetailWeather.dailyDetailWeatherData
            .asObservable()
            .bind(to: weatherCollectionView.rx.items(cellIdentifier: "DetailWeatherCollectionViewCell", cellType: DetailWeatherCollectionController.self)) { (row,data,cell) in
                cell.populateCell(
                    weatherImageString: data.icon,
                    date: String(intervalSince1970: data.time),
                    temperature: Double(convertToCelsius: data.temperatureHigh),
                    summary: data.summary)
            }.disposed(by: disposeBag)
        
        weatherCollectionView.rx.willDisplayCell
            .subscribe(onNext: ({ (cell,indexPath) in
                cell.alpha = 0
                let transform = CATransform3DTranslate(CATransform3DIdentity, 0, -250, 0)
                cell.layer.transform = transform
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                    cell.alpha = 1
                    cell.layer.transform = CATransform3DIdentity
                }, completion: nil)
            })).disposed(by: disposeBag)
    }
    
}
