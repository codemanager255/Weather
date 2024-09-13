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
    var networkManager: NetworkManager?
    
    enum Errors: Error {
        case noData
    }
    
    var apiURL: String = ""
    @MainActor
    func getApiData() throws {
        Task {
            do {
                weatherData = try await networkManager.get(model: [WeatherData].self)
            } catch {
                print(error.localizedDescription)
                throw Errors.noData
            }
        }
    }
    
    func handleApiData() {
        WeatherViewController.weatherData = weatherData
    }
    
    func passDataToView(data: Data) {
        
    }
    
    func kelvinToFarenheit(kelvin: Double) -> Double {
        var celcius = kelvinToCelcius(kelvin: kelvin)
        return ((9/5) * celcius + 32)
    }
    
    func kelvinToCelcius(kelvin: Double) -> Double {
        return kelvin - 273.15
    }
}
