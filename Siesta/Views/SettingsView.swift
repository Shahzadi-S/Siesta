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
                Section("Sound") {
                    VStack(alignment: .leading) {
                        Toggle("Silent Mode", isOn: $silentValue)
                        Text("Turn sounds and haptics off.")
                            .font(.footnote)
                            .fixedSize(horizontal: false, vertical: true)
                            .foregroundStyle(.gray)
                    }
                    VStack(alignment: .leading) {
                        Toggle("Loud Mode", isOn: $loudValue)
                        Text("Turn on for sound.")
                            .font(.footnote)
                            .fixedSize(horizontal: false, vertical: true)
                            .foregroundStyle(.gray)
                    }
                }
                
                // These don't currently do anything
                Section {
                    Text("Feedback")
                    Text("Buy Me A Coffee")
                    Text("Instagram")
                    Text("TikTok")
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
