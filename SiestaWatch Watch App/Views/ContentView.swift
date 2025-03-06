//
//  ContentView.swift
//  SiestaWatch Watch App
//
//  Created by Sanaa Shahzadi on 22/11/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            StartButtonViewWatch()
        }
    }
}

#Preview {
    ContentView().environmentObject(ViewModel())
}
