//
//  City.swift
//  Weather
//
//  Created by Tim Li on 3/8/19.
//  Copyright © 2019 Tim Li. All rights reserved.
//

import Foundation

struct City: Codable {
    let id: String
    let name: String?
    let temp: String?
    let minTemp: String?
    let maxTemp: String?
    let humidity: String?
    let pressure: String?
    let summary: String?
    let visibility: String?
    init?() {
        return nil
    }
    
    init(id: String, name: String, temp: String, minTemp: String, maxTemp: String, humidity: String, pressure: String, summary: String, visibility: String) {
        self.id = id
        self.name = name
        self.temp = temp
        self.minTemp = minTemp
        self.maxTemp = maxTemp
        self.humidity = humidity
        self.pressure = pressure
        self.summary = summary
        self.visibility = visibility
    }
}
