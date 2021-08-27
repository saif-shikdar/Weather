//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by MAC on 27/08/21.
//

import XCTest
@testable import Weather

class WeatherSearchViewModelTests: XCTestCase {

    var mockRepository = MockWeatherRepository()
    var viewModel:WeatherSearchViewModel!
    override func setUpWithError() throws {
        viewModel = WeatherSearchViewModel(repository: mockRepository)
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func test_getWeatherForLocation() {
        
        // Nil text for location text
        var searchLocation:String? = nil
        viewModel.getWeather(searchLocation)
        XCTAssertEqual(viewModel.numberOfItems, 0)
        
        
        // Empty text for location text
        searchLocation = ""
        viewModel.getWeather(searchLocation)
        XCTAssertEqual(viewModel.numberOfItems, 0)
        
        
        // Valid text search for location text
        mockRepository.responseFileName = "CurrentWeatherDetailsSuccess"
        searchLocation = "London"
        viewModel.getWeather(searchLocation)
        XCTAssertEqual(viewModel.numberOfItems, 1)
        

        // Valid text search for two time location search
        searchLocation = "London"
        viewModel.getWeather(searchLocation)
        XCTAssertEqual(viewModel.numberOfItems, 2)
        
        
        // Invalid location search after doing two valid location search
        mockRepository.responseFileName = "CurrentWeatherDetailsFailure"
        searchLocation = "invalid location"
        viewModel.getWeather(searchLocation)
        XCTAssertEqual(viewModel.numberOfItems, 2)

    }
    
    func test_getWeatherDetails() {
        
        // Nil text for location text
        var searchLocation:String? = nil
        viewModel.getWeather(searchLocation)
        var weatherDetails = viewModel.getWeatherDetails(for: 0)
        XCTAssertNil(weatherDetails)
        
        
        // Empty text for location text
        searchLocation = ""
        viewModel.getWeather(searchLocation)
        weatherDetails = viewModel.getWeatherDetails(for: 0)
        XCTAssertNil(weatherDetails)
        
        // Valid text search for location text
        mockRepository.responseFileName = "CurrentWeatherDetailsSuccess"
        searchLocation = "London"
        viewModel.getWeather(searchLocation)
         weatherDetails = viewModel.getWeatherDetails(for: 0)
        XCTAssertNotNil(weatherDetails)
        XCTAssertEqual(weatherDetails?.cityName, searchLocation)
        XCTAssertEqual(weatherDetails?.descripton, "mist")
        
        // invalid index
        
        weatherDetails = viewModel.getWeatherDetails(for: 2)
        XCTAssertNil(weatherDetails)
        
        weatherDetails = viewModel.getWeatherDetails(for: -1)
        XCTAssertNil(weatherDetails)

    }
}
