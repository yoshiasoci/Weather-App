//
//  CoordinatorMapWeather.swift
//  WeatherApp
//
//  Created by admin on 1/30/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit

class MapWeatherCoordinator: NSObject, ParentCoordinator, UINavigationControllerDelegate {
    var viewController: UIViewController = .init()
    
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController = .init()) {
        self.navigationController = navigationController
    }
    
    //load pertama
    func start() {
        //sebagai parent murni
        navigationController.delegate = self
        let vcMapWeatherController = MapWeatherController(viewModel: MapWeatherViewModel())
        viewController = vcMapWeatherController
        vcMapWeatherController.viewModelMapWeather.infoWeatherSubscription = { [weak self] city, latitude, longitude in
            self?.infoWeatherSubscription(city: city, latitude: latitude, longitude: longitude)
        }
        
        navigationController.pushViewController(vcMapWeatherController, animated: false)
    }
    
    func infoWeatherSubscription(city: String, latitude: Double, longitude: Double) {
        //tambahan
        print(childCoordinators.count)
        
        let child = WeatherCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start(city: city, latitude: latitude, longitude: longitude)
    
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
        
        //fromViewController dari anak jika lebih dari satu anak percabangannya ada banyak
        if fromViewController is WeatherController {
            childCoordinators.enumerated().forEach {
                if $0.element.viewController === fromViewController {
                    childCoordinators.remove(at: $0.offset)
                }
            }
        }
    }
        
}
