//
//  WeatherService.swift
//  Weather
//
//  Created by Visarut Tippun on 1/1/21.
//

import Foundation
import Alamofire
import RxSwift
import RxAlamofire

class WeatherService {
    
    static let shared = WeatherService()
    private let bag = DisposeBag()
    
    func requestAndDecode(method: HTTPMethod, requestUrl:URL) -> Observable<Weather> {
        return Observable.create { (observable) -> Disposable in
            AF.rx.request(method, requestUrl).responseJSON().subscribe { (response) in
                if let request = response.request {
                    Logger.request.log(request.cURL)
                }
                if let data = response.data, let dataString = String(data: data, encoding: .utf8) {
                    Logger.response.log(dataString)
                }
                if let statusCode = response.response?.statusCode {
                    Logger.response.log("Status Code: \(statusCode)")
                    switch statusCode {
                    case 200 ..< 300:
                        do{
                            if let data = response.data,
                               let object = try? JSONDecoder().decode(Weather.self, from: data) {
                                observable.onNext(object)
                                observable.onCompleted()
                            }else{
                                observable.onError(ApplicationError.invalidJSONResponse)
                            }
                        }
                    default:
                        do{
                            if let data = response.data,
                               let JSONObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
                                if let code = JSONObject["cod"] as? Int {
                                    let message = JSONObject["message"] as? String
                                    observable.onError(ApplicationError.error(title: String(code), message: message, statusCode: statusCode))
                                }else{
                                    observable.onError(ApplicationError.unknownError(statusCode: statusCode))
                                }
                            }else if let error = response.error {
                                observable.onError(error)
                            }else{
                                observable.onError(ApplicationError.unknownError(statusCode: statusCode))
                            }
                        }catch let error {
                            observable.onError(error)
                        }
                    }
                }else if let error = response.error {
                    observable.onError(error)
                }else{
                    observable.onError(ApplicationError.unknownError(statusCode: nil))
                }
            } onError: { (error) in
                observable.onError(error)
            }.disposed(by: self.bag)
            return Disposables.create()
        }
    }
    
}
