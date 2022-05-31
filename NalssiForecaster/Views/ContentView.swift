//
//  ContentView.swift
//  NalssiForecaster
//
//  Created by Kevin Mattocks on 5/31/22.
//

import SwiftUI

struct ContentView: View {
    
    //MARK: - Properties
    @State private var cityName = ""
    @State private var isEditing = false
    @ObservedObject var model = WeatherViewModel()
    @State private var isCelsius = false
    @FocusState private var isFocused: Bool
    
    //MARK: - Computed Properties
    
    var hourlyFirstTwelve: [Current] {
        guard let hourly = model.weatherData?.hourly else {
            return []
        }
        return Array(hourly.prefix(13))
    }
    
    var selectedTempeartureUnit: some View {
        Menu {
            Picker("", selection: $isCelsius) {
                Text("Fahrenheit °F")
                    .tag(false)
                Text("Celsius °C")
                    .tag(true)
            }
        } label: {
            Image(systemName: "list.dash")
                .foregroundColor(.white)
        }
    }
    
    var searchField: some View {
        withAnimation {
            Button {
                isEditing = false
                cityName = ""
            } label: {
                Text("Cancel")
                    .foregroundColor(.white)
            }
            .padding(.trailing, 10)
            .transition(.move(edge: .trailing))
        }
    }
    
    
    //MARK: - Methods
    func convertTemp(_ temp: Double) -> Double {
        if isCelsius == true {
            return ((temp - 32) * (5/9))
        } else {
            return temp
        }
    }
    
    
    var body: some View {
        NavigationView {
            ZStack{
                Color.primaryColor
                    .ignoresSafeArea(.all)
                VStack {
                    
                    HStack {
                        TextField("Enter city", text: $cityName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .onTapGesture {
                                isEditing = true
                            }
                            .focused($isFocused)
                            .submitLabel(.search)
                            .onSubmit {
                                model.getWeatherData(cityName)
                            }
                        
                        if isEditing {
                         searchField
                        }
                    }//HStack
                    .padding()
          
                        VStack() {
                          
                                VStack(spacing: 4) {
                                    
                                    
                                    Text("\(Constants.tempToString(model.weatherData?.current.temp ?? 0.0))")
                                        .foregroundColor(.white)
                                        .bold()
                                        .font(.system(size: 60))
                                    
                                    
                                    Text(model.weatherData?.current.weather.first?.description ?? "Weather Description")
                                        .foregroundColor(.blue)
                                        .font(.system(size: 22))
                                    
                                    
                                    Text("Feels like: \(Constants.tempToString(model.weatherData?.current.feels_like ?? 0.0))")
                                        .foregroundColor(.white)
                                        .bold()
                                        .font(.system(size: 26))
                                    
                                    
                                }//VStack
                                .padding(.trailing, 20.0)
                                
                       Spacer()
                            
                            ScrollView(.horizontal) {
                                HStack(spacing: 20) {
                                    ForEach(hourlyFirstTwelve) {
                                            hour in
                                        VStack(spacing: 10) {
                                            Text("\(Constants.dtConversion(hour.dt))")
                                            HStack {
                                                Image(systemName: "thermometer")
                                                Text("\(Constants.tempToString(hour.temp))")
                                            }
                                        }//VStack
                                        .foregroundColor(.white)
                                        .font(.headline)
                                        .frame(width: 100, height: 100)
                                        .border(Color.mint)
                                        .background(.mint.opacity(0.5))
                                        .cornerRadius(5)
                                            
                                    }
                                }
                            }
                            Spacer()
                            
                        }//VStack
                        .padding()
                    
                    GeometryReader {
                        geo in
                        
                        ScrollView {
                            VStack(spacing: 20) {
                                ForEach(model.weatherData?.daily ?? []) { d in
                                    HStack(){
                                        
                                        Text("\(Constants.dtDaily(d.dt))")
                                        Spacer()
                                        Text(String(format: "Low: %.f°", convertTemp(d.temp.min)))
                                        Spacer()
                                        Text(String(format: "High: %.f°", convertTemp(d.temp.max)))
                                        
                                    }
                                }
                            }
                            .padding()
                        }
                    }//geometry reader
                    .background(Color.white)
                    .cornerRadius(12)
                    .edgesIgnoringSafeArea(.bottom)
                }//VStack
                .navigationTitle("NalssiForecaster")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                       selectedTempeartureUnit
                        
                    }//toolbar item
                }
            }//Zstack
        }//NavigationView
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
