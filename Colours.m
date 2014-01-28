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

#import "Colours.h"

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
@implementation UIColor (Colours)

#elif TARGET_OS_MAC
#import <AppKit/AppKit.h>
@implementation NSColor (Colours)

#endif

#pragma mark Color from Hex
+ (instancetype)colorFromHexString:(NSString *)hexString
{
    unsigned rgbValue = 0;
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
	
    [scanner scanHexInt:&rgbValue];
	
    return [[self class] colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}


#pragma mark - Hex from Color
- (NSString *)hexString
{
    NSArray *colorArray	= [self rgbaArray];
    int r = [colorArray[0] floatValue] * 255;
    int g = [colorArray[1] floatValue] * 255;
    int b = [colorArray[2] floatValue] * 255;
    NSString *red = [NSString stringWithFormat:@"%02x", r];
    NSString *green = [NSString stringWithFormat:@"%02x", g];
    NSString *blue = [NSString stringWithFormat:@"%02x", b];
	
    return [NSString stringWithFormat:@"#%@%@%@", red, green, blue];
}


#pragma mark Color from RGBA
+ (instancetype)colorFromRGBAArray:(NSArray *)rgbaArray
{
    if (rgbaArray.count < 4) {
        return [[self class] clearColor];
    }
    // Takes an array of RGBA float's as NSNumbers, and makes a [self class] (shorthand colorWithRed:Green:Blue:Alpha:
    return [[self class] colorWithRed:[rgbaArray[0] floatValue] green:[rgbaArray[1] floatValue] blue:[rgbaArray[2] floatValue] alpha:[rgbaArray[3] floatValue]];
}

+ (instancetype)colorFromRGBADictionary:(NSDictionary *)rgbaDict
{
    if (rgbaDict[@"r"] && rgbaDict[@"g"] && rgbaDict[@"b"] && rgbaDict[@"a"]) {
        return [[self class] colorWithRed:[rgbaDict[@"r"] floatValue] green:[rgbaDict[@"g"] floatValue] blue:[rgbaDict[@"b"] floatValue] alpha:[rgbaDict[@"a"] floatValue]];
    }
    
    return [[self class] clearColor];
}


#pragma mark - RGBA from Color
- (NSArray *)rgbaArray
{
    // Takes a [self class] and returns R,G,B,A values in NSNumber form
    CGFloat r=0,g=0,b=0,a=0;
    
    if ([self respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [self getRed:&r green:&g blue:&b alpha:&a];
    }
    else {
        const CGFloat *components = CGColorGetComponents(self.CGColor);
        r = components[0];
        g = components[1];
        b = components[2];
        a = components[3];
    }
    return @[@(r),
             @(g),
             @(b), 
             @(a)];
}

- (NSDictionary *)rgbaDictionary
{
    // Takes [self class] and returns RGBA values in a dictionary as NSNumbers
    CGFloat r=0,g=0,b=0,a=0;
    if ([self respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [self getRed:&r green:&g blue:&b alpha:&a];
    }
    else {
        const CGFloat *components = CGColorGetComponents(self.CGColor);
        r = components[0];
        g = components[1];
        b = components[2];
        a = components[3];
    }
    
    return @{@"r":@(r),
             @"g":@(g),
             @"b":@(b),
             @"a":@(a)};
}


#pragma mark - HSBA from Color
- (NSArray *)hsbaArray
{
    // Takes a [self class] and returns Hue,Saturation,Brightness,Alpha values in NSNumber form
    CGFloat h=0,s=0,b=0,a=0;
    
    if ([self respondsToSelector:@selector(getHue:saturation:brightness:alpha:)]) {
        [self getHue:&h saturation:&s brightness:&b alpha:&a];
    }
    
    return @[@(h),
             @(s),
             @(b), 
             @(a)];
}

- (NSDictionary *)hsbaDictionary
{
    // Takes a [self class] and returns Hue,Saturation,Brightness,Alpha values in NSNumber form
    CGFloat h=0,s=0,b=0,a=0;
    
    if ([self respondsToSelector:@selector(getHue:saturation:brightness:alpha:)]) {
        [self getHue:&h saturation:&s brightness:&b alpha:&a];
    }
    
    return @{@"h":@(h),
             @"s":@(s),
             @"b":@(b),
             @"a":@(a)};
}


#pragma mark Color from HSBA
+ (instancetype)colorFromHSBAArray:(NSArray *)hsbaArray
{
    if (hsbaArray.count < 4) {
        return [[self class] clearColor];
    }
    
    return [[self class] colorWithHue:[hsbaArray[0] doubleValue] saturation:[hsbaArray[1] doubleValue] brightness:[hsbaArray[2] doubleValue] alpha:[hsbaArray[3] doubleValue]];
}

+ (instancetype)colorFromHSBADictionary:(NSDictionary *)hsbaDict
{
    if (hsbaDict[@"h"] && hsbaDict[@"s"] && hsbaDict[@"b"] && hsbaDict[@"a"]) {
        return [[self class] colorWithHue:[hsbaDict[@"h"] doubleValue] saturation:[hsbaDict[@"s"] doubleValue] brightness:[hsbaDict[@"b"] doubleValue] alpha:[hsbaDict[@"a"] doubleValue]];
    }
    
    return [[self class] clearColor];
}


#pragma mark - Generate Color Scheme
- (NSArray *)colorSchemeOfType:(ColorScheme)type
{
    NSArray *hsbArray = [self hsbaArray];
    float hue = [hsbArray[0] floatValue] * 360;
    float sat = [hsbArray[1] floatValue] * 100;
    float bright = [hsbArray[2] floatValue] * 100;
    float alpha = [hsbArray[3] floatValue];
    
    switch (type) {
        case ColorSchemeAnalagous:
            return [[self class] analagousColorsFromHue:hue saturation:sat brightness:bright alpha:alpha];
        case ColorSchemeMonochromatic:
            return [[self class] monochromaticColorsFromHue:hue saturation:sat brightness:bright alpha:alpha];
        case ColorSchemeTriad:
            return [[self class] triadColorsFromHue:hue saturation:sat brightness:bright alpha:alpha];
        case ColorSchemeComplementary:
            return [[self class] complementaryColorsFromHue:hue saturation:sat brightness:bright alpha:alpha];
        default:
            return nil;
    }
}


#pragma mark - Color Scheme Generation - Helper methods
+ (NSArray *)analagousColorsFromHue:(float)h saturation:(float)s brightness:(float)b alpha:(float)a
{
    return @[[[self class] colorWithHue:[[self class] addDegrees:30 toDegree:h]/360 saturation:(s-5)/100 brightness:(b-10)/100 alpha:a],
             [[self class] colorWithHue:[[self class] addDegrees:15 toDegree:h]/360 saturation:(s-5)/100 brightness:(b-5)/100 alpha:a],
             [[self class] colorWithHue:[[self class] addDegrees:-15 toDegree:h]/360 saturation:(s-5)/100 brightness:(b-5)/100 alpha:a],
             [[self class] colorWithHue:[[self class] addDegrees:-30 toDegree:h]/360 saturation:(s-5)/100 brightness:(b-10)/100 alpha:a]];
}

+ (NSArray *)monochromaticColorsFromHue:(float)h saturation:(float)s brightness:(float)b alpha:(float)a
{
    return @[[[self class] colorWithHue:h/360 saturation:(s/2)/100 brightness:(b/3)/100 alpha:a],
             [[self class] colorWithHue:h/360 saturation:s/100 brightness:(b/2)/100 alpha:a],
             [[self class] colorWithHue:h/360 saturation:(s/3)/100 brightness:(2*b/3)/100 alpha:a],
             [[self class] colorWithHue:h/360 saturation:s/100 brightness:(4*b/5)/100 alpha:a]];
}

+ (NSArray *)triadColorsFromHue:(float)h saturation:(float)s brightness:(float)b alpha:(float)a
{
    return @[[[self class] colorWithHue:[[self class] addDegrees:120 toDegree:h]/360 saturation:(7*s/6)/100 brightness:(b-5)/100 alpha:a],
             [[self class] colorWithHue:[[self class] addDegrees:120 toDegree:h]/360 saturation:s/100 brightness:b/100 alpha:a],
             [[self class] colorWithHue:[[self class] addDegrees:240 toDegree:h]/360 saturation:s/100 brightness:b/100 alpha:a],
             [[self class] colorWithHue:[[self class] addDegrees:240 toDegree:h]/360 saturation:(7*s/6)/100 brightness:(b-5)/100 alpha:a]];
}

+ (NSArray *)complementaryColorsFromHue:(float)h saturation:(float)s brightness:(float)b alpha:(float)a
{
    return @[[[self class] colorWithHue:h/360 saturation:s/100 brightness:(4*b/5)/100 alpha:a],
             [[self class] colorWithHue:h/360 saturation:(5*s/7)/100 brightness:b/100 alpha:a],
             [[self class] colorWithHue:[[self class] addDegrees:180 toDegree:h]/360 saturation:s/100 brightness:b/100 alpha:a],
             [[self class] colorWithHue:[[self class] addDegrees:180 toDegree:h]/360 saturation:(5*s/7)/100 brightness:b/100 alpha:a]];
}

+ (float)addDegrees:(float)addDeg toDegree:(float)staticDeg
{
    staticDeg += addDeg;
    if (staticDeg > 360) {
        float offset = staticDeg - 360;
        return offset;
    }
    else if (staticDeg < 0) {
        return -1 * staticDeg;
    }
    else {
        return staticDeg;
    }
}


#pragma mark - Contrasting Color
- (instancetype)blackOrWhiteContrastingColor
{
    NSArray *rgbaArray = [self rgbaArray];
    double a = 1 - ((0.299 * [rgbaArray[0] doubleValue]) + (0.587 * [rgbaArray[1] doubleValue]) + (0.114 * [rgbaArray[2] doubleValue]));
    return a < 0.5 ? [[self class] blackColor] : [[self class] whiteColor];
}


#pragma mark - Complementary Color
- (instancetype)complementaryColor
{
    NSMutableDictionary *hsba = [[self hsbaDictionary] mutableCopy];
    float newH = [[self class] addDegrees:180.0f toDegree:([hsba[@"h"] floatValue]*360)];
    [hsba setObject:@(newH) forKey:@"h"];
    return [[self class] colorFromHSBADictionary:hsba];
    
}


#pragma mark - System Colors
+ (instancetype)infoBlueColor
{
	return [[self class] colorWithRed:47/255.0f green:112/255.0f blue:225/255.0f alpha:1.0];
}

+ (instancetype)successColor
{
	return [[self class] colorWithRed:83/255.0f green:215/255.0f blue:106/255.0f alpha:1.0];
}

+ (instancetype)warningColor
{
	return [[self class] colorWithRed:221/255.0f green:170/255.0f blue:59/255.0f alpha:1.0];
}

+ (instancetype)dangerColor
{
	return [[self class] colorWithRed:229/255.0f green:0/255.0f blue:15/255.0f alpha:1.0];
}


#pragma mark - Whites
+ (instancetype)antiqueWhiteColor
{
	return [[self class] colorWithRed:250/255.0f green:235/255.0f blue:215/255.0f alpha:1.0];
}

+ (instancetype)oldLaceColor
{
	return [[self class] colorWithRed:253/255.0f green:245/255.0f blue:230/255.0f alpha:1.0];
}

+ (instancetype)ivoryColor
{
	return [[self class] colorWithRed:255/255.0f green:255/255.0f blue:240/255.0f alpha:1.0];
}

+ (instancetype)seashellColor
{
	return [[self class] colorWithRed:255/255.0f green:245/255.0f blue:238/255.0f alpha:1.0];
}

+ (instancetype)ghostWhiteColor
{
	return [[self class] colorWithRed:248/255.0f green:248/255.0f blue:255/255.0f alpha:1.0];
}

+ (instancetype)snowColor
{
	return [[self class] colorWithRed:255/255.0f green:250/255.0f blue:250/255.0f alpha:1.0];
}

+ (instancetype)linenColor
{
	return [[self class] colorWithRed:250/255.0f green:240/255.0f blue:230/255.0f alpha:1.0];
}


#pragma mark - Grays
+ (instancetype)black25PercentColor
{
	return [[self class] colorWithWhite:0.25 alpha:1.0];
}

+ (instancetype)black50PercentColor
{
	return [[self class] colorWithWhite:0.5  alpha:1.0];
}

+ (instancetype)black75PercentColor
{
	return [[self class] colorWithWhite:0.75 alpha:1.0];
}

+ (instancetype)warmGrayColor
{
	return [[self class] colorWithRed:133/255.0f green:117/255.0f blue:112/255.0f alpha:1.0];
}

+ (instancetype)coolGrayColor
{
	return [[self class] colorWithRed:118/255.0f green:122/255.0f blue:133/255.0f alpha:1.0];
}

+ (instancetype)charcoalColor
{
	return [[self class] colorWithRed:34/255.0f green:34/255.0f blue:34/255.0f alpha:1.0];
}


#pragma mark - Blues
+ (instancetype)tealColor
{
	return [[self class] colorWithRed:28/255.0f green:160/255.0f blue:170/255.0f alpha:1.0];
}

+ (instancetype)steelBlueColor
{
	return [[self class] colorWithRed:103/255.0f green:153/255.0f blue:170/255.0f alpha:1.0];
}

+ (instancetype)robinEggColor
{
	return [[self class] colorWithRed:141/255.0f green:218/255.0f blue:247/255.0f alpha:1.0];
}

+ (instancetype)pastelBlueColor
{
	return [[self class] colorWithRed:99/255.0f green:161/255.0f blue:247/255.0f alpha:1.0];
}

+ (instancetype)turquoiseColor
{
	return [[self class] colorWithRed:112/255.0f green:219/255.0f blue:219/255.0f alpha:1.0];
}

+ (instancetype)skyBlueColor
{
	return [[self class] colorWithRed:0/255.0f green:178/255.0f blue:238/255.0f alpha:1.0];
}

+ (instancetype)indigoColor
{
	return [[self class] colorWithRed:13/255.0f green:79/255.0f blue:139/255.0f alpha:1.0];
}

+ (instancetype)denimColor
{
	return [[self class] colorWithRed:67/255.0f green:114/255.0f blue:170/255.0f alpha:1.0];
}

+ (instancetype)blueberryColor
{
	return [[self class] colorWithRed:89/255.0f green:113/255.0f blue:173/255.0f alpha:1.0];
}

+ (instancetype)cornflowerColor
{
	return [[self class] colorWithRed:100/255.0f green:149/255.0f blue:237/255.0f alpha:1.0];
}

+ (instancetype)babyBlueColor
{
	return [[self class] colorWithRed:190/255.0f green:220/255.0f blue:230/255.0f alpha:1.0];
}

+ (instancetype)midnightBlueColor
{
	return [[self class] colorWithRed:13/255.0f green:26/255.0f blue:35/255.0f alpha:1.0];
}

+ (instancetype)fadedBlueColor
{
	return [[self class] colorWithRed:23/255.0f green:137/255.0f blue:155/255.0f alpha:1.0];
}

+ (instancetype)icebergColor
{
	return [[self class] colorWithRed:200/255.0f green:213/255.0f blue:219/255.0f alpha:1.0];
}

+ (instancetype)waveColor
{
	return [[self class] colorWithRed:102/255.0f green:169/255.0f blue:251/255.0f alpha:1.0];
}


#pragma mark - Greens
+ (instancetype)emeraldColor
{
	return [[self class] colorWithRed:1/255.0f green:152/255.0f blue:117/255.0f alpha:1.0];
}

+ (instancetype)grassColor
{
	return [[self class] colorWithRed:99/255.0f green:214/255.0f blue:74/255.0f alpha:1.0];
}

+ (instancetype)pastelGreenColor
{
	return [[self class] colorWithRed:126/255.0f green:242/255.0f blue:124/255.0f alpha:1.0];
}

+ (instancetype)seafoamColor
{
	return [[self class] colorWithRed:77/255.0f green:226/255.0f blue:140/255.0f alpha:1.0];
}

+ (instancetype)paleGreenColor
{
	return [[self class] colorWithRed:176/255.0f green:226/255.0f blue:172/255.0f alpha:1.0];
}

+ (instancetype)cactusGreenColor
{
	return [[self class] colorWithRed:99/255.0f green:111/255.0f blue:87/255.0f alpha:1.0];
}

+ (instancetype)chartreuseColor
{
	return [[self class] colorWithRed:69/255.0f green:139/255.0f blue:0/255.0f alpha:1.0];
}

+ (instancetype)hollyGreenColor
{
	return [[self class] colorWithRed:32/255.0f green:87/255.0f blue:14/255.0f alpha:1.0];
}

+ (instancetype)oliveColor
{
	return [[self class] colorWithRed:91/255.0f green:114/255.0f blue:34/255.0f alpha:1.0];
}

+ (instancetype)oliveDrabColor
{
	return [[self class] colorWithRed:107/255.0f green:142/255.0f blue:35/255.0f alpha:1.0];
}

+ (instancetype)moneyGreenColor
{
	return [[self class] colorWithRed:134/255.0f green:198/255.0f blue:124/255.0f alpha:1.0];
}

+ (instancetype)honeydewColor
{
	return [[self class] colorWithRed:216/255.0f green:255/255.0f blue:231/255.0f alpha:1.0];
}

+ (instancetype)limeColor
{
	return [[self class] colorWithRed:56/255.0f green:237/255.0f blue:56/255.0f alpha:1.0];
}

+ (instancetype)cardTableColor
{
	return [[self class] colorWithRed:87/255.0f green:121/255.0f blue:107/255.0f alpha:1.0];
}


#pragma mark - Reds
+ (instancetype)salmonColor
{
	return [[self class] colorWithRed:233/255.0f green:87/255.0f blue:95/255.0f alpha:1.0];
}

+ (instancetype)brickRedColor
{
	return [[self class] colorWithRed:151/255.0f green:27/255.0f blue:16/255.0f alpha:1.0];
}

+ (instancetype)easterPinkColor
{
	return [[self class] colorWithRed:241/255.0f green:167/255.0f blue:162/255.0f alpha:1.0];
}

+ (instancetype)grapefruitColor
{
	return [[self class] colorWithRed:228/255.0f green:31/255.0f blue:54/255.0f alpha:1.0];
}

+ (instancetype)pinkColor
{
	return [[self class] colorWithRed:255/255.0f green:95/255.0f blue:154/255.0f alpha:1.0];
}

+ (instancetype)indianRedColor
{
	return [[self class] colorWithRed:205/255.0f green:92/255.0f blue:92/255.0f alpha:1.0];
}

+ (instancetype)strawberryColor
{
	return [[self class] colorWithRed:190/255.0f green:38/255.0f blue:37/255.0f alpha:1.0];
}

+ (instancetype)coralColor
{
	return [[self class] colorWithRed:240/255.0f green:128/255.0f blue:128/255.0f alpha:1.0];
}

+ (instancetype)maroonColor
{
	return [[self class] colorWithRed:80/255.0f green:4/255.0f blue:28/255.0f alpha:1.0];
}

+ (instancetype)watermelonColor
{
	return [[self class] colorWithRed:242/255.0f green:71/255.0f blue:63/255.0f alpha:1.0];
}

+ (instancetype)tomatoColor
{
	return [[self class] colorWithRed:255/255.0f green:99/255.0f blue:71/255.0f alpha:1.0];
}

+ (instancetype)pinkLipstickColor
{
	return [[self class] colorWithRed:255/255.0f green:105/255.0f blue:180/255.0f alpha:1.0];
}

+ (instancetype)paleRoseColor
{
	return [[self class] colorWithRed:255/255.0f green:228/255.0f blue:225/255.0f alpha:1.0];
}

+ (instancetype)crimsonColor
{
	return [[self class] colorWithRed:187/255.0f green:18/255.0f blue:36/255.0f alpha:1.0];
}


#pragma mark - Purples
+ (instancetype)eggplantColor
{
	return [[self class] colorWithRed:105/255.0f green:5/255.0f blue:98/255.0f alpha:1.0];
}

+ (instancetype)pastelPurpleColor
{
	return [[self class] colorWithRed:207/255.0f green:100/255.0f blue:235/255.0f alpha:1.0];
}

+ (instancetype)palePurpleColor
{
	return [[self class] colorWithRed:229/255.0f green:180/255.0f blue:235/255.0f alpha:1.0];
}

+ (instancetype)coolPurpleColor
{
	return [[self class] colorWithRed:140/255.0f green:93/255.0f blue:228/255.0f alpha:1.0];
}

+ (instancetype)violetColor
{
	return [[self class] colorWithRed:191/255.0f green:95/255.0f blue:255/255.0f alpha:1.0];
}

+ (instancetype)plumColor
{
	return [[self class] colorWithRed:139/255.0f green:102/255.0f blue:139/255.0f alpha:1.0];
}

+ (instancetype)lavenderColor
{
	return [[self class] colorWithRed:204/255.0f green:153/255.0f blue:204/255.0f alpha:1.0];
}

+ (instancetype)raspberryColor
{
	return [[self class] colorWithRed:135/255.0f green:38/255.0f blue:87/255.0f alpha:1.0];
}

+ (instancetype)fuschiaColor
{
	return [[self class] colorWithRed:255/255.0f green:20/255.0f blue:147/255.0f alpha:1.0];
}

+ (instancetype)grapeColor
{
	return [[self class] colorWithRed:54/255.0f green:11/255.0f blue:88/255.0f alpha:1.0];
}

+ (instancetype)periwinkleColor
{
	return [[self class] colorWithRed:135/255.0f green:159/255.0f blue:237/255.0f alpha:1.0];
}

+ (instancetype)orchidColor
{
	return [[self class] colorWithRed:218/255.0f green:112/255.0f blue:214/255.0f alpha:1.0];
}


#pragma mark - Yellows
+ (instancetype)goldenrodColor
{
	return [[self class] colorWithRed:215/255.0f green:170/255.0f blue:51/255.0f alpha:1.0];
}

+ (instancetype)yellowGreenColor
{
	return [[self class] colorWithRed:192/255.0f green:242/255.0f blue:39/255.0f alpha:1.0];
}

+ (instancetype)bananaColor
{
	return [[self class] colorWithRed:229/255.0f green:227/255.0f blue:58/255.0f alpha:1.0];
}

+ (instancetype)mustardColor
{
	return [[self class] colorWithRed:205/255.0f green:171/255.0f blue:45/255.0f alpha:1.0];
}

+ (instancetype)buttermilkColor
{
	return [[self class] colorWithRed:254/255.0f green:241/255.0f blue:181/255.0f alpha:1.0];
}

+ (instancetype)goldColor
{
	return [[self class] colorWithRed:139/255.0f green:117/255.0f blue:18/255.0f alpha:1.0];
}

+ (instancetype)creamColor
{
	return [[self class] colorWithRed:240/255.0f green:226/255.0f blue:187/255.0f alpha:1.0];
}

+ (instancetype)lightCreamColor
{
	return [[self class] colorWithRed:240/255.0f green:238/255.0f blue:215/255.0f alpha:1.0];
}

+ (instancetype)wheatColor
{
	return [[self class] colorWithRed:240/255.0f green:238/255.0f blue:215/255.0f alpha:1.0];
}

+ (instancetype)beigeColor
{
	return [[self class] colorWithRed:245/255.0f green:245/255.0f blue:220/255.0f alpha:1.0];
}


#pragma mark - Oranges
+ (instancetype)peachColor
{
	return [[self class] colorWithRed:242/255.0f green:187/255.0f blue:97/255.0f alpha:1.0];
}

+ (instancetype)burntOrangeColor
{
	return [[self class] colorWithRed:184/255.0f green:102/255.0f blue:37/255.0f alpha:1.0];
}

+ (instancetype)pastelOrangeColor
{
	return [[self class] colorWithRed:248/255.0f green:197/255.0f blue:143/255.0f alpha:1.0];
}

+ (instancetype)cantaloupeColor
{
	return [[self class] colorWithRed:250/255.0f green:154/255.0f blue:79/255.0f alpha:1.0];
}

+ (instancetype)carrotColor
{
	return [[self class] colorWithRed:237/255.0f green:145/255.0f blue:33/255.0f alpha:1.0];
}

+ (instancetype)mandarinColor
{
	return [[self class] colorWithRed:247/255.0f green:145/255.0f blue:55/255.0f alpha:1.0];
}


#pragma mark - Browns
+ (instancetype)chiliPowderColor
{
	return [[self class] colorWithRed:199/255.0f green:63/255.0f blue:23/255.0f alpha:1.0];
}

+ (instancetype)burntSiennaColor
{
	return [[self class] colorWithRed:138/255.0f green:54/255.0f blue:15/255.0f alpha:1.0];
}

+ (instancetype)chocolateColor
{
	return [[self class] colorWithRed:94/255.0f green:38/255.0f blue:5/255.0f alpha:1.0];
}

+ (instancetype)coffeeColor
{
	return [[self class] colorWithRed:141/255.0f green:60/255.0f blue:15/255.0f alpha:1.0];
}

+ (instancetype)cinnamonColor
{
	return [[self class] colorWithRed:123/255.0f green:63/255.0f blue:9/255.0f alpha:1.0];
}

+ (instancetype)almondColor
{
	return [[self class] colorWithRed:196/255.0f green:142/255.0f blue:72/255.0f alpha:1.0];
}

+ (instancetype)eggshellColor
{
	return [[self class] colorWithRed:252/255.0f green:230/255.0f blue:201/255.0f alpha:1.0];
}

+ (instancetype)sandColor
{
	return [[self class] colorWithRed:222/255.0f green:182/255.0f blue:151/255.0f alpha:1.0];
}

+ (instancetype)mudColor
{
	return [[self class] colorWithRed:70/255.0f green:45/255.0f blue:29/255.0f alpha:1.0];
}

+ (instancetype)siennaColor
{
	return [[self class] colorWithRed:160/255.0f green:82/255.0f blue:45/255.0f alpha:1.0];
}

+ (instancetype)dustColor
{
	return [[self class] colorWithRed:236/255.0f green:214/255.0f blue:197/255.0f alpha:1.0];
}

@end
