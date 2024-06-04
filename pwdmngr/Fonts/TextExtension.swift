//
//  TextExtension.swift
//  pwdmngr
//
//  Created by Luka Kuterovac on 03.06.2024..
//

import SwiftUI

extension Font {
    
    /// Choose your font to set up
    /// - Parameters:
    ///   - font: Choose one of your font
    ///   - style: Make sure the style is available
    ///   - size: Use prepared sizes for your app
    ///   - isScaled: Check if your app accessibility prepared
    /// - Returns: Font ready to show
    static func customFont(
        font: CustomFonts,
        style: CustomFontStyle,
        size: CustomFontSize,
        isScaled: Bool = true
    ) -> Font {
        return customFont(font: font, style: style, size: size.rawValue, isScaled: isScaled)
    }
    
    /// Choose your font to set up
    /// - Parameters:
    ///   - font: Choose one of your font
    ///   - style: Make sure the style is available
    ///   - size: Use prepared sizes for your app
    ///   - isScaled: Check if your app accessibility prepared
    /// - Returns: Font ready to show
    static func customFont(
        font: CustomFonts,
        style: CustomFontStyle,
        size: CGFloat = 16,
        isScaled: Bool = true
    ) -> Font {
        let fontName: String = font.rawValue + style.rawValue
        
        if isScaled {
            return Font.custom(fontName, size: size, relativeTo: .body)
        } else {
            return Font.custom(fontName, size: size)
        }
    }
}
