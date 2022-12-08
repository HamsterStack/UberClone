//
//  Color.swift
//  UberClone
//
//  Created by Tom Miller on 05/12/2022.
//

import SwiftUI

extension ShapeStyle where Self==Color{
    static var darkGray: Color {
        Color(red: 66/255, green: 66/255, blue: 66/255)
    }
    
    static var lightGray: Color {
        Color(red: 90/255, green: 90/255, blue: 90/255)
    }
}

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let backgroundColor = Color("BackgroundColor")
    let secondaryBackgroundColor = Color("SecondaryBackgroundColor")
    let primaryTextColor = Color("PrimaryTextColor")
    let launchScreenTextColor = Color("LaunchScreenTextColor")
}
