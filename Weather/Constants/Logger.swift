//
//  Logger.swift
//  Weather
//
//  Created by Visarut Tippun on 1/1/21.
//

import Foundation

enum Logger: String {
    case request
    case response
    case location
    case critical
    case noti
    case other
    
    var name: String {
        return self.rawValue.capitalized
    }
    
    var symbol: String {
        switch self {
        case .request:
            return "📡"
        case .response:
            return "✏️"
        case .location:
            return "📍"
        case .critical:
            return "⛔️"
        case .noti:
            return "🔔"
        case .other:
            return "🔍"
        }
    }
    
    func message(_ value: String) -> String {
        return "\(self.symbol): [\(self.name)] => \(value)"
    }
    
    func log(_ value: String) {
        print(self.message(value))
    }
}
