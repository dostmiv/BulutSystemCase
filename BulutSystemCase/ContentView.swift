//
//  ContentView.swift
//  BulutSystemCase
//
//  Created by Mert Sondaş on 4.05.2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var cityVM = CityViewViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0){
                MenuHeaderView(cityVM: cityVM)
                ScrollView(showsIndicators: false){
                    CityView(cityVM: cityVM)
            }
            }.padding(.top,40)
        }.background(LinearGradient(gradient: Gradient(colors:[Color(red: 60, green: 66, blue: 161), Color(red:171,green: 174,blue:214)]),startPoint: .topLeading,endPoint: .bottomTrailing))
            .edgesIgnoringSafeArea(.all)
    }
        
}
struct ContentView_PreviewView: PreviewProvider{
    static var previews: some View{
        ContentView()
    }
}
