//
//  SettingsView.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 22/11/2023.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("silentKey") var silentValue = false
    @AppStorage("loudKey") var loudValue = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("")
                .navigationTitle("Settings")
                .navigationBarTitleDisplayMode(.inline)
            
            List {
                Section {
                    Label(
                        title: { Toggle("Vibrations", isOn: $silentValue) },
                        icon: { Image(systemName: "iphone.radiowaves.left.and.right") }
                    )
                    Label(
                        title: { Toggle("Sound", isOn: $loudValue) },
                        icon: { Image(systemName: "speaker.wave.2.fill") }
                    )
                } header: {
                    Text("Sound")
                } footer: {
                    Text("Vibrations are turned on by default.")
                }
                
                // These don't currently do anything
                Section {
                    Label(
                        title: { Text("Review") },
                        icon: { Image(systemName: "star.bubble") }
                    )
                    Label(
                        title: { Text("Buy Me A Coffee") },
                        icon: { Image(systemName: "cup.and.saucer.fill") }
)
                    Label(
                        title: { Text("Instagram") },
                        icon: { Image("Instagram_icon")
                                .resizable()
                                .frame(width: 30, height: 30, alignment: .center)}
                    )
                    Label(
                        title: { Text("TikTok") },
                        icon: { Image("Tiktok_icon")
                                .resizable()
                                .frame(width: 30, height: 30, alignment: .center)}
                    )
                    
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
