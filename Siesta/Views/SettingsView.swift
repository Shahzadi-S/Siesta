//
//  SettingsView.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 22/11/2023.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @AppStorage("vibrationsKey") var vibrationsValue = false
    @AppStorage("soundKey") var soundValue = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("")
                .navigationTitle("Settings")
                .navigationBarTitleDisplayMode(.inline)
            
            List {
                Section {
                    Label(
                        title: {
                            Toggle("Vibrations", isOn: $vibrationsValue)
                                .onChange(of: vibrationsValue) { oldValue, newValue in
                                    if newValue == false {
                                        soundValue = false
                                    }
                                }
                        },
                        icon: { Image(systemName: "iphone.radiowaves.left.and.right") }
                    )
                    Label(
                        title: {
                            Toggle("Sound", isOn: $soundValue)
                                .onChange(of: soundValue) { oldValue, newValue in
                                    if newValue == true {
                                        vibrationsValue = true
                                    }
                                }
                        },
                        icon: { Image(systemName: "speaker.wave.2.fill") }
                    )
                } header: {
                    Text("Sound")
                }
                
                // These don't currently do anything
                Section {
                    Button {
                        print("Review Me")
                    } label: {
                        Label(
                            title: { 
                                Text("Review")
                                    .foregroundStyle(colorScheme == .light ? .black : .white)
                            },
                            icon: { Image(systemName: "star.bubble") }
                        )
                    }
                    
                    Button {
                        print("Time to brew the coffee")
                    } label: {
                        Label(
                            title: {
                                Text("Buy Me A Coffee")
                                    .foregroundStyle(colorScheme == .light ? .black : .white)
                            },
                            icon: { Image(systemName: "cup.and.saucer.fill") }
                        )
                    }
                    
                    Button {
                        print("Take me to the gram")
                    } label: {
                        Label(
                            title: {
                                Text("Instagram")
                                    .foregroundStyle(colorScheme == .light ? .black : .white)
                            },
                            icon: { Image("Instagram_icon")
                                    .resizable()
                                .frame(width: 30, height: 30, alignment: .center)}
                        )
                    }
                    
                    Button {
                        print("Time is ticking")
                    } label: {
                        Label(
                            title: {
                                Text("TikTok")
                                    .foregroundStyle(colorScheme == .light ? .black : .white)
                            },
                            icon: { Image("Tiktok_icon")
                                    .resizable()
                                .frame(width: 30, height: 30, alignment: .center)}
                        )
                    }
                }
                
                Section {
                    HStack {
                        Image(colorScheme == .dark ? "bannerDark" : "bannerLight")
                            .resizable()
                            .frame(width: 100, height: 100, alignment: .center)
                            .accessibilityHidden(true)
                            .clipShape(RoundedRectangle(cornerRadius: 8.0))
                        VStack(alignment: .leading) {
                            Text("Siesta ©")
                            Text("Version 1.0.0")
                                .font(.footnote)
                                .fixedSize(horizontal: false, vertical: true)
                                .foregroundStyle(.gray)
                            Text("Sanaa Shahzadi")
                                .font(.footnote)
                                .fixedSize(horizontal: false, vertical: true)
                                .foregroundStyle(.gray)
                            Text("All rights reserved")
                                .font(.footnote)
                                .fixedSize(horizontal: false, vertical: true)
                                .foregroundStyle(.gray)
                        }
                        .padding(.leading)
                    }
                }
                
            }
        }
    }
}

#Preview {
    SettingsView()
}
