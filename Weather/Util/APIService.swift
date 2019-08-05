//
//  APIService.swift
//  Weather
//
//  Created by Tim Li on 4/8/19.
//  Copyright © 2019 Tim Li. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

enum APIError: String, Error {
    case noNetwork = "No Network"
    case serverOverload = "Server is overloaded"
    case permissionDenied = "You don't have permission"
}

protocol APIServiceProtocol {
    func fetchWeatherData(cities: [String], complete: @escaping ( _ success: Bool, _ cities: [City], _ error: APIError? )->() )
}

class APIService: APIServiceProtocol {
    func fetchWeatherData(cities: [String], complete: @escaping ( _ success: Bool, _ cities: [City], _ error: APIError? )->() ) {
        DispatchQueue.global().async {
            var CitiesData = [City]()
            for i in 0..<cities.count {
                let params : [String : String] = ["id" : cities[i], "units" : Constants.UNITS, "appid" : Constants.APP_ID]
                Alamofire.request(Constants.WEATHER_URL, method: .get, parameters: params).responseJSON { (response) in
                    switch response.result {
                    case .success:
                        if let value = response.result.value {
                            let json = JSON(value)
                            if let name = json["name"].string {
                                let city = City.init(id: cities[i], name: name, temp: json["main"]["temp"].double!.toDegreeString(), minTemp: json["main"]["temp_min"].double!.toDegreeString(), maxTemp: json["main"]["temp_max"].double!.toDegreeString(), humidity: json["main"]["humidity"].double!.toHumidityString(), pressure: json["main"]["pressure"].double!.toPressureString(),summary: json["weather"][0]["main"].string!,visibility:json["visibility"].double!.toVisibilityString())
                                CitiesData.append(city)
                                //sort result array due to response time of each request is different
                                if CitiesData.count == cities.count {
                                    var orderedCitiesData : [City] = []
                                    for orderId in cities {
                                        let city = CitiesData.filter{ $0.id == orderId }.first
                                        orderedCitiesData.append(city!)
                                    }
                                    complete( true, orderedCitiesData, nil )
                                }
                            }
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    } 
}
