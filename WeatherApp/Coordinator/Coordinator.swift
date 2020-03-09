//
//  Coordinator.swift
//  WeatherApp
//
//  Created by admin on 1/30/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var viewController:  UIViewController { get set }
}

protocol ParentCoordinator: Coordinator {
    var childCoordinators: [Coordinator] { get set }
}

protocol NavigationCoordinator: ParentCoordinator {
    var navigationController: UINavigationController { get set }
}

extension NavigationCoordinator {
    var viewController: UIViewController {
        navigationController.viewControllers.first ?? UIViewController()
    }
}
