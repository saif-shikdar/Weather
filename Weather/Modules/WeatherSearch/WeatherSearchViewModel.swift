//
//  WeatherSearchViewModel.swift
//  Weather
//
//  Created by MAC on 27/08/21.
//

import Foundation

protocol WeatherSearchViewModelType {
    var numberOfItems:Int { get }
    var weatherBinding: Published<WeatherResponse?>.Publisher { get }
    func getWeather(_ location:String?)
    func getWeatherDetails(for index:Int)-> WeatherDetails?
}

class WeatherSearchViewModel: WeatherSearchViewModelType {
        
    var weatherBinding: Published<WeatherResponse?>.Publisher { $weatherResponse }
    var errorBinding: Published<String?>.Publisher { $errorMessage }
    
    var numberOfItems: Int {
        return searchResults.count
    }

    // MARK: - private properties
    @Published private var weatherResponse:WeatherResponse?
    @Published private var errorMessage:String?
    @Published private var searchResults:[WeatherResponse] = []

    private var repository:WeatherRepositoryService
   
    init(repository:WeatherRepositoryService = WeatherRepository()) {
        self.repository = repository
    }
    
    func getWeather(_ location:String?) {
        guard  let location = location else {
            return
        }
        repository.search(location:location, modelType:WeatherResponse.self) { result in
            switch result {
            case .success(let response):
                self.weatherResponse = response
                self.searchResults.append(response)
                
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func getWeatherDetails(for index:Int)-> WeatherDetails? {
        guard index >= 0 , index < searchResults.count else {
            return nil
        }
        let weatherResponse = searchResults[index]
        guard let weather = weatherResponse.weather.first else { return nil}
        return WeatherDetails(cityName:weatherResponse.name, type:weather.main,
            descripton:weather.weatherDescription,
            temprature: weatherResponse.main.temp,
            tempMax: weatherResponse.main.tempMax,
            tempMin: weatherResponse.main.tempMin,
            imageName: weatherImageName(type: weather.main),
            lat: weatherResponse.coord.lat,
            long: weatherResponse.coord.lon)
    }
    
    private func weatherImageName(type:String)-> String {
        print(type)
        switch type {
        case "clear" :
            return "ClearAndSunny"
        case "a" :
            return "CloudyOverNight"
        case "Haze" :
            return "GustyWinds"
        case "c" :
            return "HailStorms"
        case "d" :
            return "HeavyRain"
        case "Clouds" :
            return "PartlyCloudy"
        default:
            return "ClearAndSunny"
        }
    }
}

