//
//  API-Extensions.swift
//  BulutSystemCase
//
//  Created by Mert Sondaş on 4.05.2024.
//

import Foundation

extension API {
    static let baseURLString = "https://api.openweathermap.org/data/3.0/"
    static func getURLfor(lat: Double, lon: Double) -> String {
        return "\(baseURLString)oncall?lat=\(lat)&lon=\(lon)&exclude=minutely&appid=\(key)&units=imperial"
    }
}
