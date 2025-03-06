//
//  ExitGameAlertView.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 24/02/2025.
//

import SwiftUI

struct ExitGameAlertView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var showingAlert = false

    var body: some View {
            Button (action: {
                showingAlert = true
            }, label: {
                Image(systemName: "figure.walk.departure")
            })
            .alert(Text("Are you sure you want to exit?"),
                   isPresented: $showingAlert
            ) {
                Button(role: .destructive) {
                    self.presentationMode.wrappedValue.dismiss()
                    viewModel.endGame()
                } label: {
                    Text("Exit")
                }
                Button(role: .cancel) { } label: {
                    Text("Cancel")
                }
            } message: {
                Text("You will lose all progress.")
            }
            .accessibilityLabel("Tap to Exit")
    }
}

#Preview {
    ExitGameAlertView().environmentObject(ViewModel())
}
