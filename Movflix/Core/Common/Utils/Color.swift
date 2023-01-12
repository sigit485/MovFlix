//
//  Color.swift
//  Movflix
//
//  Created by Sigit on 11/01/23.
//

import UIKit

class Color {
    public static let shared = Color()
    
    public static func hexStringColor(hex: String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
    var redPrimary: UIColor {
        return Color.hexStringColor(hex: "#d00e14")
    }
    
    var textPlaceholder: UIColor {
        return Color.hexStringColor(hex: "#5E5E5E")
    }
    
}
