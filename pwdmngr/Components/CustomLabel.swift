//
//  CustomLabel.swift
//  pwdmngr
//
//  Created by Luka Kuterovac on 04.06.2024..
//

import SwiftUI

struct CustomLabel: View {
    let title: String
    let systemImage: String
    let font: Font
    
    var body: some View {
        VStack {
            Image(systemName: systemImage)
            Text(title)
                .font(font)
        }
    }
}

#Preview {
    CustomLabel(title: "pwdmngr",
                systemImage: "",
                font: .customFont(font: .lato, style: .regular)
    )
}
