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
                Text("Turn on silent mode to stop sounds and haptics.")
                    .font(.footnote)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundStyle(.gray)
                Toggle("Loud Mode", isOn: $loudValue)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 2))
                    .disabled(silentValue == true)
                Text("Turn on loud mode for sound.")
                    .font(.footnote)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundStyle(.gray)
            }
        }
    }
}

#Preview {
    SettingsView()
}
