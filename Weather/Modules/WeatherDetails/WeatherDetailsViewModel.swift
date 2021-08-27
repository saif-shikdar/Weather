//
//  WeatherDetailsViewModel.swift
//  Weather
//
//  Created by MAC on 27/08/21.
//

import Foundation

enum WeatherForCastType: String {
    case hourly = "hourly"
    case daily = "daily"
}

protocol WeatherDetailsViewModelType {
    var dailyItemCount:Int{ get }
    var hourlyItemCount:Int{ get }
    var weatherDetails:WeatherDetails { get }
    var filterOptions:[WeatherForCastType] { get }
    var weatherForCastBinding: Published<WeatherForcast?>.Publisher { get }
    func fetchWeatherForCast()
    func getDailyForcast(for index:Int)-> DailyForCastDetails?
    func getHourlyForcast()-> [HourlyForCastDetails]
}

class WeatherDetailsViewModel: WeatherDetailsViewModelType {
    
    var filterOptions: [WeatherForCastType] {
        return [.hourly, .daily]
    }
    var dailyItemCount: Int {
        return weatherForcast?.daily?.count ?? 0
    }
    var hourlyItemCount: Int {
        return 1
    }
    var weatherForCastBinding: Published<WeatherForcast?>.Publisher{ $weatherForcast }

    var errorBinding: Published<String?>.Publisher { $errorMessage }
    

    // MARK: - private properties
    @Published private var weatherForcast:WeatherForcast?
    @Published private var errorMessage:String?

    
    private var repository:WeatherRepositoryService
    var weatherDetails:WeatherDetails
        
    init(repository:WeatherRepositoryService = WeatherRepository(), weatherDetails:WeatherDetails) {
        self.repository = repository
        self.weatherDetails = weatherDetails
    }
    
    func fetchWeatherForCast() {
        repository.searchWeatherForcast(lat:"\(weatherDetails.lat)", long: "\(weatherDetails.long)", exclude:"", modelType:WeatherForcast.self) { [weak self] result in
            
            switch result {
            case .success(let response):
                self?.weatherForcast = response
            case .failure(let error):
                self?.weatherForcast = nil
                self?.errorMessage = error.localizedDescription
            }
        }
    }
    
    func getDailyForcast(for index: Int)-> DailyForCastDetails? {
        guard let dailyForCasts = weatherForcast?.daily,  index >= 0 , index < dailyForCasts.count else {
            return nil
        }
        let daily = dailyForCasts[index]
        
        let date = Date().getDate(milliSec:(daily.dt!))
        
        return  DailyForCastDetails(date:date, tempHigh:String(format:"%0.2f\u{00B0}",daily.temp.max.KelvinToDegreeCelcius()), tempLow: String(format:"%0.2f\u{00B0}",daily.temp.min.KelvinToDegreeCelcius()))
    }
    
    func getHourlyForcast() -> [HourlyForCastDetails] {
        guard  let hourlyForCasts = weatherForcast?.hourly else {
            return []
        }
        return hourlyForCasts.map { HourlyForCastDetails(date: Date().getHr(milliSec:($0.dt!)), temp: String(format:"%0.2f\u{00B0}",$0.temp.KelvinToDegreeCelcius()))}
    }
    
}
