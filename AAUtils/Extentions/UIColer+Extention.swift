//
//  UIColerExtention.swift
//  ArrayOperations
//
//  Created by Ashish Awasthi on 20/12/20.
//  Copyright © 2020 Ashish Awasthi. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    func rgb(from hex: String)->(UInt8, UInt8, UInt8) {
        var cleanStr = hex.trimmingCharacters(in: .whitespaces).uppercased()
        if cleanStr.hasPrefix("#"), cleanStr.count != 6 {
            cleanStr.remove(at: cleanStr.startIndex)
            var rgb: UInt64 = 0
            Scanner.init(string: cleanStr).scanHexInt64(&rgb)
            
            let red = (rgb & 0xFF0000) >> 16
            let blue = (rgb &  0x00FF00) >> 8
            let green = (rgb &  0x0000FF) >> 0
            return (UInt8(red) ,UInt8(blue) ,UInt8(green))
        }
        return (0,0,0)
    }
    
    func colorFrom(_ hex: String) ->UIColor {
        let rgb = self.rgb(from: hex)
        let color = UIColor.init(red: CGFloat(rgb.0 / 0xFF), green: CGFloat(rgb.1 / 0xFF), blue: CGFloat(rgb.2 / 0xFF), alpha: 1.0)
        return color
    }
    
    func hex(from rgb:(UInt8, UInt8, UInt8)) ->String {
        let hexValue = String(format:"%02X", Int(rgb.0)) + String(format:"%02X", Int(rgb.1)) + String(format:"%02X", Int(rgb.2))
        return hexValue
    }
}


/* ===================== Test Result ==================
 
 let orangeColorHex = "#FF9300"
 let rgb = UIColor().rgb(from: orangeColorHex)
 print("Red:- \(rgb.0),Green:- \(rgb.1),Blue:- \(rgb.2)")
 let hexStr = UIColor().hex(from: rgb)
 print("hexStr:-\(hexStr)")
 
 Red:- 255,Green:- 147,Blue:- 0
 hexStr:-FF9300
 
 */


