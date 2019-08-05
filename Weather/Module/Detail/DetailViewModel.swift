//
//  DetailViewModel.swift
//  Weather
//
//  Created by Tim Li on 5/8/19.
//  Copyright © 2019 Tim Li. All rights reserved.
//

import Foundation

class DetailViewModel {
    
    var city = City() {
        didSet {
            DispatchQueue.main.async {
                self.updateViewClosure?()
            }
        }
    }
    
    var updateViewClosure: (()->())?
    
    init() {
        
    }
    
    func passData(_ city: City) {
        self.city = city
    }
}
