// Copyright (C) 2013 by Benjamin Gordon
//
// Permission is hereby granted, free of charge, to any
// person obtaining a copy of this software and
// associated documentation files (the "Software"), to
// deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge,
// publish, distribute, sublicense, and/or sell copies of the
// Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall
// be included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
// OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
// BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
// ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import Foundation
import UIKit

extension Colours: UIColor {
    // Enums
    enum ColorScheme {
        case Analagous, Monochromatic, Triad, Complementary
    }
    
    enum ColorFormulation {
        case RGBA, HSBA, LAB, CMYK
    }
    
    enum ColorDistance {
        case CIE76, CIE94, CIE2000
    }
    
    enum ColorComparison {
        case Darkness, Lightness, Desaturated, Saturated, Red, Green, Blue
    }
    
    
    // Color from Hex/RGBA/HSBA/CIE_LAB/CMYK
    class func colorFromHexString(hex: String) -> UIColor {
        
    }
    
    class func colorFromRBGA(rgba: Array<Double>) -> UIColor {
        
    }
    
    class func colorFromRBGA(rgba: Dictionary<String, Double>) -> UIColor {
        
    }
    
    class func colorFromHSBA(hsba: Array<Double>) -> UIColor {
        
    }
    
    class func colorFromHSBA(hsba: Dictionary<String, Double>) -> UIColor {
        
    }
    
    class func colorFromCIELab(cie: Array<Double>) -> UIColor {
        
    }
    
    class func colorFromCIELab(cie: Dictionary<String, Double>) -> UIColor {
        
    }
    
    class func colorFromCMYK(cmyk: Array<Double>) -> UIColor {
        
    }
    
    class func colorFromCMYK(cmyk: Dictionary<String, Double>) -> UIColor {
        
    }
    
    
    // Hex/RGBA/HSBA/CIE_LAB/CMYK from Color
    func hexString() -> String {
        
    }
    
    func rgba() -> Array<Double> {
        
    }
    
    func rgba() -> Dictionary<String, Double> {
        
    }
    
    func hsba() -> Array<Double> {
        
    }
    
    func hsba() -> Dictionary<String, Double> {
        
    }
    
    func CIELab() -> Array<Double> {
        
    }
    
    func CIELab() -> Dictionary<String, Double> {
        
    }
    
    func cmyk() -> Array<Double> {
        
    }
    
    func cmyk() -> Dictionary<String, Double> {
        
    }
    
    
    // Color Components
    func colorComponents() -> Dictionary<String, Double> {
        
    }
    
    func red() -> Double {
        
    }
    
    func green() -> Double {
        
    }
    
    func blue() -> Double {
        
    }
    
    func hue() -> Double {
        
    }
    
    func saturation() -> Double {
        
    }
    
    func brightness() -> Double {
        
    }
    
    func alpha() -> Double {
        
    }
    
    func CIE_Lightness() -> Double {
        
    }
    
    func CIE_a() -> Double {
        
    }
    
    func CIE_b() -> Double {
        
    }
    
    func cyan() -> Double {
        
    }
    
    func magenta() -> Double {
        
    }
    
    func yellow() -> Double {
        
    }
    
    func keyBlack() -> Double {
        
    }
    
    
    // 4 Color Scheme from Color
    func colorSchemeOfType(type: ColorScheme) -> Array<UIColor> {
        
    }
    
    
    // Contrasting Color
    func blackOrWhiteContrastingColor() -> UIColor {
        
    }
    
    
    // Complementary Color
    func complementaryColor() -> UIColor {
        
    }
    
    
    // Distance between Colors
    func distanceFromColor(color: UIColor) -> Double {
        
    }
    
    func distanceFromColor(color: UIColor, type t:ColorDistance) -> Double {
        
    }
    
    
    // Sort Colors
    class func sortColors(colors: Array<UIColor>, comparison c: ColorComparison) -> Array<UIColor> {
        
    }
    
    class func compareColors(colorA: UIColor, andColor colorB: UIColor, comparison c: ColorComparison) -> NSComparisonResult {
        
    }
    
    
    // Color Palette
    // System Colors
    class func infoBlueColor() -> UIColor { }
    class func successColor() -> UIColor { }
    class func warningColor() -> UIColor { }
    class func dangerColor() -> UIColor { }
    
    // Whites
    class func antiqueWhiteColor() -> UIColor { }
    class func oldLaceColor() -> UIColor { }
    class func ivoryColor() -> UIColor { }
    class func seashellColor() -> UIColor { }
    class func ghostWhiteColor() -> UIColor { }
    class func snowColor() -> UIColor { }
    class func linenColor() -> UIColor { }
    
    // Grays
    class func black25PercentColor() -> UIColor { }
    class func black50PercentColor() -> UIColor { }
    class func black75PercentColor() -> UIColor { }
    class func warmGrayColor() -> UIColor { }
    class func coolGrayColor() -> UIColor { }
    class func charcoalColor() -> UIColor { }
    
    // Blues
    class func tealColor() -> UIColor { }
    class func steelBlueColor() -> UIColor { }
    class func robinEggColor() -> UIColor { }
    class func pastelBlueColor() -> UIColor { }
    class func turquoiseColor() -> UIColor { }
    class func skyBlueColor() -> UIColor { }
    class func indigoColor() -> UIColor { }
    class func denimColor() -> UIColor { }
    class func blueberryColor() -> UIColor { }
    class func cornflowerColor() -> UIColor { }
    class func babyBlueColor() -> UIColor { }
    class func midnightBlueColor() -> UIColor { }
    class func fadedBlueColor() -> UIColor { }
    class func icebergColor() -> UIColor { }
    class func waveColor() -> UIColor { }
    
    // Greens
    class func emeraldColor() -> UIColor { }
    class func grassColor() -> UIColor { }
    class func pastelGreenColor() -> UIColor { }
    class func seafoamColor() -> UIColor { }
    class func paleGreenColor() -> UIColor { }
    class func cactusGreenColor() -> UIColor { }
    class func chartreuseColor() -> UIColor { }
    class func hollyGreenColor() -> UIColor { }
    class func oliveColor() -> UIColor { }
    class func oliveDrabColor() -> UIColor { }
    class func moneyGreenColor() -> UIColor { }
    class func honeydewColor() -> UIColor { }
    class func limeColor() -> UIColor { }
    class func cardTableColor() -> UIColor { }
    
    // Reds
    class func salmonColor() -> UIColor { }
    class func brickRedColor() -> UIColor { }
    class func easterPinkColor() -> UIColor { }
    class func grapefruitColor() -> UIColor { }
    class func pinkColor() -> UIColor { }
    class func indianRedColor() -> UIColor { }
    class func strawberryColor() -> UIColor { }
    class func coralColor() -> UIColor { }
    class func maroonColor() -> UIColor { }
    class func watermelonColor() -> UIColor { }
    class func tomatoColor() -> UIColor { }
    class func pinkLipstickColor() -> UIColor { }
    class func paleRoseColor() -> UIColor { }
    class func crimsonColor() -> UIColor { }
    
    // Purples
    class func eggplantColor() -> UIColor { }
    class func pastelPurpleColor() -> UIColor { }
    class func palePurpleColor() -> UIColor { }
    class func coolPurpleColor() -> UIColor { }
    class func violetColor() -> UIColor { }
    class func plumColor() -> UIColor { }
    class func lavenderColor() -> UIColor { }
    class func raspberryColor() -> UIColor { }
    class func fuschiaColor() -> UIColor { }
    class func grapeColor() -> UIColor { }
    class func periwinkleColor() -> UIColor { }
    class func orchidColor() -> UIColor { }
    
    // Yellows
    class func goldenrodColor() -> UIColor { }
    class func yellowGreenColor() -> UIColor { }
    class func bananaColor() -> UIColor { }
    class func mustardColor() -> UIColor { }
    class func buttermilkColor() -> UIColor { }
    class func goldColor() -> UIColor { }
    class func creamColor() -> UIColor { }
    class func lightCreamColor() -> UIColor { }
    class func wheatColor() -> UIColor { }
    class func beigeColor() -> UIColor { }
    
    // Oranges
    class func peachColor() -> UIColor { }
    class func burntOrangeColor() -> UIColor { }
    class func pastelOrangeColor() -> UIColor { }
    class func cantaloupeColor() -> UIColor { }
    class func carrotColor() -> UIColor { }
    class func mandarinColor() -> UIColor { }
    
    // Browns
    class func chiliPowderColor() -> UIColor { }
    class func burntSiennaColor() -> UIColor { }
    class func chocolateColor() -> UIColor { }
    class func coffeeColor() -> UIColor { }
    class func cinnamonColor() -> UIColor { }
    class func almondColor() -> UIColor { }
    class func eggshellColor() -> UIColor { }
    class func sandColor() -> UIColor { }
    class func mudColor() -> UIColor { }
    class func siennaColor() -> UIColor { }
    class func dustColor() -> UIColor { }
}