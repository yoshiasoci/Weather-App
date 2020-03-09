//
//  MainCoordinator.swift
//  WeatherApp
//
//  Created by admin on 1/30/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit

class HomeCoordinator: Coordinator {
    var viewController: UIViewController = .init()

    func start() {
        viewController = HomeController(viewModel: HomeViewModel())
    }
    
}
