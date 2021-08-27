//
//  MainCoordinator.swift
//  Weather
//
//  Created by MAC on 27/08/21.
//

import Foundation
import UIKit

protocol Coordinator:AnyObject {
    var navigationController: UINavigationController { get set }
    func start()
    func gotoWeatherForCast(weatherDetails: WeatherDetails)
}

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let sb = UIStoryboard(name:"Main", bundle:nil)
        guard let vc = sb.instantiateViewController(withIdentifier:"WeatherSearchViewController") as? WeatherSearchViewController else { return }
        
        vc.viewModel = WeatherSearchViewModel()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func gotoWeatherForCast(weatherDetails: WeatherDetails) {
        let sb = UIStoryboard(name:"Main", bundle:nil)
        guard let vc = sb.instantiateViewController(withIdentifier:"WeatherDetailsViewController") as? WeatherDetailsViewController else { return }
        
        vc.viewModel = WeatherDetailsViewModel(weatherDetails:weatherDetails)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
}
