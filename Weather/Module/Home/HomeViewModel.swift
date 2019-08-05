//
//  HomeViewModel.swift
//  Weather
//
//  Created by Tim Li on 3/8/19.
//  Copyright © 2019 Tim Li. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

class HomeViewModel {
    let apiService: APIServiceProtocol
    
    var cities: [City] = [City]() {
        didSet {
            DispatchQueue.main.async {
                self.updateTableViewClosure?()
            }
        }
    }
    
    var isLoading: Bool = false {
        didSet {
            DispatchQueue.main.async {
                self.updateLoadingStatus?()
            }
        }
    }
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    var updateTableViewClosure: (()->())?
    var updateLoadingStatus: (()->())?
    var showAlertClosure: (()->())?
    var deleteCellClosure: (()->())?
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    @objc func fetchData() {
        self.isLoading = true
        apiService.fetchWeatherData(cities: Defaults[.cities]) { [weak self] (success, cities , error) in
            self?.isLoading = false
            if let error = error {
                self?.alertMessage = error.rawValue
            } else {
                self?.processFetchedWeather(cities: cities)
            }
        }
    }
    
    private func processFetchedWeather(cities: [City]) {
        self.cities = cities
    }
    
    func setTimer() {
        //fetch data every 10 mins
        DispatchQueue.global(qos: .background).async {
            let timer = Timer.scheduledTimer(timeInterval: Constants.updateTimeInterval, target: self, selector: #selector(self.fetchData), userInfo: nil, repeats: true)
            let runLoop = RunLoop.current
            runLoop.add(timer, forMode: .defaultRunLoopMode)
            runLoop.run()
        }
    }
    
    func deleteCell(index: Int) {
        self.cities.remove(at:index)
        var tempCities = Defaults[.cities]
        tempCities.remove(at: index)
        Defaults[.cities] = tempCities
    }
    
}
