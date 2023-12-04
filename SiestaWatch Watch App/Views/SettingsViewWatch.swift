//
//  SettingsViewWatch.swift
//  SiestaWatch Watch App
//
//  Created by Sanaa Shahzadi on 02/12/2023.
//

import SwiftUI

struct SettingsViewWatch: View {
    
    @AppStorage("vibrationsKey") var vibrationsValue = false
    @AppStorage("soundKey") var soundValue = false
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                Text("")
                    .navigationTitle("Settings")
                    .navigationBarTitleDisplayMode(.inline)
                
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
                Text("Version 1.0.0 Siesta ©")
                    .font(.footnote)
            }
            
           
        }
    }
}

#Preview {
    SettingsViewWatch()
}
