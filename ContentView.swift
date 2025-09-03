//
//  ContentView.swift
//  newWeatherApp
//
//  Created by Anapiya Nurkeldi on 02.09.2025.
//

import SwiftUI

struct WeatherData: Identifiable {
    var id: UUID = UUID()
    var day: String
    var imageName: String
    var temperature: Int
}

struct ContentView: View {
    @State private var isNight = false
    let weeklyWeather: [WeatherData] = [
        WeatherData(day: "MON", imageName: "cloud.sun.rain.fill", temperature: 13)
        , WeatherData(day: "TUE", imageName: "moon.stars.fill", temperature: 18)
        , WeatherData(day: "WED", imageName: "cloud.moon.fill", temperature: 22)
        , WeatherData(day: "THU", imageName: "cloud.sun.fill", temperature: 25)
        , WeatherData(day: "FRI", imageName: "sun.max.fill", temperature: 27)
        , WeatherData(day: "SAT", imageName: "sun.max.fill", temperature: 29)
    ]
    
    var body: some View {
        ZStack {
            BackgroundView(isNight: $isNight)
            VStack {
                CityTextView(cityName: "Los Angeles, CA")
                MainTemperatureView(Temperature: 29, ImageName: isNight ? "moon.stars.fill" : "cloud.sun.fill")
                WeekWeathers(weeklyWeather: weeklyWeather)
                Spacer()
                Button {
                    isNight.toggle()
                } label: {
                    WeatherButtonView(title: "Change Day Time",
                                      textColor: .blue,
                                      backgroundColor: .white)
                }
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}

struct WeatherDayView: View {
    var dayOfWeek: String
    var imageName: String
    var Temperature: Int
    var body: some View {
        VStack {
            Text(dayOfWeek)
                .foregroundColor(.white)
                .font(.system(size: 16))
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            Text("\(Temperature)°")
                .foregroundColor(.white)
                .font(.system(size: 28))
        }
    }
}

struct BackgroundView: View {
    @Binding var isNight: Bool
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [isNight ? .black : .blue, isNight ? .gray : Color("lightBlue")]),
                       startPoint: .top,
                       endPoint: .bottom)
        .edgesIgnoringSafeArea(.all)
    }
}

struct CityTextView: View {
    var cityName: String
    var body: some View {
        Text(cityName)
            .font(.system(size: 32, weight: .medium, design: .default))
            .foregroundColor(.white)
            .padding()
    }
}

struct MainTemperatureView: View {
    var Temperature: Int
    var ImageName: String
    var body: some View {
        VStack(spacing: 10){
            Image(systemName: ImageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
            Text("\(Temperature)°C")
                .font(.system(size: 70, weight: .medium, design: .default))
                .foregroundColor(.white)
        }.padding(.bottom, 40)
    }
}

struct WeekWeathers: View {
    var weeklyWeather: [WeatherData] = []
    var body: some View {
        HStack(spacing: 20) {
            ForEach(weeklyWeather) {
                weather in WeatherDayView(dayOfWeek: weather.day,
                                          imageName: weather.imageName,
                                          Temperature: weather.temperature)
            }
           
        }
    }
}
