//
//  WheaterCoordinatorFactory.swift
//  WeatherApp
//
//  Created by admin on 2/4/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

struct WeatherCoordinatorFactory {
    
    static func create(_ navigationController: UINavigationController) -> WeatherCoordinator {
        .init(navigationController: navigationController)
    }
    
    // dibuat kalau mengirim paramerter di suatu function terlalu banyak
    
//    static func createWithParams(_ navigationController: UINavigationController, city: String?, latitude: Double?, longitude: Double?) -> WeatherCoordinator {
//        .init(
//            navigationController: navigationController,
//            city: city,
//            latitude: latitude,
//            longitude: longitude
//        )
//    }
    
}
