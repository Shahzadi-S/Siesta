//
//  PlayView.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 17/12/2023.
//

import SwiftUI

struct TapMeButton: ButtonStyle {
    var color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.background)
            .foregroundStyle(color)
            .frame(width: 70, height: 70, alignment: .center)
            .background(color.cornerRadius(50.0).opacity(0.7))
    }
}


struct PlayView: View {
    @State private var opacityRed = 1.0
    @State private var opacityGreen = 0.0
    @State private var opacityYellow = 0.0
    @State private var opacityBlue = 0.0
    
    @State private var wiggle = false
    
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(.red)
                        .opacity(0.3)
                    
                    Button(action: {
                        opacityRed = 0.0
                        opacityGreen = 1.0
                    }, label: {
                        Text("Tap")
                    })
                    .buttonStyle(TapMeButton(color: .red))
                    .opacity(opacityRed)
                    .font(.custom("Arial", size: wiggle ? 30: 20))
                    .onAppear() {
                        withAnimation(.linear(duration: 0.6).repeatForever()) {
                            wiggle.toggle()
                        }
                    }
                    
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(.green)
                        .opacity(0.3)
                    
                    Button(action: {
                        opacityGreen = 0.0
                        opacityYellow = 1.0
                    }, label: {
                        Text("Tap")
                    })
                    .buttonStyle(TapMeButton(color: .green))
                    .opacity(opacityGreen)
                    .font(.custom("Arial", size: wiggle ? 30: 20))
                    .animation(.linear(duration: 0.6).repeatForever(), value: wiggle)
                    
                }
            }
            
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(.yellow)
                        .opacity(0.3)
                    
                    Button(action: {
                        opacityYellow = 0.0
                        opacityBlue = 1.0
                    }, label: {
                        Text("Tap")
                    })
                    .buttonStyle(TapMeButton(color: .yellow))
                    .opacity(opacityYellow)
                    .font(.custom("Arial", size: wiggle ? 30: 20))
                    .animation(.linear(duration: 0.6).repeatForever(), value: wiggle)
                    
                    
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(.blue)
                        .opacity(0.3)
                    
                    Button(action: {
                        opacityBlue = 0.0
                    }, label: {
                        Text("Tap")
                    })
                    .buttonStyle(TapMeButton(color: .blue))
                    .opacity(opacityBlue)
                    .font(.custom("Arial", size: wiggle ? 30: 20))
                    .animation(.linear(duration: 0.6).repeatForever(), value: wiggle)
                    
                    
                }
            }
        }
        .scaledToFit()
        
    }
}

#Preview {
    PlayView()
}
