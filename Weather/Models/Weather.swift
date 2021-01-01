//
//  Weather.swift
//  Weather
//
//  Created by Visarut Tippun on 1/1/21.
//

import Foundation

struct Coordinate: Codable {
    var lat:Double?
    var lon:Double?
}

struct WeatherDetail: Codable {
    var id:Int?
    var main:String?
    var description:String?
    var icon:String?
}

struct Temperature: Codable {
    var temp:Double?
    var feelsLike:Double?
    var tempMin:Double?
    var tempMax:Double?
    var pressure:Int?
    var humidity:Int?
    
    private enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case humidity
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.temp = try? container.decodeIfPresent(Double.self, forKey: .temp)
        self.feelsLike = try? container.decodeIfPresent(Double.self, forKey: .feelsLike)
        self.tempMin = try? container.decodeIfPresent(Double.self, forKey: .tempMin)
        self.tempMax = try? container.decodeIfPresent(Double.self, forKey: .tempMax)
        self.pressure = try? container.decodeIfPresent(Int.self, forKey: .pressure)
        self.humidity = try? container.decodeIfPresent(Int.self, forKey: .humidity)
    }
    
    func encode(to encoder: Encoder) throws {
        var value = encoder.container(keyedBy: CodingKeys.self)
        try? value.encode(self.temp, forKey: .temp)
        try? value.encode(self.feelsLike, forKey: .feelsLike)
        try? value.encode(self.tempMin, forKey: .tempMin)
        try? value.encode(self.tempMax, forKey: .tempMax)
        try? value.encode(self.pressure, forKey: .pressure)
        try? value.encode(self.humidity, forKey: .humidity)
    }
    
}

struct Wind: Codable {
    var speed:Double?
    var degree:Int?
    
    private enum CodingKeys: String, CodingKey {
        case speed
        case degree = "deg"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.speed = try? container.decodeIfPresent(Double.self, forKey: .speed)
        self.degree = try? container.decodeIfPresent(Int.self, forKey: .degree)
    }
    
    func encode(to encoder: Encoder) throws {
        var value = encoder.container(keyedBy: CodingKeys.self)
        try? value.encode(self.speed, forKey: .speed)
        try? value.encode(self.degree, forKey: .degree)
    }
}

struct Clouds: Codable {
    var all:Int?
}

struct System: Codable {
    var id:Int?
    var type:Int?
    var country:String?
    var sunRise:Date?
    var sunSet:Date?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case type
        case country
        case sunRise = "sunrise"
        case sunSet = "sunset"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container.decodeIfPresent(Int.self, forKey: .id)
        self.type = try? container.decodeIfPresent(Int.self, forKey: .type)
        self.country = try? container.decodeIfPresent(String.self, forKey: .country)
        if let sunRise = try? container.decodeIfPresent(Double.self, forKey: .sunRise) {
            self.sunRise = Date.init(timeIntervalSince1970: sunRise)
        }
        if let sunSet = try? container.decodeIfPresent(Double.self, forKey: .sunSet) {
            self.sunSet = Date.init(timeIntervalSince1970: sunSet)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var value = encoder.container(keyedBy: CodingKeys.self)
        try? value.encode(self.id, forKey: .id)
        try? value.encode(self.type, forKey: .type)
        try? value.encode(self.country, forKey: .country)
        try? value.encode(self.sunRise, forKey: .sunRise)
        try? value.encode(self.sunSet, forKey: .sunSet)
    }
}

struct Weather: Codable {
    var code:Int?
    var id:Int?
    var name:String?
    var timeZone:Int?
    var coordinate:Coordinate?
    var weather:[WeatherDetail] = []
    var base:String?
    var temperature:Temperature?
    var precipitation:Int?
    var visibility:Double?
    var wind:Wind?
    var clouds:Clouds?
    var dataTime:Date?
    var sys:System?
    
    private enum CodingKeys: String, CodingKey {
        case code
        case id
        case name
        case timeZone = "timezone"
        case coordinate = "coord"
        case weather
        case base
        case temperature = "main"
        case precipitation
        case visibility
        case wind
        case clouds
        case dataTime = "dt"
        case sys
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.code = try? container.decodeIfPresent(Int.self, forKey: .code)
        self.id = try? container.decodeIfPresent(Int.self, forKey: .id)
        self.name = try? container.decodeIfPresent(String.self, forKey: .name)
        self.timeZone = try? container.decodeIfPresent(Int.self, forKey: .timeZone)
        self.coordinate = try? container.decodeIfPresent(Coordinate.self, forKey: .coordinate)
        self.weather = (try? container.decodeIfPresent([WeatherDetail].self, forKey: .weather)) ?? []
        self.base = try? container.decodeIfPresent(String.self, forKey: .base)
        self.temperature = try? container.decodeIfPresent(Temperature.self, forKey: .temperature)
        self.precipitation = try? container.decodeIfPresent(Int.self, forKey: .precipitation)
        self.visibility = try? container.decodeIfPresent(Double.self, forKey: .visibility)
        self.wind = try? container.decodeIfPresent(Wind.self, forKey: .wind)
        self.clouds = try? container.decodeIfPresent(Clouds.self, forKey: .clouds)
        if let dataTime = try? container.decodeIfPresent(Double.self, forKey: .dataTime) {
            self.dataTime = Date.init(timeIntervalSince1970: dataTime)
        }
        self.sys = try? container.decodeIfPresent(System.self, forKey: .sys)
    }
    
    func encode(to encoder: Encoder) throws {
        var value = encoder.container(keyedBy: CodingKeys.self)
        try? value.encode(self.code, forKey: .code)
        try? value.encode(self.id, forKey: .id)
        try? value.encode(self.name, forKey: .name)
        try? value.encode(self.timeZone, forKey: .timeZone)
        try? value.encode(self.coordinate, forKey: .coordinate)
        try? value.encode(self.weather, forKey: .weather)
        try? value.encode(self.base, forKey: .base)
        try? value.encode(self.temperature, forKey: .temperature)
        try? value.encode(self.precipitation, forKey: .precipitation)
        try? value.encode(self.visibility, forKey: .visibility)
        try? value.encode(self.wind, forKey: .wind)
        try? value.encode(self.clouds, forKey: .clouds)
        try? value.encode(self.dataTime, forKey: .dataTime)
        try? value.encode(self.sys, forKey: .sys)
    }
    
}

extension Weather {
    
    var conditionName: String {
        get{
            guard let id = self.weather.first?.id else { return "cloud" }
            switch id {
            case 200...232:
                return "cloud.bolt"
            case 300...321:
                return "cloud.drizzle"
            case 500...531:
                return "cloud.rain"
            case 600...622:
                return "cloud.snow"
            case 701...781:
                return "cloud.fog"
            case 800:
                return "sun.max"
            case 801...804:
                return "cloud.bolt"
            default:
                return "cloud"
            }
        }
    }
    
}
