//
//  SettingsButtonView.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 22/11/2023.
//

import SwiftUI

struct SettingsButtonView: View {
    var body: some View {
        VStack() {
            NavigationLink("SETTINGS", destination: SettingsView())
                .buttonStyle(RoundedButton(color: .blue, font: .title3))
        }
        .padding(20)
    }
}

#Preview {
    SettingsButtonView()
}
