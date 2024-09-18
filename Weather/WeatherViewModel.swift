//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Serena Roderick on 9/13/24.
//

import UIKit
protocol WeatherViewModelProtocol {
    
    func getApiData() throws
    func handleApiData()
    func passDataToView(data: Data)
    func kelvinToCelcius(kelvin: Double) -> Double
    func kelvinToFarenheit(kelvin: Double) -> Double
}

class WeatherViewModel: WeatherViewModelProtocol {
    var weatherData: [WeatherData]?
    
    var networkManager: ApiCall
    
    init(weatherData: [WeatherData]? = nil, networkManager: ApiCall, apiURL: String) {
        self.weatherData = weatherData
        self.networkManager = networkManager
        self.apiURL = apiURL
    }
    
    enum Errors: Error {
        case noData
    }
    
    var apiURL: String = ""
    
//    func getApiData() -> [WeatherData] {
//        return weatherData
//    }
    
    func handleApiData() {
        
    }
    
    func passDataToView(data: [WeatherData]) {
        
    }
    
    func kelvinToFarenheit(kelvin: Double) -> Double {
        var celcius = kelvinToCelcius(kelvin: kelvin)
        return ((9/5) * celcius + 32)
    }
    
    func kelvinToCelcius(kelvin: Double) -> Double {
        return kelvin - 273.15
    }
}
