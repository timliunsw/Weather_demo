//
//  Double+Extension.swift
//  Weather
//
//  Created by Tim Li on 4/8/19.
//  Copyright © 2019 Tim Li. All rights reserved.
//

import Foundation

extension Double {
    func toString() -> String {
        return String(format:"%.0f", self)
    }
    
    func toDegreeString()  -> String {
        return String(format:"%.0f°", self)
    }
    
    func toHumidityString() -> String {
        return String(format:"%.0f", self) + " %"
    }
    
    func toPressureString() -> String {
        return String(format:"%.0f mb", self)
    }
    
    func toVisibilityString() -> String {
        return String(format:"%.1f km", self/1000)
    }
}
