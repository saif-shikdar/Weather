//
//  EndPoint.swift
//  Weather
//
//  Created by MAC on 27/08/21.
//

import Foundation

enum EndPoint {
    static let baseUrl = "https://api.openweathermap.org/data/2.5"
    static let appId = "fad7be6d3efab6853151833dfe5b49c2"
}

enum APIPath:String {
    case weather = "/weather"
    case onecall = "/onecall"
}
