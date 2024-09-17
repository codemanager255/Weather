import Foundation

enum ApiError: Error {
    case invalidUrl
    case invalidResponse
    case other(String)
}

class ApiCall {
    
    
    func getApiData() {
        Task {
            let result = await callApi()
            switch result {
            case .success(let data):
                self.dataObj = data
                print("Data fetched successfully:", data)
            case .failure(let err):
                print("Error in fetching data from API:", err.localizedDescription)
            }
        }
    }
    
    private func callApi() async -> Result<WeatherData, Error> {
        let apiKey = "138111086d989400c27883397852247e"
        let apiUrl = "https://api.openweathermap.org/data/2.5/weather?q=Atlanta&appid=138111086d989400c27883397852247e"
        
        guard let url = URL(string: apiUrl) else {
            return .failure(ApiError.invalidUrl)
        }
        
        let urlSession = URLSession.shared
        
        do {
            let (data, response) = try await urlSession.data(from: url)
            guard let _response = response as? HTTPURLResponse, _response.statusCode == 200 else {
                throw ApiError.invalidResponse
            }
            let decoder = JSONDecoder()
            let allData = try decoder.decode(WeatherData.self, from: data)
            return .success(allData)
        } catch {
            print(error.localizedDescription)
            return .failure(ApiError.other(error.localizedDescription))
        }
    }
}
