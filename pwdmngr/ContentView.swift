//
//  ContentView.swift
//  pwdmngr
//
//  Created by Luka Kuterovac on 03.06.2024..
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("pwdmngr")
                .font(.customFont(font: .lato, style: .regular, size: .h0))
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
