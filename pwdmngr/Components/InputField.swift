//
//  InputField.swift
//  pwdmngr
//
//  Created by Luka Kuterovac on 29.06.2024..
//

import SwiftUI

struct InputField: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureField: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.footnote)
                .fontWeight(.semibold)
            if isSecureField {
                SecureField(placeholder, text: $text)
                    .font(.system(size: 14))
                    .padding(10)
                    .background((Color(UIColor { traitCollection in
                        traitCollection.userInterfaceStyle == .dark ? UIColor.secondarySystemBackground : UIColor.systemBackground
                    })))                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.systemGray4), lineWidth: 0)
                    )
            } else {
                TextField(placeholder, text: $text)
                    .font(.system(size: 14))
                    .padding(10)
                    .background((Color(UIColor { traitCollection in
                        traitCollection.userInterfaceStyle == .dark ? UIColor.secondarySystemBackground : UIColor.systemBackground
                    })))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.systemGray4), lineWidth: 0)
                    )
            }
        }
        .padding(.vertical, 6)
    }
}

#Preview {
    InputField(text: Binding.constant(""), title: "Input", placeholder: "Example")
}
