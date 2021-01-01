//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Visarut Tippun on 1/1/21.
//

import Foundation
import RxSwift
import RxCocoa

enum WeatherSection: CaseIterable {
    case sunRiseSunSet
    case feelsLike
    case wind
    case pressure
    case visibility
}

class WeatherViewModel {
    
    var weather = BehaviorRelay<Weather?>(value: nil)
    var dataSource = BehaviorRelay<[WeatherSection]>(value: [])
    
    private let bag = DisposeBag()
    
    init() {
        self.generateSection()
    }
    
    func generateSection() {
        self.dataSource.accept(WeatherSection.allCases)
    }
    
    func fetchWeather(cityName:String) -> Completable {
        return Completable.create { (completable) -> Disposable in
            WeatherManager.shared.getWeather(cityName: cityName).subscribe { (result) in
                self.weather.accept(result)
                self.generateSection()
                completable(.completed)
            } onError: { (error) in
                completable(.error(error))
            }.disposed(by: self.bag)
            return Disposables.create()
        }
    }
    
    func fetchWeather(lat:Double, lon:Double) -> Completable {
        return Completable.create { (completable) -> Disposable in
            WeatherManager.shared.getWeather(lat: lat, lon: lon).subscribe { (result) in
                self.weather.accept(result)
                self.generateSection()
                completable(.completed)
            } onError: { (error) in
                completable(.error(error))
            }.disposed(by: self.bag)
            return Disposables.create()
        }
    }
    
}
