//
//  SettingsButtonViewWatch.swift
//  SiestaWatch Watch App
//
//  Created by Sanaa Shahzadi on 24/11/2023.
//

import SwiftUI

struct SettingsButtonViewWatch: View {
    var body: some View {
        VStack() {
            NavigationLink("Settings", destination: SettingsViewWatch())
                .padding()
                .tint(.blue)
        }
    }
}

#Preview {
    SettingsButtonViewWatch()
}
