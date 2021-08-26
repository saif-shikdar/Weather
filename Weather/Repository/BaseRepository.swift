//
//  BaseRepository.swift
//  Weather
//
//  Created by MAC on 27/08/21.
//

import Foundation

typealias Completion<T:Decodable> =  ((Result<T, NetworkError>) -> Void)

class BaseRepository {
    var networkManager:Networkable

    init(networkManager:Networkable = NetworkManager()) {
        self.networkManager = networkManager
    }
}

