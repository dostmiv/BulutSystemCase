//
//  CityView.swift
//  BulutSystemCase
//
//  Created by Mert Sondaş on 5.05.2024.
//

import SwiftUI

struct CityView: View {
    @ObservedObject var cityVM : CityViewViewModel
    
    var body: some View {
        VStack{
            CityNameView(city: cityVM.city, date: cityVM.date)
                .shadow(radius: 0)
            TodayWeatherView(cityVM: cityVM)
                .padding()
            HourlyWeatherView(cityVM: cityVM)
            DailiyWeatherView(cityVM: cityVM)
        }.padding(.bottom,30)
    }
}

struct CityView_PreviewView: PreviewProvider{
    static var previews: some View{
        ContentView()
    }
}
