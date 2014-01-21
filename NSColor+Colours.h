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


// Color Scheme Creation Enum
typedef enum
{
    ColorSchemeAnalagous = 0,
    ColorSchemeMonochromatic,
    ColorSchemeTriad,
    ColorSchemeComplementary
	
} ColorScheme;

@interface NSColor (Colours)

#pragma mark - Color from Hex/RGBA/HSBA
/**
 Creates a NSColor from a Hex representation string
 @param hexString   Hex string that looks like @"#FF0000" or @"FF0000"
 @return    NSColor
 */
+ (NSColor *)colorFromHexString:(NSString *)hexString;

/**
 Creates a NSColor from an array of 4 NSNumbers (r,g,b,a)
 @param rgbaArray   4 NSNumbers for rgba between 0 - 1
 @return    NSColor
 */
+ (NSColor *)colorFromRGBAArray:(NSArray *)rgbaArray;

/**
 Creates a NSColor from a dictionary of 4 NSNumbers
 Keys: @"r",@"g",@"b",@"a"
 @param rgbaDictionary   4 NSNumbers for rgba between 0 - 1
 @return    NSColor
 */
+ (NSColor *)colorFromRGBADictionary:(NSDictionary *)rgbaDict;

/**
 Creates a NSColor from an array of 4 NSNumbers (h,s,b,a)
 @param hsbaArray   4 NSNumbers for rgba between 0 - 1
 @return    NSColor
 */
+ (NSColor *)colorFromHSBAArray:(NSArray *)hsbaArray;

/**
 Creates a NSColor from a dictionary of 4 NSNumbers
 Keys: @"h",@"s",@"b",@"a"
 @param hsbaDictionary   4 NSNumbers for rgba between 0 - 1
 @return    NSColor
 */
+ (NSColor *)colorFromHSBADictionary:(NSDictionary *)hsbaDict;


#pragma mark - Hex/RGBA/HSBA from Color
/**
 Creates a Hex representation from a NSColor
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
 Creates an NSArray of 4 NSColors that complement the NSColor.
 @param type ColorSchemeAnalagous, ColorSchemeMonochromatic, ColorSchemeTriad, ColorSchemeComplementary
 @return    NSArray
 */
- (NSArray *)colorSchemeOfType:(ColorScheme)type;


#pragma mark - Contrasting Color from Color
/**
 Creates either [NSColor whiteColor] or [NSColor blackColor] depending on if the color this method is run on is dark or light.
 @return    NSColor
 */
- (NSColor *)blackOrWhiteContrastingColor;


#pragma mark - Complementary Color
/**
 Creates a complementary color - a color directly opposite it on the color wheel.
 @return    NSColor
 */
- (NSColor *)complementaryColor;


#pragma mark - Colors
// System Colors
+ (NSColor *)infoBlueColor;
+ (NSColor *)successColor;
+ (NSColor *)warningColor;
+ (NSColor *)dangerColor;

// Whites
+ (NSColor *)antiqueWhiteColor;
+ (NSColor *)oldLaceColor;
+ (NSColor *)ivoryColor;
+ (NSColor *)seashellColor;
+ (NSColor *)ghostWhiteColor;
+ (NSColor *)snowColor;
+ (NSColor *)linenColor;

// Grays
+ (NSColor *)black25PercentColor;
+ (NSColor *)black50PercentColor;
+ (NSColor *)black75PercentColor;
+ (NSColor *)warmGrayColor;
+ (NSColor *)coolGrayColor;
+ (NSColor *)charcoalColor;

// Blues
+ (NSColor *)tealColor;
+ (NSColor *)steelBlueColor;
+ (NSColor *)robinEggColor;
+ (NSColor *)pastelBlueColor;
+ (NSColor *)turquoiseColor;
+ (NSColor *)skyBlueColor;
+ (NSColor *)indigoColor;
+ (NSColor *)denimColor;
+ (NSColor *)blueberryColor;
+ (NSColor *)cornflowerColor;
+ (NSColor *)babyBlueColor;
+ (NSColor *)midnightBlueColor;
+ (NSColor *)fadedBlueColor;
+ (NSColor *)icebergColor;
+ (NSColor *)waveColor;

// Greens
+ (NSColor *)emeraldColor;
+ (NSColor *)grassColor;
+ (NSColor *)pastelGreenColor;
+ (NSColor *)seafoamColor;
+ (NSColor *)paleGreenColor;
+ (NSColor *)cactusGreenColor;
+ (NSColor *)chartreuseColor;
+ (NSColor *)hollyGreenColor;
+ (NSColor *)oliveColor;
+ (NSColor *)oliveDrabColor;
+ (NSColor *)moneyGreenColor;
+ (NSColor *)honeydewColor;
+ (NSColor *)limeColor;
+ (NSColor *)cardTableColor;

// Reds
+ (NSColor *)salmonColor;
+ (NSColor *)brickRedColor;
+ (NSColor *)easterPinkColor;
+ (NSColor *)grapefruitColor;
+ (NSColor *)pinkColor;
+ (NSColor *)indianRedColor;
+ (NSColor *)strawberryColor;
+ (NSColor *)coralColor;
+ (NSColor *)maroonColor;
+ (NSColor *)watermelonColor;
+ (NSColor *)tomatoColor;
+ (NSColor *)pinkLipstickColor;
+ (NSColor *)paleRoseColor;
+ (NSColor *)crimsonColor;

// Purples
+ (NSColor *)eggplantColor;
+ (NSColor *)pastelPurpleColor;
+ (NSColor *)palePurpleColor;
+ (NSColor *)coolPurpleColor;
+ (NSColor *)violetColor;
+ (NSColor *)plumColor;
+ (NSColor *)lavenderColor;
+ (NSColor *)raspberryColor;
+ (NSColor *)fuschiaColor;
+ (NSColor *)grapeColor;
+ (NSColor *)periwinkleColor;
+ (NSColor *)orchidColor;

// Yellows
+ (NSColor *)goldenrodColor;
+ (NSColor *)yellowGreenColor;
+ (NSColor *)bananaColor;
+ (NSColor *)mustardColor;
+ (NSColor *)buttermilkColor;
+ (NSColor *)goldColor;
+ (NSColor *)creamColor;
+ (NSColor *)lightCreamColor;
+ (NSColor *)wheatColor;
+ (NSColor *)beigeColor;

// Oranges
+ (NSColor *)peachColor;
+ (NSColor *)burntOrangeColor;
+ (NSColor *)pastelOrangeColor;
+ (NSColor *)cantaloupeColor;
+ (NSColor *)carrotColor;
+ (NSColor *)mandarinColor;

// Browns
+ (NSColor *)chiliPowderColor;
+ (NSColor *)burntSiennaColor;
+ (NSColor *)chocolateColor;
+ (NSColor *)coffeeColor;
+ (NSColor *)cinnamonColor;
+ (NSColor *)almondColor;
+ (NSColor *)eggshellColor;
+ (NSColor *)sandColor;
+ (NSColor *)mudColor;
+ (NSColor *)siennaColor;
+ (NSColor *)dustColor;

@end
