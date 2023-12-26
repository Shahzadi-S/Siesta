//
//  SettingsView.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 22/11/2023.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.openURL) var openURL
    
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
                
                Section {
                    Button {
                        viewModel.requestReviewManually()
                    } label: {
                        Label(
                            title: {
                                Text(reviewLink.title)
                                    .foregroundStyle(colorScheme == .light ? .black : .white)
                            },
                            icon: {
                                Image(systemName: reviewLink.icon)
                            }
                        )
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
                            Text("All rights reserved.")
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
