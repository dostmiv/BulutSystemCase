//
//  TodayWeatherView.swift
//  BulutSystemCase
//
//  Created by Mert Sondaş on 5.05.2024.
//

import SwiftUI

struct TodayWeatherView: View {
    func fahrenheitToCelsius(f: Double) -> Double {
       return (f - 32) * 5/9
    }
    
    @ObservedObject var cityVM: CityViewViewModel
    var body: some View {
        VStack(spacing:10){
            Text("Today")
                .font(.largeTitle)
                .bold()
            
            HStack(spacing: 20){
                LottieView(name:cityVM.getLottieAnimationFor(icon: cityVM.weatherIcon))
                    .frame(width: 100, height: 100)
                VStack(alignment: .leading){
                    Text("\(String(format: "%0.1f",fahrenheitToCelsius(f: Double(cityVM.temprature) ?? 10.0)))℃")
                        .font(.system(size: 42))
                    Text(cityVM.conditions)
                }
            }
            HStack{
                Spacer()
                widgetView(image: "wind", color: .green, title: "\(cityVM.windSpeed)km/saat")
                Spacer()
                widgetView(image: "drop.fill", color: .blue, title: "\(cityVM.humidity)")
                Spacer()
                widgetView(image: "umbrella.fill", color: .red, title: "\(cityVM.rainChances)")
                Spacer()
                
            }
        }
        .padding()
        .foregroundColor(.white)
        .background(RoundedRectangle(cornerRadius: 20).fill(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.5),Color.blue]), startPoint: .top, endPoint: .bottom)).opacity(0.3))
        .shadow(color: Color.white.opacity(0.1),radius: 2 , x: -2 , y: -2)
        .shadow(color: Color.white.opacity(0.2),radius: 2 , x: 2 , y: 2)
    }
    private func widgetView(image: String, color: Color, title:String) -> some View{
        VStack{
            Image(systemName: image)
                .padding()
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .foregroundColor(color)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
            Text(title)
        }
    }
    

}


