//
//  WeatherSearchViewController.swift
//  Weather
//
//  Created by MAC on 27/08/21.
//

import UIKit
import Combine

class WeatherSearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var viewModel:WeatherSearchViewModelType!
    weak var coordinator:MainCoordinator!
    
    private var cancellabel = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        configureDataBinding()
        
        viewModel.getWeather("London")

    }
    
    
    private func configureDataBinding() {
        viewModel
            .weatherBinding
            .dropFirst()
            .receive(on: RunLoop.main).sink {[weak self] _ in
                self?.tableView.reloadData()
            }.store(in: &cancellabel)
    }
}

extension WeatherSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier:"weatherCell", for: indexPath) as? WeatherTableViewCell else {
            return UITableViewCell()
        }
        
        if let weatherDetails = viewModel.getWeatherDetails(for: indexPath.row) {
            cell.cityName.text =  weatherDetails.cityName
            cell.temprature.text = "\(String(describing:weatherDetails.temprature ))"
        
            cell.weatherImageView.image = UIImage(named:weatherDetails.imageName)
            cell.wDesc.text = weatherDetails.descripton
        }
        
        return cell
    }
    
    
}

extension WeatherSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard  let weatherDetails = viewModel.getWeatherDetails(for: indexPath.row) else { return }
        coordinator.gotoWeatherForCast(weatherDetails: weatherDetails)
    }
}

extension WeatherSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.getWeather(searchBar.text)
    
    }

}
