import Foundation

enum ApiError: Error {
    case invalidUrl
    case invalidResponse
    case other(String)
}

class ApiCall {
    
    //private var apiKey = ApiKey()
    
    func getApiData(for city: String) async -> WeatherData? {
        do {
            let data = try await callApi(for: city)
            return data
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    private func callApi(for city: String) async throws -> WeatherData {
        let apiKey = ""
        let apiUrl = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)"
        
        guard let url = URL(string: apiUrl) else {
            throw ApiError.invalidUrl
        }
        
        let urlSession = URLSession.shared
        
        let (data, response) = try await urlSession.data(from: url)
        guard let _response = response as? HTTPURLResponse, _response.statusCode == 200 else {
            throw ApiError.invalidResponse
        }
        
        let decoder = JSONDecoder()
        let allData = try decoder.decode(WeatherData.self, from: data)
        return allData
    }
}
