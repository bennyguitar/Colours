//
//  Colours.swift
//  ColoursDemo
//
//  Created by Ben Gordon on 12/27/14.
//  Copyright (c) 2014 Ben Gordon. All rights reserved.
//

import Foundation
#if os(iOS) || os(tvOS)
import UIKit
public typealias Color = UIColor
#else
import AppKit
public typealias Color = NSColor
#endif

public extension Color {
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
        var rgbInt: UInt64 = 0
        let newHex = hex.stringByReplacingOccurrencesOfString("#", withString: "")
        let scanner = NSScanner(string: newHex)
        scanner.scanHexLongLong(&rgbInt)
        let r: CGFloat = CGFloat((rgbInt & 0xFF0000) >> 16)/255.0
        let g: CGFloat = CGFloat((rgbInt & 0x00FF00) >> 8)/255.0
        let b: CGFloat = CGFloat(rgbInt & 0x0000FF)/255.0
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
        let R = X*3.2406 + (Y * -1.5372) + (Z * -0.4986)
        let G = (X * -0.9689) + Y*1.8758 + Z*0.0415
        let B = X*0.0557 + (Y * -0.2040) + Z*1.0570
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
        let deltaF: TransformBlock = { f in
            let transformation = (f > pow((6.0/29.0), 3.0)) ? pow(f, 1.0/3.0) : (1/3) * pow((29.0/6.0), 2.0) * f + 4/29.0
            
            return (transformation)
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
        let deltaR: TransformBlock = { R in
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
        let C = 1 - rgbaT.r
        let M = 1 - rgbaT.g
        let Y = 1 - rgbaT.b
        
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
        return modifiedColor(1.0 - percentage)
    }
    
    private func modifiedColor(percentage: CGFloat) -> Color {
        let hsbaT = hsba()
        return Color(hsba: (hsbaT.h, hsbaT.s, hsbaT.b * percentage, hsbaT.a))
    }
    
    
    // MARK: - Contrasting Color
    func blackOrWhiteContrastingColor() -> Color {
        let rgbaT = rgba()
        let value = 1 - ((0.299 * rgbaT.r) + (0.587 * rgbaT.g) + (0.114 * rgbaT.b));
        return value < 0.5 ? Color.blackColor() : Color.whiteColor()
    }
    
    
    // MARK: - Complementary Color
    func complementaryColor() -> Color {
        let hsbaT = hsba()
        let newH = Color.addDegree(180.0, staticDegree: hsbaT.h*360.0)
        return Color(hsba: (newH, hsbaT.s, hsbaT.b, hsbaT.a))
    }
    
    
    // MARK: - Color Scheme
    func colorScheme(type: ColorScheme) -> [Color] {
        switch (type) {
        case .Analagous:
            return Color.analgousColors(self.hsba())
        case .Monochromatic:
            return Color.monochromaticColors(self.hsba())
        case .Triad:
            return Color.triadColors(self.hsba())
        default:
            return Color.complementaryColors(self.hsba())
        }
    }
    
    private class func analgousColors(hsbaT: (h: CGFloat, s: CGFloat, b: CGFloat, a: CGFloat)) -> [Color] {
        return [Color(hsba: (self.addDegree(30, staticDegree: hsbaT.h*360)/360.0, hsbaT.s-0.05, hsbaT.b-0.1, hsbaT.a)),
                Color(hsba: (self.addDegree(15, staticDegree: hsbaT.h*360)/360.0, hsbaT.s-0.05, hsbaT.b-0.05, hsbaT.a)),
                Color(hsba: (self.addDegree(-15, staticDegree: hsbaT.h*360)/360.0, hsbaT.s-0.05, hsbaT.b-0.05, hsbaT.a)),
                Color(hsba: (self.addDegree(-30, staticDegree: hsbaT.h*360)/360.0, hsbaT.s-0.05, hsbaT.b-0.1, hsbaT.a))]
    }
    
    private class func monochromaticColors(hsbaT: (h: CGFloat, s: CGFloat, b: CGFloat, a: CGFloat)) -> [Color] {
        return [Color(hsba: (hsbaT.h, hsbaT.s/2, hsbaT.b/3, hsbaT.a)),
                Color(hsba: (hsbaT.h, hsbaT.s, hsbaT.b/2, hsbaT.a)),
                Color(hsba: (hsbaT.h, hsbaT.s/3, 2*hsbaT.b/3, hsbaT.a)),
                Color(hsba: (hsbaT.h, hsbaT.s, 4*hsbaT.b/5, hsbaT.a))]
    }
    
    private class func triadColors(hsbaT: (h: CGFloat, s: CGFloat, b: CGFloat, a: CGFloat)) -> [Color] {
        return [Color(hsba: (self.addDegree(120, staticDegree: hsbaT.h*360)/360.0, 2*hsbaT.s/3, hsbaT.b-0.05, hsbaT.a)),
                Color(hsba: (self.addDegree(120, staticDegree: hsbaT.h*360)/360.0, hsbaT.s, hsbaT.b, hsbaT.a)),
                Color(hsba: (self.addDegree(240, staticDegree: hsbaT.h*360)/360.0, hsbaT.s, hsbaT.b, hsbaT.a)),
                Color(hsba: (self.addDegree(240, staticDegree: hsbaT.h*360)/360.0, 2*hsbaT.s/3, hsbaT.b-0.05, hsbaT.a))]
    }
    
    private class func complementaryColors(hsbaT: (h: CGFloat, s: CGFloat, b: CGFloat, a: CGFloat)) -> [Color] {
        return [Color(hsba: (hsbaT.h, hsbaT.s, 4*hsbaT.b/5, hsbaT.a)),
                Color(hsba: (hsbaT.h, 5*hsbaT.s/7, hsbaT.b, hsbaT.a)),
                Color(hsba: (self.addDegree(180, staticDegree: hsbaT.h*360)/360.0, hsbaT.s, hsbaT.b, hsbaT.a)),
                Color(hsba: (self.addDegree(180, staticDegree: hsbaT.h*360)/360.0, 5*hsbaT.s/7, hsbaT.b, hsbaT.a))]
    }
    
    
    // MARK: - Predefined Colors
    // MARK: -
    // MARK: System Colors
    class func infoBlueColor() -> Color
    {
        return self.colorWith(47, G:112, B:225, A:1.0)
    }
    
    class func successColor() -> Color
    {
        return self.colorWith(83, G:215, B:106, A:1.0)
    }
    
    class func warningColor() -> Color
    {
        return self.colorWith(221, G:170, B:59, A:1.0)
    }
    
    class func dangerColor() -> Color
    {
        return self.colorWith(229, G:0, B:15, A:1.0)
    }
    
    
    // MARK: Whites
    class func antiqueWhiteColor() -> Color
    {
        return self.colorWith(250, G:235, B:215, A:1.0)
    }
    
    class func oldLaceColor() -> Color
    {
        return self.colorWith(253, G:245, B:230, A:1.0)
    }
    
    class func ivoryColor() -> Color
    {
        return self.colorWith(255, G:255, B:240, A:1.0)
    }
    
    class func seashellColor() -> Color
    {
        return self.colorWith(255, G:245, B:238, A:1.0)
    }
    
    class func ghostWhiteColor() -> Color
    {
        return self.colorWith(248, G:248, B:255, A:1.0)
    }
    
    class func snowColor() -> Color
    {
        return self.colorWith(255, G:250, B:250, A:1.0)
    }
    
    class func linenColor() -> Color
    {
        return self.colorWith(250, G:240, B:230, A:1.0)
    }
    
    
    // MARK: Grays
    class func black25PercentColor() -> Color
    {
        return Color(white:0.25, alpha:1.0)
    }
    
    class func black50PercentColor() -> Color
    {
        return Color(white:0.5,  alpha:1.0)
    }
    
    class func black75PercentColor() -> Color
    {
        return Color(white:0.75, alpha:1.0)
    }
    
    class func warmGrayColor() -> Color
    {
        return self.colorWith(133, G:117, B:112, A:1.0)
    }
    
    class func coolGrayColor() -> Color
    {
        return self.colorWith(118, G:122, B:133, A:1.0)
    }
    
    class func charcoalColor() -> Color
    {
        return self.colorWith(34, G:34, B:34, A:1.0)
    }
    
    
    // MARK: Blues
    class func tealColor() -> Color
    {
        return self.colorWith(28, G:160, B:170, A:1.0)
    }
    
    class func steelBlueColor() -> Color
    {
        return self.colorWith(103, G:153, B:170, A:1.0)
    }
    
    class func robinEggColor() -> Color
    {
        return self.colorWith(141, G:218, B:247, A:1.0)
    }
    
    class func pastelBlueColor() -> Color
    {
        return self.colorWith(99, G:161, B:247, A:1.0)
    }
    
    class func turquoiseColor() -> Color
    {
        return self.colorWith(112, G:219, B:219, A:1.0)
    }
    
    class func skyBlueColor() -> Color
    {
        return self.colorWith(0, G:178, B:238, A:1.0)
    }
    
    class func indigoColor() -> Color
    {
        return self.colorWith(13, G:79, B:139, A:1.0)
    }
    
    class func denimColor() -> Color
    {
        return self.colorWith(67, G:114, B:170, A:1.0)
    }
    
    class func blueberryColor() -> Color
    {
        return self.colorWith(89, G:113, B:173, A:1.0)
    }
    
    class func cornflowerColor() -> Color
    {
        return self.colorWith(100, G:149, B:237, A:1.0)
    }
    
    class func babyBlueColor() -> Color
    {
        return self.colorWith(190, G:220, B:230, A:1.0)
    }
    
    class func midnightBlueColor() -> Color
    {
        return self.colorWith(13, G:26, B:35, A:1.0)
    }
    
    class func fadedBlueColor() -> Color
    {
        return self.colorWith(23, G:137, B:155, A:1.0)
    }
    
    class func icebergColor() -> Color
    {
        return self.colorWith(200, G:213, B:219, A:1.0)
    }
    
    class func waveColor() -> Color
    {
        return self.colorWith(102, G:169, B:251, A:1.0)
    }
    
    
    // MARK: Greens
    class func emeraldColor() -> Color
    {
        return self.colorWith(1, G:152, B:117, A:1.0)
    }
    
    class func grassColor() -> Color
    {
        return self.colorWith(99, G:214, B:74, A:1.0)
    }
    
    class func pastelGreenColor() -> Color
    {
        return self.colorWith(126, G:242, B:124, A:1.0)
    }
    
    class func seafoamColor() -> Color
    {
        return self.colorWith(77, G:226, B:140, A:1.0)
    }
    
    class func paleGreenColor() -> Color
    {
        return self.colorWith(176, G:226, B:172, A:1.0)
    }
    
    class func cactusGreenColor() -> Color
    {
        return self.colorWith(99, G:111, B:87, A:1.0)
    }
    
    class func chartreuseColor() -> Color
    {
        return self.colorWith(69, G:139, B:0, A:1.0)
    }
    
    class func hollyGreenColor() -> Color
    {
        return self.colorWith(32, G:87, B:14, A:1.0)
    }
    
    class func oliveColor() -> Color
    {
        return self.colorWith(91, G:114, B:34, A:1.0)
    }
    
    class func oliveDrabColor() -> Color
    {
        return self.colorWith(107, G:142, B:35, A:1.0)
    }
    
    class func moneyGreenColor() -> Color
    {
        return self.colorWith(134, G:198, B:124, A:1.0)
    }
    
    class func honeydewColor() -> Color
    {
        return self.colorWith(216, G:255, B:231, A:1.0)
    }
    
    class func limeColor() -> Color
    {
        return self.colorWith(56, G:237, B:56, A:1.0)
    }
    
    class func cardTableColor() -> Color
    {
        return self.colorWith(87, G:121, B:107, A:1.0)
    }
    
    
    // MARK: Reds
    class func salmonColor() -> Color
    {
        return self.colorWith(233, G:87, B:95, A:1.0)
    }
    
    class func brickRedColor() -> Color
    {
        return self.colorWith(151, G:27, B:16, A:1.0)
    }
    
    class func easterPinkColor() -> Color
    {
        return self.colorWith(241, G:167, B:162, A:1.0)
    }
    
    class func grapefruitColor() -> Color
    {
        return self.colorWith(228, G:31, B:54, A:1.0)
    }
    
    class func pinkColor() -> Color
    {
        return self.colorWith(255, G:95, B:154, A:1.0)
    }
    
    class func indianRedColor() -> Color
    {
        return self.colorWith(205, G:92, B:92, A:1.0)
    }
    
    class func strawberryColor() -> Color
    {
        return self.colorWith(190, G:38, B:37, A:1.0)
    }
    
    class func coralColor() -> Color
    {
        return self.colorWith(240, G:128, B:128, A:1.0)
    }
    
    class func maroonColor() -> Color
    {
        return self.colorWith(80, G:4, B:28, A:1.0)
    }
    
    class func watermelonColor() -> Color
    {
        return self.colorWith(242, G:71, B:63, A:1.0)
    }
    
    class func tomatoColor() -> Color
    {
        return self.colorWith(255, G:99, B:71, A:1.0)
    }
    
    class func pinkLipstickColor() -> Color
    {
        return self.colorWith(255, G:105, B:180, A:1.0)
    }
    
    class func paleRoseColor() -> Color
    {
        return self.colorWith(255, G:228, B:225, A:1.0)
    }
    
    class func crimsonColor() -> Color
    {
        return self.colorWith(187, G:18, B:36, A:1.0)
    }
    
    
    // MARK: Purples
    class func eggplantColor() -> Color
    {
        return self.colorWith(105, G:5, B:98, A:1.0)
    }
    
    class func pastelPurpleColor() -> Color
    {
        return self.colorWith(207, G:100, B:235, A:1.0)
    }
    
    class func palePurpleColor() -> Color
    {
        return self.colorWith(229, G:180, B:235, A:1.0)
    }
    
    class func coolPurpleColor() -> Color
    {
        return self.colorWith(140, G:93, B:228, A:1.0)
    }
    
    class func violetColor() -> Color
    {
        return self.colorWith(191, G:95, B:255, A:1.0)
    }
    
    class func plumColor() -> Color
    {
        return self.colorWith(139, G:102, B:139, A:1.0)
    }
    
    class func lavenderColor() -> Color
    {
        return self.colorWith(204, G:153, B:204, A:1.0)
    }
    
    class func raspberryColor() -> Color
    {
        return self.colorWith(135, G:38, B:87, A:1.0)
    }
    
    class func fuschiaColor() -> Color
    {
        return self.colorWith(255, G:20, B:147, A:1.0)
    }
    
    class func grapeColor() -> Color
    {
        return self.colorWith(54, G:11, B:88, A:1.0)
    }
    
    class func periwinkleColor() -> Color
    {
        return self.colorWith(135, G:159, B:237, A:1.0)
    }
    
    class func orchidColor() -> Color
    {
        return self.colorWith(218, G:112, B:214, A:1.0)
    }
    
    
    // MARK: Yellows
    class func goldenrodColor() -> Color
    {
        return self.colorWith(215, G:170, B:51, A:1.0)
    }
    
    class func yellowGreenColor() -> Color
    {
        return self.colorWith(192, G:242, B:39, A:1.0)
    }
    
    class func bananaColor() -> Color
    {
        return self.colorWith(229, G:227, B:58, A:1.0)
    }
    
    class func mustardColor() -> Color
    {
        return self.colorWith(205, G:171, B:45, A:1.0)
    }
    
    class func buttermilkColor() -> Color
    {
        return self.colorWith(254, G:241, B:181, A:1.0)
    }
    
    class func goldColor() -> Color
    {
        return self.colorWith(139, G:117, B:18, A:1.0)
    }
    
    class func creamColor() -> Color
    {
        return self.colorWith(240, G:226, B:187, A:1.0)
    }
    
    class func lightCreamColor() -> Color
    {
        return self.colorWith(240, G:238, B:215, A:1.0)
    }
    
    class func wheatColor() -> Color
    {
        return self.colorWith(240, G:238, B:215, A:1.0)
    }
    
    class func beigeColor() -> Color
    {
        return self.colorWith(245, G:245, B:220, A:1.0)
    }
    
    
    // MARK: Oranges
    class func peachColor() -> Color
    {
        return self.colorWith(242, G:187, B:97, A:1.0)
    }
    
    class func burntOrangeColor() -> Color
    {
        return self.colorWith(184, G:102, B:37, A:1.0)
    }
    
    class func pastelOrangeColor() -> Color
    {
        return self.colorWith(248, G:197, B:143, A:1.0)
    }
    
    class func cantaloupeColor() -> Color
    {
        return self.colorWith(250, G:154, B:79, A:1.0)
    }
    
    class func carrotColor() -> Color
    {
        return self.colorWith(237, G:145, B:33, A:1.0)
    }
    
    class func mandarinColor() -> Color
    {
        return self.colorWith(247, G:145, B:55, A:1.0)
    }
    
    
    // MARK: Browns
    class func chiliPowderColor() -> Color
    {
        return self.colorWith(199, G:63, B:23, A:1.0)
    }
    
    class func burntSiennaColor() -> Color
    {
        return self.colorWith(138, G:54, B:15, A:1.0)
    }
    
    class func chocolateColor() -> Color
    {
        return self.colorWith(94, G:38, B:5, A:1.0)
    }
    
    class func coffeeColor() -> Color
    {
        return self.colorWith(141, G:60, B:15, A:1.0)
    }
    
    class func cinnamonColor() -> Color
    {
        return self.colorWith(123, G:63, B:9, A:1.0)
    }
    
    class func almondColor() -> Color
    {
        return self.colorWith(196, G:142, B:72, A:1.0)
    }
    
    class func eggshellColor() -> Color
    {
        return self.colorWith(252, G:230, B:201, A:1.0)
    }
    
    class func sandColor() -> Color
    {
        return self.colorWith(222, G:182, B:151, A:1.0)
    }
    
    class func mudColor() -> Color
    {
        return self.colorWith(70, G:45, B:29, A:1.0)
    }
    
    class func siennaColor() -> Color
    {
        return self.colorWith(160, G:82, B:45, A:1.0)
    }
    
    class func dustColor() -> Color
    {
        return self.colorWith(236, G:214, B:197, A:1.0)
    }

    
    // MARK: - Private Helpers
    private class func colorWith(R: CGFloat, G: CGFloat, B: CGFloat, A: CGFloat) -> Color {
        return Color(rgba: (R/255.0, G/255.0, B/255.0, A))
    }
    
    private class func addDegree(addDegree: CGFloat, staticDegree: CGFloat) -> CGFloat {
        let s = staticDegree + addDegree;
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
