//
//  AddCityViewModel.swift
//  Weather
//
//  Created by Tim Li on 5/8/19.
//  Copyright © 2019 Tim Li. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

class AddCityViewModel {
    
    var searchResult: [Dictionary<String, String>] = [Dictionary<String, String>]() {
        didSet {
            DispatchQueue.main.async {
                self.updateTableViewClosure?()
            }
        }
    }

    var updateTableViewClosure: (()->())?
    var selectCityClosure: (()->())?
    
    init() {
    
    }
    
    func selectCity(index: Int) {
        var cities = Defaults[.cities]
        cities.append(searchResult[index]["id"]!)
        Defaults[.cities] = cities
        DispatchQueue.main.async {
            self.selectCityClosure?()
        }
    }
    
    func searchCity(by: String) {
        searchResult = DBManager.shared.queryDBTable(searchString: by)
    }
    
    func cancelBtnClicked() {
        DispatchQueue.main.async {
            self.updateTableViewClosure?()
        }
    }
}
