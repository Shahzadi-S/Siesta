//
//  SettingsView.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 22/11/2023.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.openURL) var openURL
    
    @AppStorage("vibrationsKey") var vibrationsValue = false
    @AppStorage("soundKey") var soundValue = false
    
    let reviewLinks: [ExternalLink] = [ExternalLink(icon: "star.bubble",
                                                    title: "Review",
                                                    url: "https://www.apple.com"),
                                       ExternalLink(icon: "cup.and.saucer.fill",
                                                    title: "Buy Me A Coffee",
                                                    url: "https://www.buymeacoffee.com/thesiestaapp")]
    
    let socialLinks: [ExternalLink] = [ExternalLink(icon: "Instagram_icon",
                                                    title: "Instagram",
                                                    url: "https://www.instagram.com/thesiestaapp"),
                                       ExternalLink(icon: "Tiktok_icon",
                                                    title: "TikTok",
                                                    url: "https://www.tiktok.com/@siesta.app")]
    
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
                
                Section {
                    ForEach(reviewLinks) { link in
                        Button {
                            openURL(URL(string: link.url)!)
                        } label: {
                            Label(
                                title: {
                                    Text(link.title)
                                        .foregroundStyle(colorScheme == .light ? .black : .white)
                                },
                                icon: {
                                    Image(systemName: link.icon)
                                }
                            )
                        }
                    }
                    
                    ForEach(socialLinks) { link in
                        Button {
                            openURL(URL(string: link.url)!)
                        } label: {
                            Label(
                                title: {
                                    Text(link.title)
                                        .foregroundStyle(colorScheme == .light ? .black : .white)
                                },
                                icon: {
                                    Image(link.icon)
                                        .resizable()
                                        .frame(width: 30, height: 30, alignment: .center)
                                }
                            )
                        }
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

extension SettingsView {
    
}

#Preview {
    SettingsView()
}
