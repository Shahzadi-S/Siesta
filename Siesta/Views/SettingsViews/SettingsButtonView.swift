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
            NavigationLink(destination: SettingsView()) {
                Image(systemName: "gear")
                    .tint(.secondary)
                    .font(.system(size: 25))
                    .frame(width: 44, height: 44)
            }
        }
        .padding(20)
    }
}

#Preview {
    SettingsButtonView()
}
