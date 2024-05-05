//
//  CityViewModel.swift
//  BulutSystemCase
//
//  Created by Mert Sondaş on 4.05.2024.
//
import SwiftUI
import CoreLocation

// its observable because we will observe the changes on object
final class CityViewViewModel: Observable {
    @Published var weather = WeatherResponse.empty()
    
    @Published var city: String = "San Francisco" {
        didSet{
            getLocation()
        }
    }
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()
    private lazy var dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
    }()
    
    private lazy var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh a"
        return formatter
    }()
    
    init(){
        getLocation()
    }
    
    var date:String {
        return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.current.dt)))
    }
    var weatherIcon: String {
        if weather.current.weather.count > 0 {
            return weather.current.weather[0].icon
        }
        return "sun.max.fill"
    }
    var temprature:String{
        return getTempFor(temp: weather.current.temp)
    }
    
    var conditions:String{
        if weather.current.weather.count > 0 {
            return weather.current.weather[0].main
        }
        return ""
    }
    var windSpeed:String {
        return String(format: "%0.1f", weather.current.wind_speed)
    }
    var humidity:String {
        return String(format: "%d%%", weather.current.humidity)
    }
    var rainChances:String {
        return String(format: "%0.0f%%", weather.current.dew_point)
    }
    func getTimeFor(timestamp: Int) -> String {
        return timeFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
    func getTempFor(temp: Double) -> String {
        return String(format: "%0.1f", temp)
    }
    func getDayFor(timestamp: Int) -> String {
        return dayFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
    
    private func getLocation(){
        CLGeocoder().geocodeAddressString(city){ (placemarks,error) in
            if let places = placemarks, let place = places.first {
                self.getWeather(coord: place.location?.coordinate)
            }
            
        }
    }
    
    private func getWeather(coord: CLLocationCoordinate2D?){
        if let coord = coord{
            let urlString = API.getURLfor(lat: coord.latitude, lon: coord.longitude)
                getWeatherInternal(city: city, for: urlString)
        }else {
            let urlString = API.getURLfor(lat: 40.652074, lon: 35.833737)
            getWeatherInternal(city: city, for: urlString)
        }
    }
    private func getWeatherInternal(city: String,for urlString: String){
        NetworkManager<WeatherResponse>.fetch(for: URL(string: urlString)!){
            (Result) in
            switch Result{
            case .success(let response):
                DispatchQueue.main.async{
                    self.weather = response
                }
            case .failure(let err):
                print(err)
            }
        }
    }
    func getLottieAnimationFor(icon: String) -> String {
        switch icon {
        case "01":
            return "sunny"
        case "02":
            return "rainy"
        case "03":
            return "snowy"
        case "04":
            return "cloudy"
        case "05":
            return "thunder"
        case "06":
            return "sunnyRainy"
        case "07":
            return "partlyCloudy"
        default:
            return "sunny"
        }
    }
    
    func getWeatherIconFor(icon: String) -> Image {
        switch icon {
        case "01":
            return Image(systemName: "sun.max.fill")//sunny
        case "02":
            return Image(systemName: "moon.fill")
        default:
            return Image(systemName: "sun.max.fill")
        }
    }
}
