//
//  Constants.swift
//  Weather
//
//  Created by Tim Li on 4/8/19.
//  Copyright © 2019 Tim Li. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    static let SCREEN_WIDTH : CGFloat = UIScreen.main.bounds.width
    static let SCREEN_HEIGHT: CGFloat = UIScreen.main.bounds.height
    static let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    static let APP_ID = "c4733fb1e87ff09bbbe1105e02e6ffd7"
    static let UNITS = "metric"
    static let DEFAULT_CITIES = ["2158177", "2147714", "2174003"]
    static let detailSegueIdentifier = "showDetail"
    static let addCitySegueIdentifier = "addCity"
    //weather data in system is updated no more than one time every 10 minutes.
    static let updateTimeInterval = 600.0
}
