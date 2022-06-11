//
//  UIColor+Extension.swift
//  swifty-companion
//
//  Created by Корогодова Мария Михайловна on 20.05.2022.
//

import UIKit

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0,
                  green: CGFloat(green) / 255.0,
                  blue: CGFloat(blue) / 255.0,
                  alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        
        self.init(red: (rgb >> 16) & 0xFF, green: (rgb >> 8) & 0xFF, blue: rgb & 0xFF)
    }
}

extension UIColor {
    
    static let capybara = UIColor(rgb: 0xB71C1C)
    static let alpaca = UIColor(rgb: 0x6BC352)
    static let honey = UIColor(rgb: 0x52A4C3)
    static let salamander = UIColor(rgb: 0xAA52C3)
    static let event = UIColor(rgb: 0x00BABC)
    

    static let grey = UIColor(rgb: 0x464646)
}
