//
//  SettingsView.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 22/11/2023.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("silentKey") var silentValue = false
    @AppStorage("loudKey") var loudValue = false
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                Text("")
                    .navigationTitle("Settings")
                    .navigationBarTitleDisplayMode(.inline)
                
                Toggle("Silent Mode", isOn: $silentValue)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 2))
                    .disabled(loudValue == true)
                    .accessibilityHint("Turn on silent mode to stop sounds and haptics.")
                Text("Turn on silent mode to stop sounds and haptics.")
                    .font(.footnote)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundStyle(.gray)
                Toggle("Loud Mode", isOn: $loudValue)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 2))
                    .disabled(silentValue == true)
                    .accessibilityHint("Turn on loud mode for sound.")
                Text("Turn on loud mode for sound.")
                    .font(.footnote)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundStyle(.gray)
                
            }
            Spacer()
                .frame(height: 30)
            
            VStack(alignment: .center) {
                Text("Version 1.1.0 Siesta ©")
                    .font(.footnote)
            }
            
           
        }
    }
}

#Preview {
    SettingsView()
}
