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
        HStack {
            if let faviconURL = URL(string: "\(passwordItem.url)/favicon.ico") {
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
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 1)
                .background(Color.white.cornerRadius(10))
        )
        .onTapGesture {
            // Handle tap gesture here
        }
    }
}

#Preview {
    PasswordCard(passwordItem: PasswordItem(
        name: "Google", username: "user@gmail.com", url: "https://www.google.com")
    )
}
