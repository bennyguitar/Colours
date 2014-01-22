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

#include "TargetConditionals.h"

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#define ColorClass UIColor

#elif TARGET_OS_MAC
#import <UIKit/UIKit.h>
#define ColorClass UIColor

#else
#import <AppKit/AppKit.h>
#define ColorClass NSColor

#endif


// Color Scheme Generation Enum
typedef NS_ENUM(NSInteger, ColorScheme) {
    ColorSchemeAnalagous,
    ColorSchemeMonochromatic,
    ColorSchemeTriad,
    ColorSchemeComplementary
};


@interface ColorClass (Colours)


#pragma mark - Color from Hex/RGBA/HSBA
/**
 Creates a Color from a Hex representation string
 @param hexString   Hex string that looks like @"#FF0000" or @"FF0000"
 @return    Color
 */
+ (ColorClass *)colorFromHexString:(NSString *)hexString;

/**
 Creates a Color from an array of 4 NSNumbers (r,g,b,a)
 @param rgbaArray   4 NSNumbers for rgba between 0 - 1
 @return    Color
 */
+ (ColorClass *)colorFromRGBAArray:(NSArray *)rgbaArray;

/**
 Creates a Color from a dictionary of 4 NSNumbers
 Keys: @"r",@"g",@"b",@"a"
 @param rgbaDictionary   4 NSNumbers for rgba between 0 - 1
 @return    Color
 */
+ (ColorClass *)colorFromRGBADictionary:(NSDictionary *)rgbaDict;

/**
 Creates a Color from an array of 4 NSNumbers (h,s,b,a)
 @param hsbaArray   4 NSNumbers for rgba between 0 - 1
 @return    Color
 */
+ (ColorClass *)colorFromHSBAArray:(NSArray *)hsbaArray;

/**
 Creates a Color from a dictionary of 4 NSNumbers
 Keys: @"h",@"s",@"b",@"a"
 @param hsbaDictionary   4 NSNumbers for rgba between 0 - 1
 @return    Color
 */
+ (ColorClass *)colorFromHSBADictionary:(NSDictionary *)hsbaDict;


#pragma mark - Hex/RGBA/HSBA from Color
/**
 Creates a Hex representation from a Color
 @return    NSString
 */
- (NSString *)hexString;

/**
 Creates an array of 4 NSNumbers representing the float values of r, g, b, a in that order.
 @return    NSArray
 */
- (NSArray *)rgbaArray;

/**
 Creates an array of 4 NSNumbers representing the float values of h, s, b, a in that order.
 @return    NSArray
 */
- (NSArray *)hsbaArray;

/**
 Creates a dictionary of 4 NSNumbers representing float values with keys: "r", "g", "b", "a"
 @return    NSDictionary
 */
- (NSDictionary *)rgbaDictionary;

/**
 Creates a dictionary of 4 NSNumbers representing float values with keys: "h", "s", "b", "a"
 @return    NSDictionary
 */
- (NSDictionary *)hsbaDictionary;


#pragma mark - 4 Color Scheme from Color
/**
 Creates an NSArray of 4 Colors that complement the Color.
 @param type ColorSchemeAnalagous, ColorSchemeMonochromatic, ColorSchemeTriad, ColorSchemeComplementary
 @return    NSArray
 */
- (NSArray *)colorSchemeOfType:(ColorScheme)type;


#pragma mark - Contrasting Color from Color
/**
 Creates either [Color whiteColor] or [Color blackColor] depending on if the color this method is run on is dark or light.
 @return    Color
 */
- (ColorClass *)blackOrWhiteContrastingColor;


#pragma mark - Complementary Color
/**
 Creates a complementary color - a color directly opposite it on the color wheel.
 @return    Color
 */
- (ColorClass *)complementaryColor;


#pragma mark - Colors
// System Colors
+ (ColorClass *)infoBlueColor;
+ (ColorClass *)successColor;
+ (ColorClass *)warningColor;
+ (ColorClass *)dangerColor;

// Whites
+ (ColorClass *)antiqueWhiteColor;
+ (ColorClass *)oldLaceColor;
+ (ColorClass *)ivoryColor;
+ (ColorClass *)seashellColor;
+ (ColorClass *)ghostWhiteColor;
+ (ColorClass *)snowColor;
+ (ColorClass *)linenColor;

// Grays
+ (ColorClass *)black25PercentColor;
+ (ColorClass *)black50PercentColor;
+ (ColorClass *)black75PercentColor;
+ (ColorClass *)warmGrayColor;
+ (ColorClass *)coolGrayColor;
+ (ColorClass *)charcoalColor;

// Blues
+ (ColorClass *)tealColor;
+ (ColorClass *)steelBlueColor;
+ (ColorClass *)robinEggColor;
+ (ColorClass *)pastelBlueColor;
+ (ColorClass *)turquoiseColor;
+ (ColorClass *)skyBlueColor;
+ (ColorClass *)indigoColor;
+ (ColorClass *)denimColor;
+ (ColorClass *)blueberryColor;
+ (ColorClass *)cornflowerColor;
+ (ColorClass *)babyBlueColor;
+ (ColorClass *)midnightBlueColor;
+ (ColorClass *)fadedBlueColor;
+ (ColorClass *)icebergColor;
+ (ColorClass *)waveColor;

// Greens
+ (ColorClass *)emeraldColor;
+ (ColorClass *)grassColor;
+ (ColorClass *)pastelGreenColor;
+ (ColorClass *)seafoamColor;
+ (ColorClass *)paleGreenColor;
+ (ColorClass *)cactusGreenColor;
+ (ColorClass *)chartreuseColor;
+ (ColorClass *)hollyGreenColor;
+ (ColorClass *)oliveColor;
+ (ColorClass *)oliveDrabColor;
+ (ColorClass *)moneyGreenColor;
+ (ColorClass *)honeydewColor;
+ (ColorClass *)limeColor;
+ (ColorClass *)cardTableColor;

// Reds
+ (ColorClass *)salmonColor;
+ (ColorClass *)brickRedColor;
+ (ColorClass *)easterPinkColor;
+ (ColorClass *)grapefruitColor;
+ (ColorClass *)pinkColor;
+ (ColorClass *)indianRedColor;
+ (ColorClass *)strawberryColor;
+ (ColorClass *)coralColor;
+ (ColorClass *)maroonColor;
+ (ColorClass *)watermelonColor;
+ (ColorClass *)tomatoColor;
+ (ColorClass *)pinkLipstickColor;
+ (ColorClass *)paleRoseColor;
+ (ColorClass *)crimsonColor;

// Purples
+ (ColorClass *)eggplantColor;
+ (ColorClass *)pastelPurpleColor;
+ (ColorClass *)palePurpleColor;
+ (ColorClass *)coolPurpleColor;
+ (ColorClass *)violetColor;
+ (ColorClass *)plumColor;
+ (ColorClass *)lavenderColor;
+ (ColorClass *)raspberryColor;
+ (ColorClass *)fuschiaColor;
+ (ColorClass *)grapeColor;
+ (ColorClass *)periwinkleColor;
+ (ColorClass *)orchidColor;

// Yellows
+ (ColorClass *)goldenrodColor;
+ (ColorClass *)yellowGreenColor;
+ (ColorClass *)bananaColor;
+ (ColorClass *)mustardColor;
+ (ColorClass *)buttermilkColor;
+ (ColorClass *)goldColor;
+ (ColorClass *)creamColor;
+ (ColorClass *)lightCreamColor;
+ (ColorClass *)wheatColor;
+ (ColorClass *)beigeColor;

// Oranges
+ (ColorClass *)peachColor;
+ (ColorClass *)burntOrangeColor;
+ (ColorClass *)pastelOrangeColor;
+ (ColorClass *)cantaloupeColor;
+ (ColorClass *)carrotColor;
+ (ColorClass *)mandarinColor;

// Browns
+ (ColorClass *)chiliPowderColor;
+ (ColorClass *)burntSiennaColor;
+ (ColorClass *)chocolateColor;
+ (ColorClass *)coffeeColor;
+ (ColorClass *)cinnamonColor;
+ (ColorClass *)almondColor;
+ (ColorClass *)eggshellColor;
+ (ColorClass *)sandColor;
+ (ColorClass *)mudColor;
+ (ColorClass *)siennaColor;
+ (ColorClass *)dustColor;

@end
