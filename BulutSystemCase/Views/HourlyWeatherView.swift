//
//  HourlyWeatherView.swift
//  BulutSystemCase
//
//  Created by Mert Sondaş on 5.05.2024.
//

import SwiftUI

struct HourlyWeatherView: View {
    @ObservedObject var cityVM: CityViewViewModel
    
    func fahrenheitToCelsius(f: Double) -> Double {
       return (f - 32) * 5/9
    }
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 20){
                ForEach(cityVM.weather.hourly){
                    weather in
                    let icon = cityVM.getWeatherIconFor(icon: weather.weather.count > 0 ? weather.weather[0].icon: "sun.max.fill")
                    let hour = cityVM.getTimeFor(timestamp: weather.dt)
                    let temp = cityVM.getTempFor(temp: weather.temp)
                    getHourlyView(hour: hour, image: icon, temp: temp)
                }
            }
        }
    }
    private func getHourlyView(hour: String, image: Image, temp: String) -> some View {
        VStack(spacing: 20) {
            Text(hour)
            image
                .foregroundColor(.yellow)
            Text(String(format: "%0.1f" , fahrenheitToCelsius(f: Double(temp) ?? 10.0)))
        
            //Text(temp)
        }
        .foregroundColor(.white)
        .padding()
        //.background(RoundedRectangle(cornerRadius: 5).fill(Color.red))
        .background(RoundedRectangle(cornerRadius: 5).fill(LinearGradient(gradient: Gradient(colors:[Color.blue.opacity(0.5),Color.blue]),startPoint: .topLeading,endPoint: .bottomTrailing)))
        .shadow(color: Color.white.opacity(0.1),radius: 2 , x: -2 , y: -2)
        .shadow(color: Color.black.opacity(0.1),radius: 2 , x: 2 , y: 2)
    }
}

struct HourlyWeatherView_Previews: PreviewProvider{
    static var previews: some View {
        ContentView()
    }
}
