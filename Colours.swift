//
//  Colours.swift
//  ColoursDemo
//
//  Created by Ben Gordon on 12/27/14.
//  Copyright (c) 2014 Ben Gordon. All rights reserved.
//

import Foundation
#if os(iOS)
import UIKit
public typealias Color = UIColor
#else
import AppKit
public typealias Color = NSColor
#endif

extension Color {
    // MARK: - Closure
    typealias TransformBlock = CGFloat -> CGFloat
    
    // MARK: - Enums
    enum ColorScheme:Int {
        case Analagous = 0, Monochromatic, Triad, Complementary
    }
    
    enum ColorFormulation:Int {
        case RGBA = 0, HSBA, LAB, CMYK
    }
    
    enum ColorDistance:Int {
        case CIE76 = 0, CIE94, CIE2000
    }
    
    enum ColorComparison:Int {
        case Darkness = 0, Lightness, Desaturated, Saturated, Red, Green, Blue
    }
    
    
    // MARK: - Color from Hex/RGBA/HSBA/CIE_LAB/CMYK
    convenience init(hex: String) {
        var rgbInt: Int32 = 0
        var scanner = NSScanner(string: hex)
        scanner.scanInt(&rgbInt)
        let r: CGFloat = CGFloat(((rgbInt & 0xFF0000) >> 16))/255.0
        let g: CGFloat = CGFloat(((rgbInt & 0xFF00) >> 8))/255.0
        let b: CGFloat = CGFloat((rgbInt & 0xFF))/255.0
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    convenience init(rgba: (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat)) {
        self.init(red: rgba.r, green: rgba.g, blue: rgba.b, alpha: rgba.a)
    }
    
    convenience init(hsba: (h: CGFloat, s: CGFloat, b: CGFloat, a: CGFloat)) {
        self.init(hue: hsba.h, saturation: hsba.s, brightness: hsba.b, alpha: hsba.a)
    }
    
    convenience init(CIE_LAB: (l: CGFloat, a: CGFloat, b: CGFloat, alpha: CGFloat)) {
        // Set Up
        var Y = (CIE_LAB.l + 16.0)/116.0
        var X = CIE_LAB.a/500 + Y
        var Z = Y - CIE_LAB.b/200
        
        // Transform XYZ
        let deltaXYZ: TransformBlock = { k in
            return (pow(k, 3.0) > 0.008856) ? pow(k, 3.0) : (k - 4/29.0)/7.787
        }
        X = deltaXYZ(X)*0.95047
        Y = deltaXYZ(Y)*1.000
        Z = deltaXYZ(Z)*1.08883
        
        // Convert XYZ to RGB
        var R = X*3.2406 + (Y * -1.5372) + (Z * -0.4986)
        var G = (X * -0.9689) + Y*1.8758 + Z*0.0415
        var B = X*0.0557 + (Y * -0.2040) + Z*1.0570
        let deltaRGB: TransformBlock = { k in
            return (k > 0.0031308) ? 1.055 * (pow(k, (1/2.4))) - 0.055 : k * 12.92
        }
        
        self.init(rgba: (deltaRGB(R), deltaRGB(G), deltaRGB(B), CIE_LAB.alpha))
    }
    
    convenience init(cmyk: (c: CGFloat, m: CGFloat, y: CGFloat, k: CGFloat)) {
        let cmyTransform: TransformBlock = { x in
            return x * (1 - cmyk.k) + cmyk.k
        }
        let C = cmyTransform(cmyk.c)
        let M = cmyTransform(cmyk.m)
        let Y = cmyTransform(cmyk.y)
        self.init(rgba: (1 - C, 1 - M, 1 - Y, 1.0))
    }
    
    
    // MARK: - Color to Hex/RGBA/HSBA/CIE_LAB/CMYK
    func hexString() -> String {
        let rgbaT = rgba()
        let r: Int = Int(rgbaT.r * 255)
        let g: Int = Int(rgbaT.g * 255)
        let b: Int = Int(rgbaT.b * 255)
        let red = NSString(format: "%02x", r)
        let green = NSString(format: "%02x", g)
        let blue = NSString(format: "%02x", b)
        return "#\(red)\(green)\(blue)"
    }
    
    func rgba() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        if self.respondsToSelector("getRed:green:blue:alpha:") {
            self.getRed(&r, green: &g, blue: &b, alpha: &a)
        } else {
            let components = CGColorGetComponents(self.CGColor)
            r = components[0]
            g = components[1]
            b = components[2]
            a = components[3]
        }
        
        return (r, g, b, a)
    }
    
    func hsba() -> (h: CGFloat, s: CGFloat, b: CGFloat, a: CGFloat) {
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        if self.respondsToSelector("getHue:saturation:brightness:alpha:") {
            self.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        }
        
        return (h, s, b, a)
    }
    
    func CIE_LAB() -> (l: CGFloat, a: CGFloat, b: CGFloat, alpha: CGFloat) {
        // Get XYZ
        let xyzT = xyz()
        let x = xyzT.x/95.047
        let y = xyzT.y/100.000
        let z = xyzT.z/108.883
        
        // Transfrom XYZ to L*a*b
        var deltaF: TransformBlock = { f in
            return (f > pow((6.0/29.0), 3.0)) ? pow(f, 1.0/3.0) : (1/3)*pow((29.0/6.0), 2.0) * f + 4/29.0
        }
        let X = deltaF(x)
        let Y = deltaF(y)
        let Z = deltaF(z)
        let L = 116*Y - 16
        let a = 500 * (X - Y)
        let b = 200 * (Y - Z)
        
        return (L, a, b, xyzT.alpha)
    }
    
    func xyz() -> (x: CGFloat, y: CGFloat, z: CGFloat, alpha: CGFloat) {
        // Get RGBA values
        let rgbaT = rgba()

        // Transfrom values to XYZ
        var deltaR: TransformBlock = { R in
            return (R > 0.04045) ? pow((R + 0.055)/1.055, 2.40) : (R/12.92)
        }
        let R = deltaR(rgbaT.r)
        let G = deltaR(rgbaT.g)
        let B = deltaR(rgbaT.b)
        let X = (R*41.24 + G*35.76 + B*18.05)
        let Y = (R*21.26 + G*71.52 + B*7.22)
        let Z = (R*1.93 + G*11.92 + B*95.05)
        
        return (X, Y, Z, rgbaT.a)
    }
    
    func cmyk() -> (c: CGFloat, m: CGFloat, y: CGFloat, k: CGFloat) {
        // Convert RGB to CMY
        let rgbaT = rgba()
        var C = 1 - rgbaT.r
        var M = 1 - rgbaT.g
        var Y = 1 - rgbaT.b
        
        // Find K
        let K = min(1, min(C, min(Y, M)))
        if (K == 1) {
            return (0, 0, 0, 1)
        }
        
        // Convert cmyk
        let newCMYK: TransformBlock = { x in
            return (x - K)/(1 - K)
        }
        return (newCMYK(C), newCMYK(M), newCMYK(Y), K)
    }
    
    
    // MARK: - Color Components
    func red() -> CGFloat {
        return rgba().r
    }
    
    func green() -> CGFloat {
        return rgba().g
    }
    
    func blue() -> CGFloat {
        return rgba().b
    }
    
    func alpha() -> CGFloat {
        return rgba().a
    }
    
    func hue() -> CGFloat {
        return hsba().h
    }
    
    func saturation() -> CGFloat {
        return hsba().s
    }
    
    func brightness() -> CGFloat {
        return hsba().b
    }
    
    func CIE_Lightness() -> CGFloat {
        return CIE_LAB().l
    }
    
    func CIE_a() -> CGFloat {
        return CIE_LAB().a
    }
    
    func CIE_b() -> CGFloat {
        return CIE_LAB().b
    }
    
    func cyan() -> CGFloat {
        return cmyk().c
    }
    
    func magenta() -> CGFloat {
        return cmyk().m
    }
    
    func yellow() -> CGFloat {
        return cmyk().y
    }
    
    func keyBlack() -> CGFloat {
        return cmyk().k
    }
    
    
    // MARK: - Lighten/Darken Color
    func lightenedColor(percentage: CGFloat) -> Color {
        return modifiedColor(percentage + 1.0)
    }
    
    func darkenedColor(percentage: CGFloat) -> Color {
        return modifiedColor(percentage)
    }
    
    private func modifiedColor(percentage: CGFloat) -> Color {
        let hsbaT = hsba()
        return Color(hsba: (hsbaT.h, hsbaT.s, hsbaT.b * percentage, hsbaT.a))
    }
    
    
    // MARK: - Contrasting Color
    func blackOrWhiteContrastingColor() -> Color {
        let rgbaT = rgba()
        let value = 1 - ((0.299 * rgbaT.r) + (0.587 * rgbaT.g) + (0.114 * rgbaT.b));
        return value > 0.5 ? Color.blackColor() : Color.whiteColor()
    }
    
    
    // MARK: - Complementary Color
    func complementaryColor() -> Color {
        let hsbaT = hsba()
        let newH = Color.addDegree(180.0, staticDegree: hsbaT.h*360.0)
        return Color(hsba: (newH, hsbaT.s, hsbaT.b, hsbaT.a))
    }
    
    
    // MARK: - Private Helpers
    private class func addDegree(addDegree: CGFloat, staticDegree: CGFloat) -> CGFloat {
        var s = staticDegree + addDegree;
        if (s > 360) {
            return s - 360;
        }
        else if (s < 0) {
            return -1 * s;
        }
        else {
            return s;
        }
    }
}