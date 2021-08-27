//
//  WeatherDetailsViewModelTests.swift
//  WeatherTests
//
//  Created by MAC on 27/08/21.
//

import XCTest
@testable import Weather

class WeatherDetailsViewModelTests: XCTestCase {

    var mockRepository:MockWeatherRepository!
    var viewModel:WeatherDetailsViewModel!
    
    override func setUpWithError() throws {
        mockRepository = MockWeatherRepository()
        let mockWeatherDetails = WeatherDetails(cityName:"London", type:"Cloudy", descripton:"Cloudy", temprature:18.0, tempMax:19.0, tempMin:16.0, imageName:"", lat:51.67, long:0.2157)
        
        viewModel = WeatherDetailsViewModel(repository: mockRepository, weatherDetails:mockWeatherDetails)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockRepository = nil
    }
    
    func test_fetchWeatherForCastSuccess() {
        mockRepository.responseFileName = "HourlyWeeklyFrocastsSuccess"
        viewModel.fetchWeatherForCast()
        XCTAssertEqual(viewModel.dailyItemCount, 8)
        XCTAssertEqual(viewModel.hourlyItemCount, 1)
        XCTAssertEqual(viewModel.getHourlyForcast().count, 48)
    }
    
    func test_getDailyForcast() {
        mockRepository.responseFileName = "HourlyWeeklyFrocastsSuccess"
        viewModel.fetchWeatherForCast()
        var dailyForCast = viewModel.getDailyForcast(for: 0)
        XCTAssertNotNil(dailyForCast)
        
        // Invalid Index
        dailyForCast = viewModel.getDailyForcast(for: -1)
        XCTAssertNil(dailyForCast)
        dailyForCast = viewModel.getDailyForcast(for: 10)
        XCTAssertNil(dailyForCast)
    }
    func test_fetchWeatherForCastFailure() {
        mockRepository.responseFileName = "HourleyWeeklyForcastsFailure"
        viewModel.fetchWeatherForCast()
        XCTAssertEqual(viewModel.dailyItemCount, 0)
        XCTAssertEqual(viewModel.hourlyItemCount, 1)
        XCTAssertEqual(viewModel.getHourlyForcast().count, 0)

    }
    
    func test_filterOptions() {
       let filterOptions =  viewModel.filterOptions
        XCTAssertEqual(filterOptions.count, 2)
        XCTAssertEqual(filterOptions[0], .hourly)
        XCTAssertEqual(filterOptions[1], .daily)
    }
   
   
}
