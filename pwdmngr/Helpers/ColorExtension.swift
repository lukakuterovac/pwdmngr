//
//  ColorExtension.swift
//  pwdmngr
//
//  Created by Luka Kuterovac on 30.06.2024..
//

import Foundation
import SwiftUI

extension Color {
    static func random() -> Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
