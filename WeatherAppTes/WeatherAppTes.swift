//
//  WeatherAppTes.swift
//  WeatherAppTes
//
//  Created by admin on 1/23/20.
//  Copyright © 2020 admin. All rights reserved.
//

import XCTest
@testable import WeatherApp

class WeatherAppTes: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test() {
        
    }
    

    func testExample() {
        let tes = DailyDetailWeatherData.init(time: 111, summary: "", icon: "rain", temperatureHigh: 1)
        //tes.celcius
        XCTAssertNotNil(tes.self)

        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
