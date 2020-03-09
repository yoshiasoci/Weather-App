//
//  RequestJsonKota.swift
//  ApiCuaca
//
//  Created by admin on 1/12/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

protocol CityRequestListDataResponseable {
    func getCityListData(completionHandler: @escaping (Result<CityResponse?, Error>) -> Void)
}

class CityRequestListDataFromJSON: CityRequestListDataResponseable {
    
    internal typealias GetCityHandler = (Result<CityResponse?, Error>) -> Void
    private let jsonFile = "kota"
    
    let jsonRequestFileService: JSONRequestFileServiceable
    
    init(jsonRequestFileService: JSONRequestFileServiceable) {
        self.jsonRequestFileService = jsonRequestFileService
    }
    
    func getCityListData(completionHandler: @escaping GetCityHandler) {
        jsonRequestFileService.requestJsonFile(file: jsonFile, completionHandler: completionHandler)
    }
    
}
