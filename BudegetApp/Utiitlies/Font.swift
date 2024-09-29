//
//  Font.swift
//  BudegetApp
//
//  Created by Mohamed Ali on 27/09/2024.
//


import SwiftUI

enum Fonts: String {
    case mainFontBold = "DMSans-Bold"
}

struct CustomFontModifier: ViewModifier {
    var fontName: Fonts
    var size: CGFloat

    func body(content: Content) -> some View {
        content
            .font(.custom(fontName.rawValue, size: size))
    }
}

extension View {
    
    func setFont(fontName: Fonts, size: CGFloat) -> some View {
        self.modifier(CustomFontModifier(fontName: fontName, size: size))
    }
}


extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}
