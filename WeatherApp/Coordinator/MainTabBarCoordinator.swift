//
//  MainTabBarCoordinator.swift
//  WeatherApp
//
//  Created by admin on 2/6/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

class MainTabBarCoordinator: Coordinator {
    var viewController: ViewController = .init()
    
    
    private let homeCoordinator = HomeCoordinator()
    private let weatherCoordinator = WeatherCoordinator()
    private let mapCoordinator = MapWeatherCoordinator()
    
    weak var window: Window?
    
    init(window: Window?) {
        self.window = window
    }
  
    func start() {
        homeCoordinator.start()
        weatherCoordinator.start(city: nil, latitude: nil, longitude: nil)
        mapCoordinator.start()
        
        let viewControllers = [homeCoordinator.viewController, weatherCoordinator.navigationController, mapCoordinator.navigationController]
        
        let tabBarItems: [TabBarItem] = [
            TabBarItem(title: "", image: Image(named: "home-30"), tag: 1),
            TabBarItem(title: "", image: Image(named: "cloud-30"), tag: 2),
            TabBarItem(title: "", image: Image(named: "map-30"), tag: 3)
        ]
        
        let viewModel = MainTabBarViewModel(
            viewControllers: viewControllers,
            tabBarItems: tabBarItems
        )
        
        window?.rootViewController = MainTabBarController(viewModel: viewModel)
        window?.makeKeyAndVisible()
    }
    
}
