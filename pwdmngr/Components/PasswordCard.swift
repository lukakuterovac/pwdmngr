//
//  PasswordCard.swift
//  pwdmngr
//
//  Created by Luka Kuterovac on 04.06.2024..
//

import SwiftUI

struct PasswordCard: View {
    let passwordItem: PasswordItem
    
    var body: some View {
        let faviconURL = "\(passwordItem.url)/favicon.ico"
        
        HStack {
            if let faviconURL = URL(string: faviconURL) {
                AsyncImage(url: faviconURL) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                } placeholder: {
                    Image(systemName: "globe")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                }
            } else {
                Image(systemName: "globe")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
            }
            
            VStack(alignment: .leading) {
                Text(passwordItem.name)
                    .font(.customFont(font: .lato, style: .regular, size: 18))
                Text(passwordItem.username)
                    .font(.customFont(font: .lato, style: .regular, size: 14))
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding()
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.secondary, lineWidth: 1)
        )
    }
}

#Preview {
    PasswordCard(passwordItem: PasswordItem.createMockPasswordItem())
}
