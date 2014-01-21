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

#import "NSColor+Colours.h"

@implementation NSColor (Colours)


#pragma mark - NSColor from Hex
+ (NSColor *)colorFromHexString:(NSString *)hexString
{
    unsigned rgbValue = 0;
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner scanHexInt:&rgbValue];
	
    return [NSColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}


#pragma mark - Hex from NSColor
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


#pragma mark - NSColor from RGBA
+ (NSColor *)colorFromRGBAArray:(NSArray *)rgbaArray
{
    if (rgbaArray.count < 4) {
        return [NSColor clearColor];
    }

    return [NSColor colorWithRed:[rgbaArray[0] floatValue] green:[rgbaArray[1] floatValue] blue:[rgbaArray[2] floatValue] alpha:[rgbaArray[3] floatValue]];
}

+ (NSColor *)colorFromRGBADictionary:(NSDictionary *)rgbaDict
{
    if (rgbaDict[@"r"] && rgbaDict[@"g"] && rgbaDict[@"b"] && rgbaDict[@"a"]) {
        return [NSColor colorWithRed:[rgbaDict[@"r"] floatValue] green:[rgbaDict[@"g"] floatValue] blue:[rgbaDict[@"b"] floatValue] alpha:[rgbaDict[@"a"] floatValue]];
    }
    
    return [NSColor clearColor];
}


#pragma mark - RGBA from NSColor
- (NSArray *)rgbaArray
{
    // Takes a NSColor and returns R,G,B,A values in NSNumber form
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
    // Takes NSColor and returns RGBA values in a dictionary as NSNumbers
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
    
    return @{@"r":@(r), @"g":@(g), @"b":@(b), @"a":@(a)};
}


#pragma mark - HSBA from NSColor
- (NSArray *)hsbaArray
{
    // Takes a NSColor and returns Hue,Saturation,Brightness,Alpha values in NSNumber form
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
    // Takes a NSColor and returns Hue,Saturation,Brightness,Alpha values in NSNumber form
    CGFloat h=0,s=0,b=0,a=0;
    
    if ([self respondsToSelector:@selector(getHue:saturation:brightness:alpha:)]) {
        [self getHue:&h saturation:&s brightness:&b alpha:&a];
    }
    
    return @{@"h":@(h), @"s":@(s), @"b":@(b), @"a":@(a)};
}


#pragma mark - NSColor from HSBA
+ (NSColor *)colorFromHSBAArray:(NSArray *)hsbaArray
{
    if (hsbaArray.count < 4) {
        return [NSColor clearColor];
    }
    
    return [NSColor colorWithHue:[hsbaArray[0] doubleValue] saturation:[hsbaArray[1] doubleValue] brightness:[hsbaArray[2] doubleValue] alpha:[hsbaArray[3] doubleValue]];
}

+ (NSColor *)colorFromHSBADictionary:(NSDictionary *)hsbaDict
{
    if (hsbaDict[@"h"] && hsbaDict[@"s"] && hsbaDict[@"b"] && hsbaDict[@"a"]) {
        return [NSColor colorWithHue:[hsbaDict[@"h"] doubleValue] saturation:[hsbaDict[@"s"] doubleValue] brightness:[hsbaDict[@"b"] doubleValue] alpha:[hsbaDict[@"a"] doubleValue]];
    }
    
    return [NSColor clearColor];
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
            return [NSColor analagousColorsFromHue:hue saturation:sat brightness:bright alpha:alpha];
        case ColorSchemeMonochromatic:
            return [NSColor monochromaticColorsFromHue:hue saturation:sat brightness:bright alpha:alpha];
        case ColorSchemeTriad:
            return [NSColor triadColorsFromHue:hue saturation:sat brightness:bright alpha:alpha];
        case ColorSchemeComplementary:
            return [NSColor complementaryColorsFromHue:hue saturation:sat brightness:bright alpha:alpha];
        default:
            return nil;
    }
}


#pragma mark - Color Scheme Generation - Helper methods
+ (NSArray *)analagousColorsFromHue:(float)h saturation:(float)s brightness:(float)b alpha:(float)a
{
    NSColor *colorAbove1 = [NSColor colorWithHue:[NSColor addDegrees:15 toDegree:h]/360 saturation:(s-5)/100 brightness:(b-5)/100 alpha:a];
    NSColor *colorAbove2 = [NSColor colorWithHue:[NSColor addDegrees:30 toDegree:h]/360 saturation:(s-5)/100 brightness:(b-10)/100 alpha:a];
    NSColor *colorBelow1 = [NSColor colorWithHue:[NSColor addDegrees:-15 toDegree:h]/360 saturation:(s-5)/100 brightness:(b-5)/100 alpha:a];
    NSColor *colorBelow2 = [NSColor colorWithHue:[NSColor addDegrees:-30 toDegree:h]/360 saturation:(s-5)/100 brightness:(b-10)/100 alpha:a];
    
    return @[colorAbove2,colorAbove1,colorBelow1,colorBelow2];
}

+ (NSArray *)monochromaticColorsFromHue:(float)h saturation:(float)s brightness:(float)b alpha:(float)a
{
    NSColor *colorAbove1 = [NSColor colorWithHue:h/360 saturation:s/100 brightness:(b/2)/100 alpha:a];
    NSColor *colorAbove2 = [NSColor colorWithHue:h/360 saturation:(s/2)/100 brightness:(b/3)/100 alpha:a];
    NSColor *colorBelow1 = [NSColor colorWithHue:h/360 saturation:(s/3)/100 brightness:(2*b/3)/100 alpha:a];
    NSColor *colorBelow2 = [NSColor colorWithHue:h/360 saturation:s/100 brightness:(4*b/5)/100 alpha:a];
    
    return @[colorAbove2,colorAbove1,colorBelow1,colorBelow2];
}

+ (NSArray *)triadColorsFromHue:(float)h saturation:(float)s brightness:(float)b alpha:(float)a
{
    NSColor *colorAbove1 = [NSColor colorWithHue:[NSColor addDegrees:120 toDegree:h]/360 saturation:s/100 brightness:b/100 alpha:a];
    NSColor *colorAbove2 = [NSColor colorWithHue:[NSColor addDegrees:120 toDegree:h]/360 saturation:(7*s/6)/100 brightness:(b-5)/100 alpha:a];
    NSColor *colorBelow1 = [NSColor colorWithHue:[NSColor addDegrees:240 toDegree:h]/360 saturation:s/100 brightness:b/100 alpha:a];
    NSColor *colorBelow2 = [NSColor colorWithHue:[NSColor addDegrees:240 toDegree:h]/360 saturation:(7*s/6)/100 brightness:(b-5)/100 alpha:a];
    
    return @[colorAbove2,colorAbove1,colorBelow1,colorBelow2];
}

+ (NSArray *)complementaryColorsFromHue:(float)h saturation:(float)s brightness:(float)b alpha:(float)a
{
    NSColor *colorAbove1 = [NSColor colorWithHue:h/360 saturation:(5*s/7)/100 brightness:b/100 alpha:a];
    NSColor *colorAbove2 = [NSColor colorWithHue:h/360 saturation:s/100 brightness:(4*b/5)/100 alpha:a];
    NSColor *colorBelow1 = [NSColor colorWithHue:[NSColor addDegrees:180 toDegree:h]/360 saturation:s/100 brightness:b/100 alpha:a];
    NSColor *colorBelow2 = [NSColor colorWithHue:[NSColor addDegrees:180 toDegree:h]/360 saturation:(5*s/7)/100 brightness:b/100 alpha:a];
    
    return @[colorAbove2,colorAbove1,colorBelow1,colorBelow2];
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
- (NSColor *)blackOrWhiteContrastingColor
{
    NSArray *rgbaArray = [self rgbaArray];
    double a = 1 - ((0.299 * [rgbaArray[0] doubleValue]) + (0.587 * [rgbaArray[1] doubleValue]) + (0.114 * [rgbaArray[2] doubleValue]));
    return a < 0.5 ? [NSColor blackColor] : [NSColor whiteColor];
}


#pragma mark - Complementary Color
- (NSColor *)complementaryColor
{
    NSMutableDictionary *hsba = [[self hsbaDictionary] mutableCopy];
    float newH = [NSColor addDegrees:180.0f toDegree:([hsba[@"h"] floatValue]*360)];
    [hsba setObject:@(newH) forKey:@"h"];
    return [NSColor colorFromHSBADictionary:hsba];
    
}


#pragma mark - System Colors
+ (NSColor *)infoBlueColor
{
	return [NSColor colorWithRed:47/255.0f green:112/255.0f blue:225/255.0f alpha:1.0];
}

+ (NSColor *)successColor
{
	return [NSColor colorWithRed:83/255.0f green:215/255.0f blue:106/255.0f alpha:1.0];
}

+ (NSColor *)warningColor
{
	return [NSColor colorWithRed:221/255.0f green:170/255.0f blue:59/255.0f alpha:1.0];
}

+ (NSColor *)dangerColor
{
	return [NSColor colorWithRed:229/255.0f green:0/255.0f blue:15/255.0f alpha:1.0];
}


#pragma mark - Whites
+ (NSColor *)antiqueWhiteColor
{
	return [NSColor colorWithRed:250/255.0f green:235/255.0f blue:215/255.0f alpha:1.0];
}

+ (NSColor *)oldLaceColor
{
	return [NSColor colorWithRed:253/255.0f green:245/255.0f blue:230/255.0f alpha:1.0];
}

+ (NSColor *)ivoryColor
{
	return [NSColor colorWithRed:255/255.0f green:255/255.0f blue:240/255.0f alpha:1.0];
}

+ (NSColor *)seashellColor
{
	return [NSColor colorWithRed:255/255.0f green:245/255.0f blue:238/255.0f alpha:1.0];
}

+ (NSColor *)ghostWhiteColor
{
	return [NSColor colorWithRed:248/255.0f green:248/255.0f blue:255/255.0f alpha:1.0];
}

+ (NSColor *)snowColor
{
	return [NSColor colorWithRed:255/255.0f green:250/255.0f blue:250/255.0f alpha:1.0];
}

+ (NSColor *)linenColor
{
	return [NSColor colorWithRed:250/255.0f green:240/255.0f blue:230/255.0f alpha:1.0];
}


#pragma mark - Grays
+ (NSColor *)black25PercentColor
{
	return [NSColor colorWithWhite:0.25 alpha:1.0];
}

+ (NSColor *)black50PercentColor
{
	return [NSColor colorWithWhite:0.5  alpha:1.0];
}

+ (NSColor *)black75PercentColor
{
	return [NSColor colorWithWhite:0.75 alpha:1.0];
}

+ (NSColor *)warmGrayColor
{
	return [NSColor colorWithRed:133/255.0f green:117/255.0f blue:112/255.0f alpha:1.0];
}

+ (NSColor *)coolGrayColor
{
	return [NSColor colorWithRed:118/255.0f green:122/255.0f blue:133/255.0f alpha:1.0];
}

+ (NSColor *)charcoalColor
{
	return [NSColor colorWithRed:34/255.0f green:34/255.0f blue:34/255.0f alpha:1.0];
}


#pragma mark - Blues
+ (NSColor *)tealColor
{
	return [NSColor colorWithRed:28/255.0f green:160/255.0f blue:170/255.0f alpha:1.0];
}

+ (NSColor *)steelBlueColor
{
	return [NSColor colorWithRed:103/255.0f green:153/255.0f blue:170/255.0f alpha:1.0];
}

+ (NSColor *)robinEggColor
{
	return [NSColor colorWithRed:141/255.0f green:218/255.0f blue:247/255.0f alpha:1.0];
}

+ (NSColor *)pastelBlueColor
{
	return [NSColor colorWithRed:99/255.0f green:161/255.0f blue:247/255.0f alpha:1.0];
}

+ (NSColor *)turquoiseColor
{
	return [NSColor colorWithRed:112/255.0f green:219/255.0f blue:219/255.0f alpha:1.0];
}

+ (NSColor *)skyBlueColor
{
	return [NSColor colorWithRed:0/255.0f green:178/255.0f blue:238/255.0f alpha:1.0];
}

+ (NSColor *)indigoColor
{
	return [NSColor colorWithRed:13/255.0f green:79/255.0f blue:139/255.0f alpha:1.0];
}

+ (NSColor *)denimColor
{
	return [NSColor colorWithRed:67/255.0f green:114/255.0f blue:170/255.0f alpha:1.0];
}

+ (NSColor *)blueberryColor
{
	return [NSColor colorWithRed:89/255.0f green:113/255.0f blue:173/255.0f alpha:1.0];
}

+ (NSColor *)cornflowerColor
{
	return [NSColor colorWithRed:100/255.0f green:149/255.0f blue:237/255.0f alpha:1.0];
}

+ (NSColor *)babyBlueColor
{
	return [NSColor colorWithRed:190/255.0f green:220/255.0f blue:230/255.0f alpha:1.0];
}

+ (NSColor *)midnightBlueColor
{
	return [NSColor colorWithRed:13/255.0f green:26/255.0f blue:35/255.0f alpha:1.0];
}

+ (NSColor *)fadedBlueColor
{
	return [NSColor colorWithRed:23/255.0f green:137/255.0f blue:155/255.0f alpha:1.0];
}

+ (NSColor *)icebergColor
{
	return [NSColor colorWithRed:200/255.0f green:213/255.0f blue:219/255.0f alpha:1.0];
}

+ (NSColor *)waveColor
{
	return [NSColor colorWithRed:102/255.0f green:169/255.0f blue:251/255.0f alpha:1.0];
}


#pragma mark - Greens
+ (NSColor *)emeraldColor
{
	return [NSColor colorWithRed:1/255.0f green:152/255.0f blue:117/255.0f alpha:1.0];
}

+ (NSColor *)grassColor
{
	return [NSColor colorWithRed:99/255.0f green:214/255.0f blue:74/255.0f alpha:1.0];
}

+ (NSColor *)pastelGreenColor
{
	return [NSColor colorWithRed:126/255.0f green:242/255.0f blue:124/255.0f alpha:1.0];
}

+ (NSColor *)seafoamColor
{
	return [NSColor colorWithRed:77/255.0f green:226/255.0f blue:140/255.0f alpha:1.0];
}

+ (NSColor *)paleGreenColor
{
	return [NSColor colorWithRed:176/255.0f green:226/255.0f blue:172/255.0f alpha:1.0];
}

+ (NSColor *)cactusGreenColor
{
	return [NSColor colorWithRed:99/255.0f green:111/255.0f blue:87/255.0f alpha:1.0];
}

+ (NSColor *)chartreuseColor
{
	return [NSColor colorWithRed:69/255.0f green:139/255.0f blue:0/255.0f alpha:1.0];
}

+ (NSColor *)hollyGreenColor
{
	return [NSColor colorWithRed:32/255.0f green:87/255.0f blue:14/255.0f alpha:1.0];
}

+ (NSColor *)oliveColor
{
	return [NSColor colorWithRed:91/255.0f green:114/255.0f blue:34/255.0f alpha:1.0];
}

+ (NSColor *)oliveDrabColor
{
	return [NSColor colorWithRed:107/255.0f green:142/255.0f blue:35/255.0f alpha:1.0];
}

+ (NSColor *)moneyGreenColor
{
	return [NSColor colorWithRed:134/255.0f green:198/255.0f blue:124/255.0f alpha:1.0];
}

+ (NSColor *)honeydewColor
{
	return [NSColor colorWithRed:216/255.0f green:255/255.0f blue:231/255.0f alpha:1.0];
}

+ (NSColor *)limeColor
{
	return [NSColor colorWithRed:56/255.0f green:237/255.0f blue:56/255.0f alpha:1.0];
}

+ (NSColor *)cardTableColor
{
	return [NSColor colorWithRed:87/255.0f green:121/255.0f blue:107/255.0f alpha:1.0];
}


#pragma mark - Reds
+ (NSColor *)salmonColor
{
	return [NSColor colorWithRed:233/255.0f green:87/255.0f blue:95/255.0f alpha:1.0];
}

+ (NSColor *)brickRedColor
{
	return [NSColor colorWithRed:151/255.0f green:27/255.0f blue:16/255.0f alpha:1.0];
}

+ (NSColor *)easterPinkColor
{
	return [NSColor colorWithRed:241/255.0f green:167/255.0f blue:162/255.0f alpha:1.0];
}

+ (NSColor *)grapefruitColor
{
	return [NSColor colorWithRed:228/255.0f green:31/255.0f blue:54/255.0f alpha:1.0];
}

+ (NSColor *)pinkColor
{
	return [NSColor colorWithRed:255/255.0f green:95/255.0f blue:154/255.0f alpha:1.0];
}

+ (NSColor *)indianRedColor
{
	return [NSColor colorWithRed:205/255.0f green:92/255.0f blue:92/255.0f alpha:1.0];
}

+ (NSColor *)strawberryColor
{
	return [NSColor colorWithRed:190/255.0f green:38/255.0f blue:37/255.0f alpha:1.0];
}

+ (NSColor *)coralColor
{
	return [NSColor colorWithRed:240/255.0f green:128/255.0f blue:128/255.0f alpha:1.0];
}

+ (NSColor *)maroonColor
{
	return [NSColor colorWithRed:80/255.0f green:4/255.0f blue:28/255.0f alpha:1.0];
}

+ (NSColor *)watermelonColor
{
	return [NSColor colorWithRed:242/255.0f green:71/255.0f blue:63/255.0f alpha:1.0];
}

+ (NSColor *)tomatoColor
{
	return [NSColor colorWithRed:255/255.0f green:99/255.0f blue:71/255.0f alpha:1.0];
}

+ (NSColor *)pinkLipstickColor
{
	return [NSColor colorWithRed:255/255.0f green:105/255.0f blue:180/255.0f alpha:1.0];
}

+ (NSColor *)paleRoseColor
{
	return [NSColor colorWithRed:255/255.0f green:228/255.0f blue:225/255.0f alpha:1.0];
}

+ (NSColor *)crimsonColor
{
	return [NSColor colorWithRed:187/255.0f green:18/255.0f blue:36/255.0f alpha:1.0];
}


#pragma mark - Purples
+ (NSColor *)eggplantColor
{
	return [NSColor colorWithRed:105/255.0f green:5/255.0f blue:98/255.0f alpha:1.0];
}

+ (NSColor *)pastelPurpleColor
{
	return [NSColor colorWithRed:207/255.0f green:100/255.0f blue:235/255.0f alpha:1.0];
}

+ (NSColor *)palePurpleColor
{
	return [NSColor colorWithRed:229/255.0f green:180/255.0f blue:235/255.0f alpha:1.0];
}

+ (NSColor *)coolPurpleColor
{
	return [NSColor colorWithRed:140/255.0f green:93/255.0f blue:228/255.0f alpha:1.0];
}

+ (NSColor *)violetColor
{
	return [NSColor colorWithRed:191/255.0f green:95/255.0f blue:255/255.0f alpha:1.0];
}

+ (NSColor *)plumColor
{
	return [NSColor colorWithRed:139/255.0f green:102/255.0f blue:139/255.0f alpha:1.0];
}

+ (NSColor *)lavenderColor
{
	return [NSColor colorWithRed:204/255.0f green:153/255.0f blue:204/255.0f alpha:1.0];
}

+ (NSColor *)raspberryColor
{
	return [NSColor colorWithRed:135/255.0f green:38/255.0f blue:87/255.0f alpha:1.0];
}

+ (NSColor *)fuschiaColor
{
	return [NSColor colorWithRed:255/255.0f green:20/255.0f blue:147/255.0f alpha:1.0];
}

+ (NSColor *)grapeColor
{
	return [NSColor colorWithRed:54/255.0f green:11/255.0f blue:88/255.0f alpha:1.0];
}

+ (NSColor *)periwinkleColor
{
	return [NSColor colorWithRed:135/255.0f green:159/255.0f blue:237/255.0f alpha:1.0];
}

+ (NSColor *)orchidColor
{
	return [NSColor colorWithRed:218/255.0f green:112/255.0f blue:214/255.0f alpha:1.0];
}


#pragma mark - Yellows
+ (NSColor *)goldenrodColor
{
	return [NSColor colorWithRed:215/255.0f green:170/255.0f blue:51/255.0f alpha:1.0];
}

+ (NSColor *)yellowGreenColor
{
	return [NSColor colorWithRed:192/255.0f green:242/255.0f blue:39/255.0f alpha:1.0];
}

+ (NSColor *)bananaColor
{
	return [NSColor colorWithRed:229/255.0f green:227/255.0f blue:58/255.0f alpha:1.0];
}

+ (NSColor *)mustardColor
{
	return [NSColor colorWithRed:205/255.0f green:171/255.0f blue:45/255.0f alpha:1.0];
}

+ (NSColor *)buttermilkColor
{
	return [NSColor colorWithRed:254/255.0f green:241/255.0f blue:181/255.0f alpha:1.0];
}

+ (NSColor *)goldColor
{
	return [NSColor colorWithRed:139/255.0f green:117/255.0f blue:18/255.0f alpha:1.0];
}

+ (NSColor *)creamColor
{
	return [NSColor colorWithRed:240/255.0f green:226/255.0f blue:187/255.0f alpha:1.0];
}

+ (NSColor *)lightCreamColor
{
	return [NSColor colorWithRed:240/255.0f green:238/255.0f blue:215/255.0f alpha:1.0];
}

+ (NSColor *)wheatColor
{
	return [NSColor colorWithRed:240/255.0f green:238/255.0f blue:215/255.0f alpha:1.0];
}

+ (NSColor *)beigeColor
{
	return [NSColor colorWithRed:245/255.0f green:245/255.0f blue:220/255.0f alpha:1.0];
}


#pragma mark - Oranges
+ (NSColor *)peachColor
{
	return [NSColor colorWithRed:242/255.0f green:187/255.0f blue:97/255.0f alpha:1.0];
}

+ (NSColor *)burntOrangeColor
{
	return [NSColor colorWithRed:184/255.0f green:102/255.0f blue:37/255.0f alpha:1.0];
}

+ (NSColor *)pastelOrangeColor
{
	return [NSColor colorWithRed:248/255.0f green:197/255.0f blue:143/255.0f alpha:1.0];
}

+ (NSColor *)cantaloupeColor
{
	return [NSColor colorWithRed:250/255.0f green:154/255.0f blue:79/255.0f alpha:1.0];
}

+ (NSColor *)carrotColor
{
	return [NSColor colorWithRed:237/255.0f green:145/255.0f blue:33/255.0f alpha:1.0];
}

+ (NSColor *)mandarinColor
{
	return [NSColor colorWithRed:247/255.0f green:145/255.0f blue:55/255.0f alpha:1.0];
}


#pragma mark - Browns
+ (NSColor *)chiliPowderColor
{
	return [NSColor colorWithRed:199/255.0f green:63/255.0f blue:23/255.0f alpha:1.0];
}

+ (NSColor *)burntSiennaColor
{
	return [NSColor colorWithRed:138/255.0f green:54/255.0f blue:15/255.0f alpha:1.0];
}

+ (NSColor *)chocolateColor
{
	return [NSColor colorWithRed:94/255.0f green:38/255.0f blue:5/255.0f alpha:1.0];
}

+ (NSColor *)coffeeColor
{
	return [NSColor colorWithRed:141/255.0f green:60/255.0f blue:15/255.0f alpha:1.0];
}

+ (NSColor *)cinnamonColor
{
	return [NSColor colorWithRed:123/255.0f green:63/255.0f blue:9/255.0f alpha:1.0];
}

+ (NSColor *)almondColor
{
	return [NSColor colorWithRed:196/255.0f green:142/255.0f blue:72/255.0f alpha:1.0];
}

+ (NSColor *)eggshellColor
{
	return [NSColor colorWithRed:252/255.0f green:230/255.0f blue:201/255.0f alpha:1.0];
}

+ (NSColor *)sandColor
{
	return [NSColor colorWithRed:222/255.0f green:182/255.0f blue:151/255.0f alpha:1.0];
}

+ (NSColor *)mudColor
{
	return [NSColor colorWithRed:70/255.0f green:45/255.0f blue:29/255.0f alpha:1.0];
}

+ (NSColor *)siennaColor
{
	return [NSColor colorWithRed:160/255.0f green:82/255.0f blue:45/255.0f alpha:1.0];
}

+ (NSColor *)dustColor
{
	return [NSColor colorWithRed:236/255.0f green:214/255.0f blue:197/255.0f alpha:1.0];
}

@end
