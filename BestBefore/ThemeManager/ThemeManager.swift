//
//  ThemeManager.swift
//  BestBefore
//
//  Created by Khalid Asad on 11/10/19.
//  Copyright © 2019 Khalid Asad. All rights reserved.
//

import enum PlatformCommon.MaterialColor
import UIKit

struct ThemeManager {
    
    var isDarkModeEnabled: Bool = true
    
    // MARK: - Fonts
    var headerFont: UIFont {
        guard let font = UIFont(name: "Helvetica-Bold", size: 32) else { return UIFont.systemFont(ofSize: 32, weight: .bold)}
        return font
    }
    
    var subHeaderFont: UIFont {
        guard let font = UIFont(name: "Helvetica", size: 20) else { return UIFont.systemFont(ofSize: 20) }
        return font
    }
    
    var titleFont: UIFont {
        guard let font = UIFont(name: "Helvetica-Bold", size: 20) else { return UIFont.systemFont(ofSize: 20, weight: .bold)}
        return font
    }
    
    var subTitleFont: UIFont {
        guard let font = UIFont(name: "Helvetica", size: 16) else { return UIFont.systemFont(ofSize: 16)}
        return font
    }
    
    var smallTitleFont: UIFont {
        guard let font = UIFont(name: "Helvetica", size: 12) else { return UIFont.systemFont(ofSize: 12)}
        return font
    }
    
    // MARK: - Colors
    var darkColor: UIColor {
        MaterialColor.gray[.o800]
    }
    
    var lightColor: UIColor {
        .white
    }
    
    var primaryFontColor: UIColor {
        isDarkModeEnabled ? lightColor : darkColor
    }
    
    var secondaryFontColor: UIColor {
        isDarkModeEnabled ? darkColor : lightColor
    }
    
    var primaryBackgroundColor: UIColor {
        isDarkModeEnabled ? darkColor : lightColor
    }
    
    var secondaryBackgroundColor: UIColor {
        isDarkModeEnabled ? lightColor : darkColor
    }
    
    var imageTintColor: UIColor {
        isDarkModeEnabled ? lightColor : darkColor
    }
}
