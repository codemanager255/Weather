//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Serena Roderick on 9/13/24.
//

import UIKit
import Combine
protocol WeatherViewModelProtocol {
    
    func getApiData() throws
    func handleApiData()
    func kelvinToCelcius(kelvin: Double) -> Double
    func kelvinToFarenheit(kelvin: Double) -> Double
}

class WeatherViewModel: WeatherViewModelProtocol {

    @Published var weatherData: WeatherData?
    
    var networkManager: ApiCall
    
    init(networkManager: ApiCall) {
        self.networkManager = networkManager
    }
    
    enum Errors: Error {
        case noData
    }
    
    var apiURL: String = ""
    @MainActor
    func getApiData() throws {
        Task {
            weatherData = await networkManager.getApiData(for: "Atlanta")
            print(weatherData)
        }
    }
    
    func handleApiData() {
    }
    
    func kelvinToFarenheit(kelvin: Double) -> Double {
        var celcius = kelvinToCelcius(kelvin: kelvin)
        return ((9/5) * celcius + 32)
    }
    
    func kelvinToCelcius(kelvin: Double) -> Double {
        return kelvin - 273.15
    }
}
