//
//  MockWeatherRepository.swift
//  WeatherTests
//
//  Created by MAC on 27/08/21.
//

import Foundation
@testable import Weather


class MockWeatherRepository:WeatherRepositoryService, DecodeJson {
    
    var responseFileName = ""

    func search<T>(location: String, modelType: T.Type, completionHandler: @escaping Completion<T>) where T : Decodable {
        // Obtain Reference to Bundle
        let bundle = Bundle(for:MockWeatherRepository.self)
        
        guard let url = bundle.url(forResource:responseFileName, withExtension:"json"),
              let data = try? Data(contentsOf: url),
              let output = decodeObject(input:data, type:T.self)
        else {
            completionHandler(.failure(NetworkError.parsinFailed(message:"Failed to get response")))
            return
        }
        completionHandler(.success(output))
    }
    
    func searchWeatherForcast<T>(lat: String, long: String, exclude: String, modelType: T.Type, completionHandler: @escaping Completion<T>) where T : Decodable {
        // Obtain Reference to Bundle
        let bundle = Bundle(for:MockWeatherRepository.self)
        
        guard let url = bundle.url(forResource:responseFileName, withExtension:"json"),
              let data = try? Data(contentsOf: url),
              let output = decodeObject(input:data, type:T.self)
        else {
            completionHandler(.failure(NetworkError.parsinFailed(message:"Failed to get response")))
            return
        }
        completionHandler(.success(output))
    }
}
