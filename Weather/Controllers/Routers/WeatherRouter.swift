//
//  WeatherRouter.swift
//  Weather
//
//  Created by Visarut Tippun on 1/1/21.
//

import Foundation
import Alamofire

enum WeatherRouter: Router {
    case weather(params: Parameters)
    
    var method: HTTPMethod {
        get{
            switch self {
            case .weather: return .get
            }
        }
    }
    
    var path: String {
        get{
            switch self {
            case .weather: return "weather"
            }
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        switch self {
        case .weather(let params):
            return try self.request(params: params)
        }
    }
}

