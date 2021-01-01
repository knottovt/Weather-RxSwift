//
//  WeatherViewController.swift
//  Weather
//
//  Created by Visarut Tippun on 1/1/21.
//

import UIKit
import RxSwift
import RxCocoa
import CoreLocation
import Then

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var myLocationButton: UIButton!
    
    let locationManager = CLLocationManager()
    var viewModel = WeatherViewModel()
    var tableHeaderView:WeatherTableHeaderView = .loadFromNib(of: WeatherTableHeaderView.self)
    var tableFooterView:WeatherTableFooterView = .loadFromNib(of: WeatherTableFooterView.self)
    var refresher:UIRefreshControl!
    private let bag = DisposeBag()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.tableView.tableHeaderView == nil {
            self.tableView.tableHeaderView = self.tableHeaderView
        }
        if self.tableView.tableFooterView == nil {
            self.tableView.tableFooterView = self.tableFooterView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        self.bindViewModel()
    }
    
    func configureView() {
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestLocation()
        
        self.searchTextField.placeholder = "Type something"
        self.searchTextField.delegate = self
        
        self.tableView.separatorStyle = .none
        self.tableView.register(cells: [SunRiseSunSetTableViewCell.self,
                                        FeelsLikeTableViewCell.self,
                                        WindTableViewCell.self,
                                        PressureTableViewCell.self,
                                        VisibilityTableViewCell.self])
        self.tableView.rx.setDelegate(self).disposed(by: self.bag)
        
        self.refresher = UIRefreshControl()
        self.tableView.refreshControl = self.refresher
        self.refresher.rx.controlEvent(.valueChanged).subscribe(onNext: { (_) in
            self.refresher.endRefreshing()
            guard let cityName = self.viewModel.weather.value?.name else { return }
            self.viewModel.fetchWeather(cityName: cityName).subscribe {
            } onError: { (error) in
                print(error.localizedDescription)
            }.disposed(by: self.bag)
        }).disposed(by: self.bag)
    }
    
    func bindViewModel() {
        self.viewModel.weather.subscribe(onNext: { (weather) in
            self.tableHeaderView.configure(weather: weather)
            self.tableFooterView.configure(weather: weather)
        }).disposed(by: self.bag)
        
        self.viewModel.dataSource.bind(to: self.tableView.rx.items) { (tableView, row, item) in
            let indexPath = IndexPath(row: row, section: 0)
            let weather = self.viewModel.weather.value
            switch item {
            case .sunRiseSunSet:
                return tableView.dequeueCell(of: SunRiseSunSetTableViewCell.self, for: indexPath).then { (cell) in
                    cell.configure(weather: weather)
                }
            case .feelsLike:
                return tableView.dequeueCell(of: FeelsLikeTableViewCell.self, for: indexPath).then { (cell) in
                    cell.configure(weather: weather)
                }
            case .wind:
                return tableView.dequeueCell(of: WindTableViewCell.self, for: indexPath).then { (cell) in
                    cell.configure(weather: weather)
                }
            case .pressure:
                return tableView.dequeueCell(of: PressureTableViewCell.self, for: indexPath).then { (cell) in
                    cell.configure(weather: weather)
                }
            case .visibility:
                return tableView.dequeueCell(of: VisibilityTableViewCell.self, for: indexPath).then { (cell) in
                    cell.configure(weather: weather)
                }
            }
        }.disposed(by: self.bag)
        
        self.searchButton.rx.tap.bind {
            self.performSearch()
        }.disposed(by: self.bag)
        
        self.myLocationButton.rx.tap.bind {
            self.locationManager.requestLocation()
        }.disposed(by: self.bag)
    }
    
    func performSearch() {
        guard let cityName = self.searchTextField.text else { return }
        self.viewModel.fetchWeather(cityName: cityName).subscribe {
            //
        } onError: { (error) in
            print(error.localizedDescription)
        }.disposed(by: self.bag)
    }
    
}

extension WeatherViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return WeatherTableHeaderSectionView.loadFromNib(of: WeatherTableHeaderSectionView.self).then { (view) in
            self.viewModel.weather.map({$0?.name ?? "-"}).bind(to: view.cityNameLabel.rx.text).disposed(by: self.bag)
        }
    }
    
}

extension WeatherViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.performSearch()
        return true
    }
    
}

extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            Logger.location.log("lat: \(lat), lon: \(lon)")
            self.viewModel.fetchWeather(lat: lat, lon: lon).subscribe {
                //
            } onError: { (error) in
                Logger.critical.log(error.localizedDescription)
            }.disposed(by: self.bag)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        Logger.location.log(error.localizedDescription)
    }
    
}
