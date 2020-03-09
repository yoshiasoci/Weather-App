//
//  String + Timeinterval.swift
//  WeatherApp
//
//  Created by admin on 1/22/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

extension String {
    init(intervalSince1970: TimeInterval) {
        let convertDate = Date(timeIntervalSince1970: intervalSince1970)
        let format = DateFormatter()
        format.dateFormat = "MMM dd"
        format.timeZone = TimeZone(abbreviation: "UTC")
        format.locale = NSLocale.current
        self = format.string(from: convertDate)
    }
}
