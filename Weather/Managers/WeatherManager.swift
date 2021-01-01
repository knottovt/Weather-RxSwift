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
    
    func getWeather(cityName:String) -> Observable<Weather> {
        return Observable.create { (observable) -> Disposable in
            do{
                var params:[String:Any] = [:]
                params.updateValue(Constant.apiKey, forKey: "appid")
                params.updateValue(cityName, forKey: "q")
                params.updateValue("metric", forKey: "units")
                let request = try WeatherRouter.weather(params: params).asURLRequest()
                APIController.shared.requestAndDecode(withURLRequest: request, of: Weather.self).subscribe { (result) in
                    observable.onNext(result)
                    observable.onCompleted()
                } onError: { (error) in
                    observable.onError(error)
                }.disposed(by: self.bag)
            }catch let error {
                observable.onError(error)
            }
            return Disposables.create()
        }
    }
    
    func getWeather(lat:Double, lon:Double) -> Observable<Weather> {
        return Observable.create { (observable) -> Disposable in
            do{
                var params:[String:Any] = [:]
                params.updateValue(Constant.apiKey, forKey: "appid")
                params.updateValue(lat, forKey: "lat")
                params.updateValue(lon, forKey: "lon")
                params.updateValue("metric", forKey: "units")
                let request = try WeatherRouter.weather(params: params).asURLRequest()
                APIController.shared.requestAndDecode(withURLRequest: request, of: Weather.self).subscribe { (result) in
                    observable.onNext(result)
                    observable.onCompleted()
                } onError: { (error) in
                    observable.onError(error)
                }.disposed(by: self.bag)
            }catch let error {
                observable.onError(error)
            }
            return Disposables.create()
        }
    }
    
}
