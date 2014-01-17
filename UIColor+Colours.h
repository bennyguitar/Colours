//
//  UIColor+Colours.h
//  ColoursDemo
//
//  Created by Jesper on 4/4/13.
//  Copyright (c) 2013 Ben Gordon. All rights reserved.
//

#import <UIKit/UIKit.h>

// Color Scheme Creation Enum
typedef enum
{
    ColorSchemeAnalagous = 0,
    ColorSchemeMonochromatic,
    ColorSchemeTriad,
    ColorSchemeComplementary
	
} ColorScheme;

@interface UIColor (Colours)

#pragma mark - Color from Hex/RGBA/HSBA
/**
 Creates a UIColor from a Hex representation string
 @param hexString   Hex string that looks like @"#FF0000" or @"FF0000"
 @return    UIColor
 */
+ (UIColor *)colorFromHexString:(NSString *)hexString;

/**
 Creates a UIColor from an array of 4 NSNumbers (r,g,b,a)
 @param rgbaArray   4 NSNumbers for rgba between 0 - 1
 @return    UIColor
 */
+ (UIColor *)colorFromRGBAArray:(NSArray *)rgbaArray;

/**
 Creates a UIColor from a dictionary of 4 NSNumbers
 Keys: @"r",@"g",@"b",@"a"
 @param rgbaDictionary   4 NSNumbers for rgba between 0 - 1
 @return    UIColor
 */
+ (UIColor *)colorFromRGBADictionary:(NSDictionary *)rgbaDict;

/**
 Creates a UIColor from an array of 4 NSNumbers (h,s,b,a)
 @param hsbaArray   4 NSNumbers for rgba between 0 - 1
 @return    UIColor
 */
+ (UIColor *)colorFromHSBAArray:(NSArray *)hsbaArray;

/**
 Creates a UIColor from a dictionary of 4 NSNumbers
 Keys: @"h",@"s",@"b",@"a"
 @param hsbaDictionary   4 NSNumbers for rgba between 0 - 1
 @return    UIColor
 */
+ (UIColor *)colorFromHSBADictionary:(NSDictionary *)hsbaDict;


#pragma mark - Hex/RGBA/HSBA from Color
/**
 Creates a Hex representation from a UIColor
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
 Creates an NSArray of 4 UIColors that complement the UIColor.
 @param type ColorSchemeAnalagous, ColorSchemeMonochromatic, ColorSchemeTriad, ColorSchemeComplementary
 @return    NSArray
 */
- (NSArray *)colorSchemeOfType:(ColorScheme)type;


#pragma mark - Contrasting Color from Color
/**
 Creates either [UIColor whiteColor] or [UIColor blackColor] depending on if the color this method is run on is dark or light.
 @return    UIColor
 */
- (UIColor *)blackOrWhiteContrastingColor;


#pragma mark - Complementary Color
/**
 Creates a complementary color - a color directly opposite it on the color wheel.
 @return    UIColor
 */
- (UIColor *)complementaryColor;


#pragma mark - Colors
// System Colors
+ (UIColor *)infoBlueColor;
+ (UIColor *)successColor;
+ (UIColor *)warningColor;
+ (UIColor *)dangerColor;

// Whites
+ (UIColor *)antiqueWhiteColor;
+ (UIColor *)oldLaceColor;
+ (UIColor *)ivoryColor;
+ (UIColor *)seashellColor;
+ (UIColor *)ghostWhiteColor;
+ (UIColor *)snowColor;
+ (UIColor *)linenColor;

// Grays
+ (UIColor *)black25PercentColor;
+ (UIColor *)black50PercentColor;
+ (UIColor *)black75PercentColor;
+ (UIColor *)warmGrayColor;
+ (UIColor *)coolGrayColor;
+ (UIColor *)charcoalColor;

// Blues
+ (UIColor *)tealColor;
+ (UIColor *)steelBlueColor;
+ (UIColor *)robinEggColor;
+ (UIColor *)pastelBlueColor;
+ (UIColor *)turquoiseColor;
+ (UIColor *)skyBlueColor;
+ (UIColor *)indigoColor;
+ (UIColor *)denimColor;
+ (UIColor *)blueberryColor;
+ (UIColor *)cornflowerColor;
+ (UIColor *)babyBlueColor;
+ (UIColor *)midnightBlueColor;
+ (UIColor *)fadedBlueColor;
+ (UIColor *)icebergColor;
+ (UIColor *)waveColor;

// Greens
+ (UIColor *)emeraldColor;
+ (UIColor *)grassColor;
+ (UIColor *)pastelGreenColor;
+ (UIColor *)seafoamColor;
+ (UIColor *)paleGreenColor;
+ (UIColor *)cactusGreenColor;
+ (UIColor *)chartreuseColor;
+ (UIColor *)hollyGreenColor;
+ (UIColor *)oliveColor;
+ (UIColor *)oliveDrabColor;
+ (UIColor *)moneyGreenColor;
+ (UIColor *)honeydewColor;
+ (UIColor *)limeColor;
+ (UIColor *)cardTableColor;

// Reds
+ (UIColor *)salmonColor;
+ (UIColor *)brickRedColor;
+ (UIColor *)easterPinkColor;
+ (UIColor *)grapefruitColor;
+ (UIColor *)pinkColor;
+ (UIColor *)indianRedColor;
+ (UIColor *)strawberryColor;
+ (UIColor *)coralColor;
+ (UIColor *)maroonColor;
+ (UIColor *)watermelonColor;
+ (UIColor *)tomatoColor;
+ (UIColor *)pinkLipstickColor;
+ (UIColor *)paleRoseColor;
+ (UIColor *)crimsonColor;

// Purples
+ (UIColor *)eggplantColor;
+ (UIColor *)pastelPurpleColor;
+ (UIColor *)palePurpleColor;
+ (UIColor *)coolPurpleColor;
+ (UIColor *)violetColor;
+ (UIColor *)plumColor;
+ (UIColor *)lavenderColor;
+ (UIColor *)raspberryColor;
+ (UIColor *)fuschiaColor;
+ (UIColor *)grapeColor;
+ (UIColor *)periwinkleColor;
+ (UIColor *)orchidColor;

// Yellows
+ (UIColor *)goldenrodColor;
+ (UIColor *)yellowGreenColor;
+ (UIColor *)bananaColor;
+ (UIColor *)mustardColor;
+ (UIColor *)buttermilkColor;
+ (UIColor *)goldColor;
+ (UIColor *)creamColor;
+ (UIColor *)lightCreamColor;
+ (UIColor *)wheatColor;
+ (UIColor *)beigeColor;

// Oranges
+ (UIColor *)peachColor;
+ (UIColor *)burntOrangeColor;
+ (UIColor *)pastelOrangeColor;
+ (UIColor *)cantaloupeColor;
+ (UIColor *)carrotColor;
+ (UIColor *)mandarinColor;

// Browns
+ (UIColor *)chiliPowderColor;
+ (UIColor *)burntSiennaColor;
+ (UIColor *)chocolateColor;
+ (UIColor *)coffeeColor;
+ (UIColor *)cinnamonColor;
+ (UIColor *)almondColor;
+ (UIColor *)eggshellColor;
+ (UIColor *)sandColor;
+ (UIColor *)mudColor;
+ (UIColor *)siennaColor;
+ (UIColor *)dustColor;

@end
