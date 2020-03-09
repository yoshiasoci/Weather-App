//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by admin on 1/14/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

//this will hold the root

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    //var rootController: UIViewController!

    var window: UIWindow?
    
    //tambahan
    private var coordinator: MainTabBarCoordinator!
    //var coordinator: MainCoordinator?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //tambahan
//        let navController = UINavigationController()
//        coordinator = MainCoordinator(navigationController: navController)
//        coordinator?.start()
        
        
        window = .init(frame: UIScreen.main.bounds)
        
        coordinator = .init(window: window)
        coordinator.start()
        
        
//        window = .init(frame: UIScreen.main.bounds)
//        window?.rootViewController = ViewController(nibName: "ViewController", bundle: nil)
//        window?.makeKeyAndVisible()
//
//        //tab bar
//        let tabBarController = UITabBarController()
//        let tabViewControllerHome = ViewController(
//            nibName: "ViewController",
//            bundle: nil)
//
//        //add navigation bar in view controller
//        let tabViewControllerWeather = WeatherController(viewModel: WeatherViewModel())
//        let navigationFromWeaterController = UINavigationController(rootViewController: tabViewControllerWeather)
//
//        //let tabViewControllerMapWeather = MapWeatherController(viewModel: WeatherViewModel())
//
//        let tabViewControllerMapWeather = MapWeatherController(
//            nibName:"MapWeatherController",
//            bundle: nil)
//        let navigationFromMapWeatherController = UINavigationController(rootViewController: tabViewControllerMapWeather)
//
//        tabViewControllerHome.tabBarItem = UITabBarItem(
//            title: "",
//            image: UIImage(named: "home-30"),
//            tag: 1)
//        navigationFromWeaterController.tabBarItem = UITabBarItem(
//            title: "",
//            image: UIImage(named: "cloud-30"),
//            tag:2)
//        navigationFromMapWeatherController.tabBarItem = UITabBarItem(
//            title: "",
//            image: UIImage(named: "map-30"),
//            tag:3)
//
//        let controllers = [tabViewControllerHome,navigationFromWeaterController,navigationFromMapWeatherController]
//        tabBarController.viewControllers = controllers
//        window?.rootViewController = tabBarController
        
        //tambahan
        //coordinator.start()
        return true
    }
    
}

