//
//  CoordinatorWeather.swift
//  WeatherApp
//
//  Created by admin on 1/30/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import Foundation

class WeatherCoordinator: NSObject, (ParentCoordinator & NavigationCoordinator), UINavigationControllerDelegate {
    var viewController: UIViewController = .init()
    
    var parentCoordinator: MapWeatherCoordinator?
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController = .init()) {
        self.navigationController = navigationController
    }
    
    //load pertama
    func start(city: String?, latitude: Double?, longitude: Double?) {
        //delegate hanya ada 1 kali di parent
        //kasusnya karena weather coordinator bisa jadi parent atau child
        if parentCoordinator === nil {
            navigationController.delegate = self
        }
        
        let loading = Loading()
        let vcWeatherController = WeatherController(
            viewModel: WeatherViewModel(
                weatherService: WeatherServiceAPI(),
                cityService: CityRequestDataFromJSON(
                    cityRequestListDataResponse: CityRequestListDataFromJSON(
                        jsonRequestFileService: JSONRequestFileLocal()
                    )
                )
            )
        )
        
        viewController = vcWeatherController
        vcWeatherController.viewModelWeather.cityLabel.onNext(city)
        
        vcWeatherController.viewModelWeather.detailWeatherSubscription = { [weak self] data in
            self?.detailWeatherSubscription(data: data)
        }
        
        //request data dari map weather
        if latitude != nil && longitude != nil {
            vcWeatherController.viewModelWeather.requestWeatherIfNeeded(lat: latitude, long: longitude,
                onRequest: {
                loading.startLoading()
            },
                onComplete: {
                loading.stopLoading()
            })
        }
        
        navigationController.pushViewController(vcWeatherController, animated: false)
    }

    func detailWeatherSubscription(data detailWeather: [DailyDetailWeatherData]) {
        //tambahan
        print(childCoordinators.count)
        let child = DetailWeatherCoordinator(navigationController: navigationController)
        
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start(detailData: detailWeather)
    }
    
//    //kalau back
//    private func childDidFinish(_ child: Coordinator?) {
//        for (index, coordinator) in childCoordinators.enumerated() {
//            if coordinator === child {
//                childCoordinators.remove(at: index)
//                break
//            }
//        }
//    }
//    
//    //Nav back to weather controller
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }

        if navigationController.viewControllers.contains(fromViewController) {
            return
        }

        if fromViewController is DetailWeatherController {
            childCoordinators.enumerated().forEach {
                if $0.element.viewController === fromViewController {
                    childCoordinators.remove(at: $0.offset)
                }
            }
        }

    }
    
}
