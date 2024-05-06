//
//  DailiyWeatherView.swift
//  BulutSystemCase
//
//  Created by Mert Sondaş on 5.05.2024.
//

import SwiftUI

struct DailiyWeatherView: View {
    @ObservedObject var cityVM: CityViewViewModel
    
    var body: some View {
        ForEach(cityVM.weather.daily){
            weather in
            LazyVStack{
                dailyCell(weather: weather)
            }
        }
    }
    func fahrenheitToCelsius(f: Double) -> Double {
       return (f - 32) * 5/9
    }
    private func dailyCell(weather:DailyWeather) -> some View {
        HStack {
            Text(cityVM.getDayFor(timestamp: weather.dt).uppercased())
                .frame(width: 50)
            //Text("\(String(format: "%0.1f",fahrenheitToCelsius(f: Double(cityVM.getTempFor(temp: weather.temp.min)) ?? 10.0)))℃")
            Spacer()
            Text("\(String(format: "%0.1f",fahrenheitToCelsius(f: Double(cityVM.getTempFor(temp: weather.temp.max)) ?? 10.0)))) | \(String(format: "%0.1f",fahrenheitToCelsius(f: Double(cityVM.getTempFor(temp: weather.temp.min)) ?? 10.0)))℃").frame(width: 150)
            Spacer()
            cityVM.getWeatherIconFor(icon: weather.weather.count > 0 ? weather.weather[0].icon : "sun.max.fill")
        }
        .foregroundColor(.white)
        .padding(.horizontal,40)
        .background(RoundedRectangle(cornerRadius: 20).fill(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.5),Color.blue]), startPoint: .top, endPoint: .bottom)).opacity(0.3))
        .shadow(color: Color.white.opacity(0.1),radius: 2 , x: -2 , y: -2)
        .shadow(color: Color.white.opacity(0.2),radius: 2 , x: 2 , y: 2)
    }
}

struct DailyWeather_PreviewView: PreviewProvider{
    static var previews: some View{
        ContentView()
    }
}
