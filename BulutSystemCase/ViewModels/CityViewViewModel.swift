//
//  CityViewModel.swift
//  BulutSystemCase
//
//  Created by Mert Sondaş on 4.05.2024.
//
import SwiftUI
import CoreLocation

// its observable because we will observe the changes on object
final class CityViewViewModel: ObservableObject {
    @Published var weather = WeatherResponse.empty()
    
    @Published var city: String = "Amasya, Sulova" {
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
        return formatter
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
        return "sunny"
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
        case "01d":
            return "sunny"
        case "01n":
            return "sunny"
        case "02d":
            return "partlyCloudy"
        case "02n":
            return "partlyCloudy"
        case "03d":
            return "cloudy"
        case "03n":
            return "cloudy"
        case "04d":
            return "partlyCloudy"
        case "04n":
            return "partlyCloudy"
        case "13d":
            return "snowy"
        case "13n":
            return "snowy"
        case "11d":
            return "thunder"
        case "11n":
            return "thunder"
        case "06d":
            return "sunnyRainy"
        case "06n":
            return "sunnyRainy"
        case "09d":
            return "rainy"
        case "09n":
            return "rainy"
        default:
            return "snowy"
        }
    }
    
    func getWeatherIconFor(icon: String) -> Image {
        switch icon {
        case "01d":
            return Image(systemName: "sun.max.fill")//sunny
        case "01n":
            return Image(systemName: "moon.fill")
        case "02d":
            return Image(systemName: "cloud.sun.fill")//sunny
        case "0n":
            return Image(systemName: "cloud.moon.fill")//sunny
        case "03d":
            return Image(systemName: "cloud.fill")//sunny
        case "03n":
            return Image(systemName: "cloud.fill")//sunny
        case "04d":
            return Image(systemName: "cloud.fill")//sunny
        case "04n":
            return Image(systemName: "cloud.fill")//sunny
        case "09d":
            return Image(systemName: "cloud.drizzle.fill")//sunny
        case "09n":
            return Image(systemName: "cloud.drizzle.fill")//sunny
        case "010d":
            return Image(systemName: "cloud.heavyrain.fill")//sunny
        case "010n":
            return Image(systemName: "cloud.heavyrain.fill")//sunny
        case "011d":
            return Image(systemName: "cloud.bolt.fill")//sunny
        case "011n":
            return Image(systemName: "cloud.bolt.fill")//sunny
        case "013d":
            return Image(systemName: "cloud.snow.fill")//sunny
        case "013n":
            return Image(systemName: "cloud.snow.fill")//sunny
        default:
            return Image(systemName: "sun.max.fill")
        }
    }
}
