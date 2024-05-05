//
//  DeailyWeather.swift
//  BulutSystemCase
//
//  Created by Mert Sondaş on 4.05.2024.
//

import Foundation

struct DailyWeather: Codable, Identifiable {
    var dt: Int
    var temp: Temprature
    var weather: [WeatherDetail]
    
    case CodingKey: String {
        case dt
        case temp
        case weather
    }
    init(){
        dt = 0
        temp = Temprature( min: 0.0, max: 0.0)
        weather = [WeatherDetail(main: "",description: "", icon: "")]
    }
}

extension DailyWeather {
    var id: UUID {
        return UUID()
    }
}
