//
//  LoadingConfiguration.swift
//  WeatherApp
//
//  Created by admin on 2/2/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import SVProgressHUD

//protocol LoadingAble {
//    func startLoading()
//    func stopLoading()
//    func startLoadingWithStatusError()
//    func stopLoadingWithDelay()
//}

struct Loading {
    
    func startLoading() {
        SVProgressHUD.show()
    }
    
    func startLoadingWithStatusError() {
        SVProgressHUD.setStatus("Connection Lost 😓")
    }
    
    func stopLoading() {
        SVProgressHUD.dismiss()
    }
    
    func stopLoadingWithDelay() {
        SVProgressHUD.dismiss(withDelay: 1.5)
    }
    
}

//extension LoadingAble {
//    func startLoading() {
//        SVProgressHUD.show()
//    }
//
//    func stopLoading() {
//        SVProgressHUD.dismiss()
//    }
//}
