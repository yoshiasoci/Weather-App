//
//  ViewController.swift
//  WeatherApp
//
//  Created by admin on 1/14/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var viewModelHome: HomeViewModelable
    
    init(viewModel: HomeViewModelable) {
        self.viewModelHome = viewModel
        super.init(nibName: "HomeView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

