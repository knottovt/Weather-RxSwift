//
//  WeatherManager.swift
//  Weather
//
//  Created by Visarut Tippun on 1/1/21.
//

import Foundation
import RxSwift

class WeatherManager {
    
    static let shared = WeatherManager()
    private let bag = DisposeBag()
    
    
    func requestStringUrl() -> String {
        var urlString = Constant.weatherUrl
        urlString.append("?appid=\(Constant.apiKey)")
        urlString.append("&units=metric")
        return urlString
    }
    
    func getWeather(cityName:String) -> Observable<Weather> {
        return Observable.create { (observable) -> Disposable in
            var urlString = self.requestStringUrl()
            urlString.append("&q=\(cityName)")
            WeatherService.shared.requestAndDecode(method: .get, requestUrl: URL(string: urlString)!).subscribe { (result) in
                observable.onNext(result)
                observable.onCompleted()
            } onError: { (error) in
                observable.onError(error)
            }.disposed(by: self.bag)
            return Disposables.create()
        }
    }
    
    func getWeather(lat:Double, lon:Double) -> Observable<Weather> {
        return Observable.create { (observable) -> Disposable in
            var urlString = self.requestStringUrl()
            urlString.append("&lat=\(lat)")
            urlString.append("&lon=\(lon)")
            WeatherService.shared.requestAndDecode(method: .get, requestUrl: URL(string: urlString)!).subscribe { (result) in
                observable.onNext(result)
                observable.onCompleted()
            } onError: { (error) in
                observable.onError(error)
            }.disposed(by: self.bag)
            return Disposables.create()
        }
    }
    
}
