//
//  MainTabBarViewModel.swift
//  WeatherApp
//
//  Created by admin on 2/6/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit

class MainTabBarViewModel {
    let viewControllers: [UIViewController]
    var tabBarItems: [UITabBarItem]
    
    init(viewControllers: [UIViewController], tabBarItems: [UITabBarItem]) {
        self.viewControllers = viewControllers
        self.tabBarItems = tabBarItems
    }
}
