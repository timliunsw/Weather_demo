//
//  DefaultsKeys+Extension.swift
//  Weather
//
//  Created by Tim Li on 4/8/19.
//  Copyright © 2019 Tim Li. All rights reserved.
//

import SwiftyUserDefaults

extension DefaultsKeys {
    static let cities = DefaultsKey<[String]>("cities", defaultValue: Constants.DEFAULT_CITIES) 
}
