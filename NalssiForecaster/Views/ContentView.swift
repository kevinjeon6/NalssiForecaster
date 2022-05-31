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
    @FocusState private var isFocused: Bool
    
    //MARK: - Computed Properties
    
    var hourlyFirstTwelve: [Current] {
        guard let hourly = model.weatherData?.hourly else {
            return []
        }
        return Array(hourly.prefix(13))
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
                            Button {
                                isEditing = false
                                cityName = ""
                            } label: {
                                Text("Cancel")
                            }
                            .padding(.trailing, 10)
                            .transition(.move(edge: .trailing))
                            .animation(.default)
                           
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
                }//VStack
                .navigationTitle("NalssiForecaster")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            print("Choose celsius or fahrenheit")
                        } label: {
                            Image(systemName: "list.dash")
                        }//button
                        
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
