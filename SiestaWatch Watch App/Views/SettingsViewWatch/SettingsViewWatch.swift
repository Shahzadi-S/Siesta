//
//  SettingsViewWatch.swift
//  SiestaWatch Watch App
//
//  Created by Sanaa Shahzadi on 02/12/2023.
//

import SwiftUI

struct SettingsViewWatch: View {
    @AppStorage("vibrationsKey") var vibrationsValue = true
    @AppStorage("soundKey") var soundValue = true
    
    var body: some View {
        VStack {
            Text("Settings")
                .font(.callout)
                .fontDesign(.monospaced)
                .fontWeight(.bold)
                .padding(.top, -10)
            Spacer()
            VStack(alignment: .leading) {
                Toggle("Vibrations", isOn: $vibrationsValue)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 2))
                    .accessibilityHint("Turn vibrations on or off.")
                    .onChange(of: vibrationsValue) { oldValue, newValue in
                        if newValue == false {
                            soundValue = false
                        }
                    }
                
                Toggle("Sound", isOn: $soundValue)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 2))
                    .accessibilityHint("Turn on for sound and vibrations.")
                    .onChange(of: soundValue) { oldValue, newValue in
                        if newValue == true {
                            vibrationsValue = true
                        }
                    }
            }
            Spacer()
                .frame(height: 30)
            
            VStack(alignment: .center) {
                Text("Siesta © v2.0.0")
                    .font(.footnote)
                Text("Sanaa Shahzadi")
                    .font(.footnote)
                Text("All rights reserved")
                    .font(.footnote)
            }
        }
    }
}

#Preview {
    SettingsViewWatch()
}
