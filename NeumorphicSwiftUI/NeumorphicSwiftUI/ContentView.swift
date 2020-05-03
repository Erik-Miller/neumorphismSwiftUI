//
//  ContentView.swift
//  NeumorphicSwiftUI
//
//  Created by Erik Miller on 5/2/20.
//  Copyright © 2020 Erik Miller. All rights reserved.
//

import SwiftUI

extension Color{
    static let offWhite = Color(red: 225 / 255, green: 225/255, blue: 225/255)
    
    
    
    static let darkStart = Color(red: 255/255, green: 255/255, blue: 255/255)
    static let darkEnd = Color(red: 150/255, green: 150/255, blue: 155/255)
    
    
    static let lightStart = Color(red: 253/255, green: 75/255, blue: 155/255)
    static let lightEnd = Color(red: 125/255, green: 32/255, blue: 72/255)
}

extension LinearGradient{
    init(_ colors: Color...){
        self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}


struct SimpleButtonStyle: ButtonStyle{
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(30)
            .contentShape(Circle())
            .background(
                Group{
                    if configuration.isPressed{
                        Circle()
                            .fill(Color.offWhite)
                            .overlay(
                                Circle()
                                    .stroke(Color.gray, lineWidth: 4)
                                    .blur(radius: 4)
                                    .offset(x: 2, y: 2)
                                    .mask(Circle().fill(LinearGradient(Color.black, Color.clear)))
                        )
                            .overlay(
                                Circle()
                                    .stroke(Color.white, lineWidth: 8)
                                    .blur(radius: 4)
                                    .offset(x: -2, y: -2)
                                    .mask(Circle().fill(LinearGradient(Color.clear, Color.black)))
                        )
                    }
                    else {
                        Circle()
                            .fill(Color.offWhite)
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                    }
                }
        )
    }
}

struct DarkBackground<S: Shape>: View{
    var isHighlighted: Bool
    var shape: S
    
    var body: some View{
        ZStack{
            if isHighlighted{
                shape
                    .fill(LinearGradient(Color.darkEnd, Color.darkStart))
                    //.overlay(shape.stroke(LinearGradient(Color.darkStart, Color.darkEnd), lineWidth: 4))
                    .shadow(color: Color.darkStart, radius: 10, x: 5, y: 5)
                    .shadow(color: Color.darkEnd, radius: 10, x: -5, y: -5)
            }
                
            else{
                shape
                    .fill(LinearGradient(Color.darkStart, Color.darkEnd))
                    //.overlay(shape.stroke(Color.darkEnd, lineWidth: 4))
                    .shadow(color: Color.darkStart, radius: 10, x: -10, y: -10)
                    .shadow(color: Color.darkEnd, radius: 10, x: 10, y: 10)
                
            }
        }
    }
}

struct DarkButtonStyle: ButtonStyle{
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(30)
            .contentShape(Circle())
            .background(
                DarkBackground(isHighlighted: configuration.isPressed, shape: Circle())
        )
            .animation(nil)
    }
}


struct DarkToggleStyle: ToggleStyle{
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        })
        {
            configuration.label
                .padding(30)
                .contentShape(Circle())
        }
        .background(
            DarkBackground(isHighlighted: configuration.isOn, shape: Circle()))
    }
}

struct ColorfulBackground<S: Shape>: View{
    var isHighlighted: Bool
    var shape: S
    
    var body: some View{
        ZStack{
            if isHighlighted{
                shape
                    .fill(LinearGradient(Color.lightEnd, Color.lightStart))
                    .overlay(shape.stroke(LinearGradient(Color.darkStart, Color.darkEnd), lineWidth: 4))
                    .shadow(color: Color.darkStart, radius: 10, x: 5, y: 5)
                    .shadow(color: Color.darkEnd, radius: 10, x: -5, y: -5)
            }
                
            else{
                shape
                    .fill(LinearGradient(Color.darkStart, Color.darkEnd))
                    .overlay(shape.stroke(Color.darkEnd, lineWidth: 4))
                    .shadow(color: Color.darkStart, radius: 10, x: -10, y: -10)
                    .shadow(color: Color.darkEnd, radius: 10, x: 10, y: 10)
                
            }
        }
    }
}

struct ColorfulButtonStyle: ButtonStyle{
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(30)
            .contentShape(Circle())
            .background(
                ColorfulBackground(isHighlighted: configuration.isPressed, shape: Circle())
        )
            .animation(nil)
    }
}

struct ColorfulToggleStyle: ToggleStyle{
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        })
        {
            configuration.label
                .padding(30)
                .contentShape(Circle())
        }
        .background(
            ColorfulBackground(isHighlighted: configuration.isOn, shape: Circle()))
    }
}

struct ContentView: View {
    @State private var isToggled = false
    @State private var lightIsToggled = false
    
    var body: some View {
        ZStack{
            
            LinearGradient(Color.darkStart, Color.darkEnd)
            
            VStack(spacing: 40){
                
                Button(action:{
                    print("Button Tapped")
                    
                })
                {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.black)
                }
                .buttonStyle(DarkButtonStyle())
                
                
                Toggle(isOn: $isToggled){
                    Image(systemName: "heart.fill")
                        .foregroundColor(Color.black)
                }
                .toggleStyle(DarkToggleStyle())
                
                
                Button(action:{
                    print("Button Tapped")
                    
                })
                {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.black)
                }
                .buttonStyle(ColorfulButtonStyle())
                
                
                Toggle(isOn: $lightIsToggled){
                    Image(systemName: "heart.fill")
                        .foregroundColor(Color.black)
                }
                .toggleStyle(ColorfulToggleStyle())
            
            
        }
        
        
    }.edgesIgnoringSafeArea(.all)
}
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
