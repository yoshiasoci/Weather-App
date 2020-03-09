//
//  CoordinatorDetailWeather.swift
//  WeatherApp
//
//  Created by admin on 1/30/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit

class DetailWeatherCoordinator: NavigationCoordinator {
    var viewController: UIViewController = .init()
    
    var parentCoordinator: WeatherCoordinator?
    
    //salah !
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController = .init()) {
        self.navigationController = navigationController
    }
    
    func start(detailData: [DailyDetailWeatherData]) {
        let vcDetailWeatherController = DetailWeatherController(viewModel: DetailWeatherViewModel())
        vcDetailWeatherController.viewModelDetailWeather.dailyDetailWeatherData.accept(detailData)
        viewController = vcDetailWeatherController
        navigationController.pushViewController(vcDetailWeatherController, animated: false)
    }
        
}
