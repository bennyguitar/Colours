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

@implementation ColorClass (Colours)


#pragma mark Color from Hex
+ (ColorClass *)colorFromHexString:(NSString *)hexString
{
    unsigned rgbValue = 0;
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
	
    [scanner scanHexInt:&rgbValue];
	
    return [ColorClass colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
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
+ (ColorClass *)colorFromRGBAArray:(NSArray *)rgbaArray
{
    if (rgbaArray.count < 4) {
        return [ColorClass clearColor];
    }
    // Takes an array of RGBA float's as NSNumbers, and makes a ColorClass (shorthand colorWithRed:Green:Blue:Alpha:
    return [ColorClass colorWithRed:[rgbaArray[0] floatValue] green:[rgbaArray[1] floatValue] blue:[rgbaArray[2] floatValue] alpha:[rgbaArray[3] floatValue]];
}

+ (ColorClass *)colorFromRGBADictionary:(NSDictionary *)rgbaDict
{
    if (rgbaDict[@"r"] && rgbaDict[@"g"] && rgbaDict[@"b"] && rgbaDict[@"a"]) {
        return [ColorClass colorWithRed:[rgbaDict[@"r"] floatValue] green:[rgbaDict[@"g"] floatValue] blue:[rgbaDict[@"b"] floatValue] alpha:[rgbaDict[@"a"] floatValue]];
    }
    
    return [ColorClass clearColor];
}


#pragma mark - RGBA from Color
- (NSArray *)rgbaArray
{
    // Takes a ColorClass and returns R,G,B,A values in NSNumber form
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
    // Takes ColorClass and returns RGBA values in a dictionary as NSNumbers
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
    // Takes a ColorClass and returns Hue,Saturation,Brightness,Alpha values in NSNumber form
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
    // Takes a ColorClass and returns Hue,Saturation,Brightness,Alpha values in NSNumber form
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
+ (ColorClass *)colorFromHSBAArray:(NSArray *)hsbaArray
{
    if (hsbaArray.count < 4) {
        return [ColorClass clearColor];
    }
    
    return [ColorClass colorWithHue:[hsbaArray[0] doubleValue] saturation:[hsbaArray[1] doubleValue] brightness:[hsbaArray[2] doubleValue] alpha:[hsbaArray[3] doubleValue]];
}

+ (ColorClass *)colorFromHSBADictionary:(NSDictionary *)hsbaDict
{
    if (hsbaDict[@"h"] && hsbaDict[@"s"] && hsbaDict[@"b"] && hsbaDict[@"a"]) {
        return [ColorClass colorWithHue:[hsbaDict[@"h"] doubleValue] saturation:[hsbaDict[@"s"] doubleValue] brightness:[hsbaDict[@"b"] doubleValue] alpha:[hsbaDict[@"a"] doubleValue]];
    }
    
    return [ColorClass clearColor];
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
            return [ColorClass analagousColorsFromHue:hue saturation:sat brightness:bright alpha:alpha];
        case ColorSchemeMonochromatic:
            return [ColorClass monochromaticColorsFromHue:hue saturation:sat brightness:bright alpha:alpha];
        case ColorSchemeTriad:
            return [ColorClass triadColorsFromHue:hue saturation:sat brightness:bright alpha:alpha];
        case ColorSchemeComplementary:
            return [ColorClass complementaryColorsFromHue:hue saturation:sat brightness:bright alpha:alpha];
        default:
            return nil;
    }
}


#pragma mark - Color Scheme Generation - Helper methods
+ (NSArray *)analagousColorsFromHue:(float)h saturation:(float)s brightness:(float)b alpha:(float)a
{
    ColorClass *colorAbove1 = [ColorClass colorWithHue:[ColorClass addDegrees:15 toDegree:h]/360 saturation:(s-5)/100 brightness:(b-5)/100 alpha:a];
    ColorClass *colorAbove2 = [ColorClass colorWithHue:[ColorClass addDegrees:30 toDegree:h]/360 saturation:(s-5)/100 brightness:(b-10)/100 alpha:a];
    ColorClass *colorBelow1 = [ColorClass colorWithHue:[ColorClass addDegrees:-15 toDegree:h]/360 saturation:(s-5)/100 brightness:(b-5)/100 alpha:a];
    ColorClass *colorBelow2 = [ColorClass colorWithHue:[ColorClass addDegrees:-30 toDegree:h]/360 saturation:(s-5)/100 brightness:(b-10)/100 alpha:a];
    
    return @[colorAbove2,colorAbove1,colorBelow1,colorBelow2];
}

+ (NSArray *)monochromaticColorsFromHue:(float)h saturation:(float)s brightness:(float)b alpha:(float)a
{
    ColorClass *colorAbove1 = [ColorClass colorWithHue:h/360 saturation:s/100 brightness:(b/2)/100 alpha:a];
    ColorClass *colorAbove2 = [ColorClass colorWithHue:h/360 saturation:(s/2)/100 brightness:(b/3)/100 alpha:a];
    ColorClass *colorBelow1 = [ColorClass colorWithHue:h/360 saturation:(s/3)/100 brightness:(2*b/3)/100 alpha:a];
    ColorClass *colorBelow2 = [ColorClass colorWithHue:h/360 saturation:s/100 brightness:(4*b/5)/100 alpha:a];
    
    return @[colorAbove2,colorAbove1,colorBelow1,colorBelow2];
}

+ (NSArray *)triadColorsFromHue:(float)h saturation:(float)s brightness:(float)b alpha:(float)a
{
    ColorClass *colorAbove1 = [ColorClass colorWithHue:[ColorClass addDegrees:120 toDegree:h]/360 saturation:s/100 brightness:b/100 alpha:a];
    ColorClass *colorAbove2 = [ColorClass colorWithHue:[ColorClass addDegrees:120 toDegree:h]/360 saturation:(7*s/6)/100 brightness:(b-5)/100 alpha:a];
    ColorClass *colorBelow1 = [ColorClass colorWithHue:[ColorClass addDegrees:240 toDegree:h]/360 saturation:s/100 brightness:b/100 alpha:a];
    ColorClass *colorBelow2 = [ColorClass colorWithHue:[ColorClass addDegrees:240 toDegree:h]/360 saturation:(7*s/6)/100 brightness:(b-5)/100 alpha:a];
    
    return @[colorAbove2,colorAbove1,colorBelow1,colorBelow2];
}

+ (NSArray *)complementaryColorsFromHue:(float)h saturation:(float)s brightness:(float)b alpha:(float)a
{
    ColorClass *colorAbove1 = [ColorClass colorWithHue:h/360 saturation:(5*s/7)/100 brightness:b/100 alpha:a];
    ColorClass *colorAbove2 = [ColorClass colorWithHue:h/360 saturation:s/100 brightness:(4*b/5)/100 alpha:a];
    ColorClass *colorBelow1 = [ColorClass colorWithHue:[ColorClass addDegrees:180 toDegree:h]/360 saturation:s/100 brightness:b/100 alpha:a];
    ColorClass *colorBelow2 = [ColorClass colorWithHue:[ColorClass addDegrees:180 toDegree:h]/360 saturation:(5*s/7)/100 brightness:b/100 alpha:a];
    
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
- (ColorClass *)blackOrWhiteContrastingColor
{
    NSArray *rgbaArray = [self rgbaArray];
    double a = 1 - ((0.299 * [rgbaArray[0] doubleValue]) + (0.587 * [rgbaArray[1] doubleValue]) + (0.114 * [rgbaArray[2] doubleValue]));
    return a < 0.5 ? [ColorClass blackColor] : [ColorClass whiteColor];
}


#pragma mark - Complementary Color
- (ColorClass *)complementaryColor
{
    NSMutableDictionary *hsba = [[self hsbaDictionary] mutableCopy];
    float newH = [ColorClass addDegrees:180.0f toDegree:([hsba[@"h"] floatValue]*360)];
    [hsba setObject:@(newH) forKey:@"h"];
    return [ColorClass colorFromHSBADictionary:hsba];
    
}


#pragma mark - System Colors
+ (ColorClass *)infoBlueColor
{
	return [ColorClass colorWithRed:47/255.0f green:112/255.0f blue:225/255.0f alpha:1.0];
}

+ (ColorClass *)successColor
{
	return [ColorClass colorWithRed:83/255.0f green:215/255.0f blue:106/255.0f alpha:1.0];
}

+ (ColorClass *)warningColor
{
	return [ColorClass colorWithRed:221/255.0f green:170/255.0f blue:59/255.0f alpha:1.0];
}

+ (ColorClass *)dangerColor
{
	return [ColorClass colorWithRed:229/255.0f green:0/255.0f blue:15/255.0f alpha:1.0];
}


#pragma mark - Whites
+ (ColorClass *)antiqueWhiteColor
{
	return [ColorClass colorWithRed:250/255.0f green:235/255.0f blue:215/255.0f alpha:1.0];
}

+ (ColorClass *)oldLaceColor
{
	return [ColorClass colorWithRed:253/255.0f green:245/255.0f blue:230/255.0f alpha:1.0];
}

+ (ColorClass *)ivoryColor
{
	return [ColorClass colorWithRed:255/255.0f green:255/255.0f blue:240/255.0f alpha:1.0];
}

+ (ColorClass *)seashellColor
{
	return [ColorClass colorWithRed:255/255.0f green:245/255.0f blue:238/255.0f alpha:1.0];
}

+ (ColorClass *)ghostWhiteColor
{
	return [ColorClass colorWithRed:248/255.0f green:248/255.0f blue:255/255.0f alpha:1.0];
}

+ (ColorClass *)snowColor
{
	return [ColorClass colorWithRed:255/255.0f green:250/255.0f blue:250/255.0f alpha:1.0];
}

+ (ColorClass *)linenColor
{
	return [ColorClass colorWithRed:250/255.0f green:240/255.0f blue:230/255.0f alpha:1.0];
}


#pragma mark - Grays
+ (ColorClass *)black25PercentColor
{
	return [ColorClass colorWithWhite:0.25 alpha:1.0];
}

+ (ColorClass *)black50PercentColor
{
	return [ColorClass colorWithWhite:0.5  alpha:1.0];
}

+ (ColorClass *)black75PercentColor
{
	return [ColorClass colorWithWhite:0.75 alpha:1.0];
}

+ (ColorClass *)warmGrayColor
{
	return [ColorClass colorWithRed:133/255.0f green:117/255.0f blue:112/255.0f alpha:1.0];
}

+ (ColorClass *)coolGrayColor
{
	return [ColorClass colorWithRed:118/255.0f green:122/255.0f blue:133/255.0f alpha:1.0];
}

+ (ColorClass *)charcoalColor
{
	return [ColorClass colorWithRed:34/255.0f green:34/255.0f blue:34/255.0f alpha:1.0];
}


#pragma mark - Blues
+ (ColorClass *)tealColor
{
	return [ColorClass colorWithRed:28/255.0f green:160/255.0f blue:170/255.0f alpha:1.0];
}

+ (ColorClass *)steelBlueColor
{
	return [ColorClass colorWithRed:103/255.0f green:153/255.0f blue:170/255.0f alpha:1.0];
}

+ (ColorClass *)robinEggColor
{
	return [ColorClass colorWithRed:141/255.0f green:218/255.0f blue:247/255.0f alpha:1.0];
}

+ (ColorClass *)pastelBlueColor
{
	return [ColorClass colorWithRed:99/255.0f green:161/255.0f blue:247/255.0f alpha:1.0];
}

+ (ColorClass *)turquoiseColor
{
	return [ColorClass colorWithRed:112/255.0f green:219/255.0f blue:219/255.0f alpha:1.0];
}

+ (ColorClass *)skyBlueColor
{
	return [ColorClass colorWithRed:0/255.0f green:178/255.0f blue:238/255.0f alpha:1.0];
}

+ (ColorClass *)indigoColor
{
	return [ColorClass colorWithRed:13/255.0f green:79/255.0f blue:139/255.0f alpha:1.0];
}

+ (ColorClass *)denimColor
{
	return [ColorClass colorWithRed:67/255.0f green:114/255.0f blue:170/255.0f alpha:1.0];
}

+ (ColorClass *)blueberryColor
{
	return [ColorClass colorWithRed:89/255.0f green:113/255.0f blue:173/255.0f alpha:1.0];
}

+ (ColorClass *)cornflowerColor
{
	return [ColorClass colorWithRed:100/255.0f green:149/255.0f blue:237/255.0f alpha:1.0];
}

+ (ColorClass *)babyBlueColor
{
	return [ColorClass colorWithRed:190/255.0f green:220/255.0f blue:230/255.0f alpha:1.0];
}

+ (ColorClass *)midnightBlueColor
{
	return [ColorClass colorWithRed:13/255.0f green:26/255.0f blue:35/255.0f alpha:1.0];
}

+ (ColorClass *)fadedBlueColor
{
	return [ColorClass colorWithRed:23/255.0f green:137/255.0f blue:155/255.0f alpha:1.0];
}

+ (ColorClass *)icebergColor
{
	return [ColorClass colorWithRed:200/255.0f green:213/255.0f blue:219/255.0f alpha:1.0];
}

+ (ColorClass *)waveColor
{
	return [ColorClass colorWithRed:102/255.0f green:169/255.0f blue:251/255.0f alpha:1.0];
}


#pragma mark - Greens
+ (ColorClass *)emeraldColor
{
	return [ColorClass colorWithRed:1/255.0f green:152/255.0f blue:117/255.0f alpha:1.0];
}

+ (ColorClass *)grassColor
{
	return [ColorClass colorWithRed:99/255.0f green:214/255.0f blue:74/255.0f alpha:1.0];
}

+ (ColorClass *)pastelGreenColor
{
	return [ColorClass colorWithRed:126/255.0f green:242/255.0f blue:124/255.0f alpha:1.0];
}

+ (ColorClass *)seafoamColor
{
	return [ColorClass colorWithRed:77/255.0f green:226/255.0f blue:140/255.0f alpha:1.0];
}

+ (ColorClass *)paleGreenColor
{
	return [ColorClass colorWithRed:176/255.0f green:226/255.0f blue:172/255.0f alpha:1.0];
}

+ (ColorClass *)cactusGreenColor
{
	return [ColorClass colorWithRed:99/255.0f green:111/255.0f blue:87/255.0f alpha:1.0];
}

+ (ColorClass *)chartreuseColor
{
	return [ColorClass colorWithRed:69/255.0f green:139/255.0f blue:0/255.0f alpha:1.0];
}

+ (ColorClass *)hollyGreenColor
{
	return [ColorClass colorWithRed:32/255.0f green:87/255.0f blue:14/255.0f alpha:1.0];
}

+ (ColorClass *)oliveColor
{
	return [ColorClass colorWithRed:91/255.0f green:114/255.0f blue:34/255.0f alpha:1.0];
}

+ (ColorClass *)oliveDrabColor
{
	return [ColorClass colorWithRed:107/255.0f green:142/255.0f blue:35/255.0f alpha:1.0];
}

+ (ColorClass *)moneyGreenColor
{
	return [ColorClass colorWithRed:134/255.0f green:198/255.0f blue:124/255.0f alpha:1.0];
}

+ (ColorClass *)honeydewColor
{
	return [ColorClass colorWithRed:216/255.0f green:255/255.0f blue:231/255.0f alpha:1.0];
}

+ (ColorClass *)limeColor
{
	return [ColorClass colorWithRed:56/255.0f green:237/255.0f blue:56/255.0f alpha:1.0];
}

+ (ColorClass *)cardTableColor
{
	return [ColorClass colorWithRed:87/255.0f green:121/255.0f blue:107/255.0f alpha:1.0];
}


#pragma mark - Reds
+ (ColorClass *)salmonColor
{
	return [ColorClass colorWithRed:233/255.0f green:87/255.0f blue:95/255.0f alpha:1.0];
}

+ (ColorClass *)brickRedColor
{
	return [ColorClass colorWithRed:151/255.0f green:27/255.0f blue:16/255.0f alpha:1.0];
}

+ (ColorClass *)easterPinkColor
{
	return [ColorClass colorWithRed:241/255.0f green:167/255.0f blue:162/255.0f alpha:1.0];
}

+ (ColorClass *)grapefruitColor
{
	return [ColorClass colorWithRed:228/255.0f green:31/255.0f blue:54/255.0f alpha:1.0];
}

+ (ColorClass *)pinkColor
{
	return [ColorClass colorWithRed:255/255.0f green:95/255.0f blue:154/255.0f alpha:1.0];
}

+ (ColorClass *)indianRedColor
{
	return [ColorClass colorWithRed:205/255.0f green:92/255.0f blue:92/255.0f alpha:1.0];
}

+ (ColorClass *)strawberryColor
{
	return [ColorClass colorWithRed:190/255.0f green:38/255.0f blue:37/255.0f alpha:1.0];
}

+ (ColorClass *)coralColor
{
	return [ColorClass colorWithRed:240/255.0f green:128/255.0f blue:128/255.0f alpha:1.0];
}

+ (ColorClass *)maroonColor
{
	return [ColorClass colorWithRed:80/255.0f green:4/255.0f blue:28/255.0f alpha:1.0];
}

+ (ColorClass *)watermelonColor
{
	return [ColorClass colorWithRed:242/255.0f green:71/255.0f blue:63/255.0f alpha:1.0];
}

+ (ColorClass *)tomatoColor
{
	return [ColorClass colorWithRed:255/255.0f green:99/255.0f blue:71/255.0f alpha:1.0];
}

+ (ColorClass *)pinkLipstickColor
{
	return [ColorClass colorWithRed:255/255.0f green:105/255.0f blue:180/255.0f alpha:1.0];
}

+ (ColorClass *)paleRoseColor
{
	return [ColorClass colorWithRed:255/255.0f green:228/255.0f blue:225/255.0f alpha:1.0];
}

+ (ColorClass *)crimsonColor
{
	return [ColorClass colorWithRed:187/255.0f green:18/255.0f blue:36/255.0f alpha:1.0];
}


#pragma mark - Purples
+ (ColorClass *)eggplantColor
{
	return [ColorClass colorWithRed:105/255.0f green:5/255.0f blue:98/255.0f alpha:1.0];
}

+ (ColorClass *)pastelPurpleColor
{
	return [ColorClass colorWithRed:207/255.0f green:100/255.0f blue:235/255.0f alpha:1.0];
}

+ (ColorClass *)palePurpleColor
{
	return [ColorClass colorWithRed:229/255.0f green:180/255.0f blue:235/255.0f alpha:1.0];
}

+ (ColorClass *)coolPurpleColor
{
	return [ColorClass colorWithRed:140/255.0f green:93/255.0f blue:228/255.0f alpha:1.0];
}

+ (ColorClass *)violetColor
{
	return [ColorClass colorWithRed:191/255.0f green:95/255.0f blue:255/255.0f alpha:1.0];
}

+ (ColorClass *)plumColor
{
	return [ColorClass colorWithRed:139/255.0f green:102/255.0f blue:139/255.0f alpha:1.0];
}

+ (ColorClass *)lavenderColor
{
	return [ColorClass colorWithRed:204/255.0f green:153/255.0f blue:204/255.0f alpha:1.0];
}

+ (ColorClass *)raspberryColor
{
	return [ColorClass colorWithRed:135/255.0f green:38/255.0f blue:87/255.0f alpha:1.0];
}

+ (ColorClass *)fuschiaColor
{
	return [ColorClass colorWithRed:255/255.0f green:20/255.0f blue:147/255.0f alpha:1.0];
}

+ (ColorClass *)grapeColor
{
	return [ColorClass colorWithRed:54/255.0f green:11/255.0f blue:88/255.0f alpha:1.0];
}

+ (ColorClass *)periwinkleColor
{
	return [ColorClass colorWithRed:135/255.0f green:159/255.0f blue:237/255.0f alpha:1.0];
}

+ (ColorClass *)orchidColor
{
	return [ColorClass colorWithRed:218/255.0f green:112/255.0f blue:214/255.0f alpha:1.0];
}


#pragma mark - Yellows
+ (ColorClass *)goldenrodColor
{
	return [ColorClass colorWithRed:215/255.0f green:170/255.0f blue:51/255.0f alpha:1.0];
}

+ (ColorClass *)yellowGreenColor
{
	return [ColorClass colorWithRed:192/255.0f green:242/255.0f blue:39/255.0f alpha:1.0];
}

+ (ColorClass *)bananaColor
{
	return [ColorClass colorWithRed:229/255.0f green:227/255.0f blue:58/255.0f alpha:1.0];
}

+ (ColorClass *)mustardColor
{
	return [ColorClass colorWithRed:205/255.0f green:171/255.0f blue:45/255.0f alpha:1.0];
}

+ (ColorClass *)buttermilkColor
{
	return [ColorClass colorWithRed:254/255.0f green:241/255.0f blue:181/255.0f alpha:1.0];
}

+ (ColorClass *)goldColor
{
	return [ColorClass colorWithRed:139/255.0f green:117/255.0f blue:18/255.0f alpha:1.0];
}

+ (ColorClass *)creamColor
{
	return [ColorClass colorWithRed:240/255.0f green:226/255.0f blue:187/255.0f alpha:1.0];
}

+ (ColorClass *)lightCreamColor
{
	return [ColorClass colorWithRed:240/255.0f green:238/255.0f blue:215/255.0f alpha:1.0];
}

+ (ColorClass *)wheatColor
{
	return [ColorClass colorWithRed:240/255.0f green:238/255.0f blue:215/255.0f alpha:1.0];
}

+ (ColorClass *)beigeColor
{
	return [ColorClass colorWithRed:245/255.0f green:245/255.0f blue:220/255.0f alpha:1.0];
}


#pragma mark - Oranges
+ (ColorClass *)peachColor
{
	return [ColorClass colorWithRed:242/255.0f green:187/255.0f blue:97/255.0f alpha:1.0];
}

+ (ColorClass *)burntOrangeColor
{
	return [ColorClass colorWithRed:184/255.0f green:102/255.0f blue:37/255.0f alpha:1.0];
}

+ (ColorClass *)pastelOrangeColor
{
	return [ColorClass colorWithRed:248/255.0f green:197/255.0f blue:143/255.0f alpha:1.0];
}

+ (ColorClass *)cantaloupeColor
{
	return [ColorClass colorWithRed:250/255.0f green:154/255.0f blue:79/255.0f alpha:1.0];
}

+ (ColorClass *)carrotColor
{
	return [ColorClass colorWithRed:237/255.0f green:145/255.0f blue:33/255.0f alpha:1.0];
}

+ (ColorClass *)mandarinColor
{
	return [ColorClass colorWithRed:247/255.0f green:145/255.0f blue:55/255.0f alpha:1.0];
}


#pragma mark - Browns
+ (ColorClass *)chiliPowderColor
{
	return [ColorClass colorWithRed:199/255.0f green:63/255.0f blue:23/255.0f alpha:1.0];
}

+ (ColorClass *)burntSiennaColor
{
	return [ColorClass colorWithRed:138/255.0f green:54/255.0f blue:15/255.0f alpha:1.0];
}

+ (ColorClass *)chocolateColor
{
	return [ColorClass colorWithRed:94/255.0f green:38/255.0f blue:5/255.0f alpha:1.0];
}

+ (ColorClass *)coffeeColor
{
	return [ColorClass colorWithRed:141/255.0f green:60/255.0f blue:15/255.0f alpha:1.0];
}

+ (ColorClass *)cinnamonColor
{
	return [ColorClass colorWithRed:123/255.0f green:63/255.0f blue:9/255.0f alpha:1.0];
}

+ (ColorClass *)almondColor
{
	return [ColorClass colorWithRed:196/255.0f green:142/255.0f blue:72/255.0f alpha:1.0];
}

+ (ColorClass *)eggshellColor
{
	return [ColorClass colorWithRed:252/255.0f green:230/255.0f blue:201/255.0f alpha:1.0];
}

+ (ColorClass *)sandColor
{
	return [ColorClass colorWithRed:222/255.0f green:182/255.0f blue:151/255.0f alpha:1.0];
}

+ (ColorClass *)mudColor
{
	return [ColorClass colorWithRed:70/255.0f green:45/255.0f blue:29/255.0f alpha:1.0];
}

+ (ColorClass *)siennaColor
{
	return [ColorClass colorWithRed:160/255.0f green:82/255.0f blue:45/255.0f alpha:1.0];
}

+ (ColorClass *)dustColor
{
	return [ColorClass colorWithRed:236/255.0f green:214/255.0f blue:197/255.0f alpha:1.0];
}

@end
