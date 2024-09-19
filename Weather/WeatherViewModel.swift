//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Serena Roderick on 9/13/24.
//

import UIKit
import Combine
protocol WeatherViewModelProtocol {
    func getApiData(city: String) throws
    func getCityFromUI(weatherView: WeatherDisplayVC)
    func kelvinToCelcius(kelvin: Double) -> Int
    func kelvinToFarenheit(kelvin: Double) -> Int
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
    func getApiData(city: String) throws {
        Task {
            weatherData = await networkManager.getApiData(for: city)
        }
    }
    
    @MainActor func getCityFromUI(weatherView: WeatherDisplayVC) {
        let city = weatherView.searchBar.text ?? "no city"
        do {
            try getApiData(city: city)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func kelvinToFarenheit(kelvin: Double) -> Int {
        let celcius = kelvinToCelcius(kelvin: kelvin)
        return Int(((celcius * 9) / 5) + 32)
    }
    
    func kelvinToCelcius(kelvin: Double) -> Int {
        return Int(kelvin - 273.15)
    }
}
