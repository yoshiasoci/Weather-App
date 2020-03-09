//
//  ImageCollectionViewCellController.swift
//  WeatherApp
//
//  Created by admin on 1/21/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DetailWeatherCollectionController: UICollectionViewCell {
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    func populateCell(weatherImageString: String, date: String, temperature: Double, summary: String) {
        temperatureLabel.text = "\(Int(temperature))"
        dateLabel.text = date
        summaryLabel.text = summary
        weatherImage.image = UIImage(named: weatherImageString)
    }
    
}
