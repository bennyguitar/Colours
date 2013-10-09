//
//  UIColor+Colours.m
//  ColoursDemo
//
//  Created by Jesper on 4/4/13.
//  Copyright (c) 2013 Ben Gordon. All rights reserved.
//

#import "UIColor+Colours.h"

@implementation UIColor (Colours)

#pragma mark - UIColor from Hex

+ (UIColor *)colorFromHexString:(NSString *)hexString
{
    unsigned rgbValue = 0;
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
	
    [scanner scanHexInt:&rgbValue];
	
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

#pragma mark - UIColor from Array

+ (UIColor *)colorWithRGBAArray:(NSArray *)rgbaArray {
    // Takes an array of RGBA int's, and makes a UIColor (shorthand colorWithRed:Green:Blue:Alpha:
    return [UIColor colorWithRed:(int)rgbaArray[0]/255.0 green:(int)rgbaArray[1]/255.0 blue:(int)rgbaArray[2]/255.0 alpha:(int)rgbaArray[3]/255.0];
}

#pragma mark - Hex from UIColor

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

#pragma mark - RGBA from UIColor

- (NSArray *)rgbaArray
{
    // Takes a UIColor and returns R,G,B,A values in NSNumber form
    float r=0,g=0,b=0,a=0;
    
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
    return @[[NSNumber numberWithFloat:r],[NSNumber numberWithFloat:g],[NSNumber numberWithFloat:b],[NSNumber numberWithFloat:a]];
}

-(NSDictionary *)rgbaDict {
    // Takes UIColor and returns RGBA values in a dictionary as NSNumbers
    float r=0,g=0,b=0,a=0;
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
    
    return @{@"r":[NSNumber numberWithFloat:r], @"g":[NSNumber numberWithFloat:g], @"b":[NSNumber numberWithFloat:b], @"a":[NSNumber numberWithFloat:a]};
}

#pragma mark - HSBA from UIColor

- (NSArray *)hsbaArray
{
    // Takes a UIColor and returns Hue,Saturation,Brightness,Alpha values in NSNumber form
    float h=0,s=0,b=0,a=0;
    
    if ([self respondsToSelector:@selector(getHue:saturation:brightness:alpha:)]) {
        [self getHue:&h saturation:&s brightness:&b alpha:&a];
    }
    
    return @[[NSNumber numberWithFloat:h],[NSNumber numberWithFloat:s],[NSNumber numberWithFloat:b],[NSNumber numberWithFloat:a]];
}

-(NSDictionary *)hsbaDict {
    // Takes a UIColor and returns Hue,Saturation,Brightness,Alpha values in NSNumber form
    float h=0,s=0,b=0,a=0;
    
    if ([self respondsToSelector:@selector(getHue:saturation:brightness:alpha:)]) {
        [self getHue:&h saturation:&s brightness:&b alpha:&a];
    }
    
    return @{@"h":[NSNumber numberWithFloat:h],@"s":[NSNumber numberWithFloat:s],@"b":[NSNumber numberWithFloat:b],@"a":[NSNumber numberWithFloat:a]};
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
            return [UIColor analagousColorsFromHue:hue saturation:sat brightness:bright alpha:alpha];
        case ColorSchemeMonochromatic:
            return [UIColor monochromaticColorsFromHue:hue saturation:sat brightness:bright alpha:alpha];
        case ColorSchemeTriad:
            return [UIColor triadColorsFromHue:hue saturation:sat brightness:bright alpha:alpha];
        case ColorSchemeComplementary:
            return [UIColor complementaryColorsFromHue:hue saturation:sat brightness:bright alpha:alpha];
        default:
            return nil;
    }
}


#pragma mark - Color Scheme Generation - Helper methods

+ (NSArray *)analagousColorsFromHue:(float)h saturation:(float)s brightness:(float)b alpha:(float)a
{
    UIColor *colorAbove1 = [UIColor colorWithHue:[UIColor addDegrees:15 toDegree:h]/360 saturation:(s-5)/100 brightness:(b-5)/100 alpha:a];
    UIColor *colorAbove2 = [UIColor colorWithHue:[UIColor addDegrees:30 toDegree:h]/360 saturation:(s-5)/100 brightness:(b-10)/100 alpha:a];
    UIColor *colorBelow1 = [UIColor colorWithHue:[UIColor addDegrees:-15 toDegree:h]/360 saturation:(s-5)/100 brightness:(b-5)/100 alpha:a];
    UIColor *colorBelow2 = [UIColor colorWithHue:[UIColor addDegrees:-30 toDegree:h]/360 saturation:(s-5)/100 brightness:(b-10)/100 alpha:a];
    
    return @[colorAbove2,colorAbove1,colorBelow1,colorBelow2];
}

+ (NSArray *)monochromaticColorsFromHue:(float)h saturation:(float)s brightness:(float)b alpha:(float)a
{
    UIColor *colorAbove1 = [UIColor colorWithHue:h/360 saturation:s/100 brightness:(b/2)/100 alpha:a];
    UIColor *colorAbove2 = [UIColor colorWithHue:h/360 saturation:(s/2)/100 brightness:(b/3)/100 alpha:a];
    UIColor *colorBelow1 = [UIColor colorWithHue:h/360 saturation:(s/3)/100 brightness:(2*b/3)/100 alpha:a];
    UIColor *colorBelow2 = [UIColor colorWithHue:h/360 saturation:s/100 brightness:(4*b/5)/100 alpha:a];
    
    return @[colorAbove2,colorAbove1,colorBelow1,colorBelow2];
}

+ (NSArray *)triadColorsFromHue:(float)h saturation:(float)s brightness:(float)b alpha:(float)a
{
    UIColor *colorAbove1 = [UIColor colorWithHue:[UIColor addDegrees:120 toDegree:h]/360 saturation:s/100 brightness:b/100 alpha:a];
    UIColor *colorAbove2 = [UIColor colorWithHue:[UIColor addDegrees:120 toDegree:h]/360 saturation:(7*s/6)/100 brightness:(b-5)/100 alpha:a];
    UIColor *colorBelow1 = [UIColor colorWithHue:[UIColor addDegrees:240 toDegree:h]/360 saturation:s/100 brightness:b/100 alpha:a];
    UIColor *colorBelow2 = [UIColor colorWithHue:[UIColor addDegrees:240 toDegree:h]/360 saturation:(7*s/6)/100 brightness:(b-5)/100 alpha:a];
    
    return @[colorAbove2,colorAbove1,colorBelow1,colorBelow2];
}

+ (NSArray *)complementaryColorsFromHue:(float)h saturation:(float)s brightness:(float)b alpha:(float)a
{
    UIColor *colorAbove1 = [UIColor colorWithHue:h/360 saturation:(5*s/7)/100 brightness:b/100 alpha:a];
    UIColor *colorAbove2 = [UIColor colorWithHue:h/360 saturation:s/100 brightness:(4*b/5)/100 alpha:a];
    UIColor *colorBelow1 = [UIColor colorWithHue:[UIColor addDegrees:180 toDegree:h]/360 saturation:s/100 brightness:b/100 alpha:a];
    UIColor *colorBelow2 = [UIColor colorWithHue:[UIColor addDegrees:180 toDegree:h]/360 saturation:(5*s/7)/100 brightness:b/100 alpha:a];
    
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

- (UIColor *)blackOrWhiteContrastingColor {
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    CGFloat red = components[0];
    CGFloat green = components[1];
    CGFloat blue = components[2];
    
    double a = 1 - ( (0.299 * red) + (0.587 * green) + (0.114 * blue));
    if ( a < 0.5) {
        //return black
        return [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    } else {
        //return white
        return [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    }
}

#pragma mark - System Colors

+ (UIColor *)infoBlueColor
{
	return [UIColor colorWithRed:47/255.0f green:112/255.0f blue:225/255.0f alpha:1.0];
}

+ (UIColor *)successColor
{
	return [UIColor colorWithRed:25/255.0f green:188/255.0f blue:63/255.0f alpha:1.0];
}

+ (UIColor *)warningColor
{
	return [UIColor colorWithRed:221/255.0f green:170/255.0f blue:59/255.0f alpha:1.0];
}

+ (UIColor *)dangerColor
{
	return [UIColor colorWithRed:229/255.0f green:0/255.0f blue:15/255.0f alpha:1.0];
}

#pragma mark - Whites

+ (UIColor *)antiqueWhiteColor
{
	return [UIColor colorWithRed:250/255.0f green:235/255.0f blue:215/255.0f alpha:1.0];
}

+ (UIColor *)oldLaceColor
{
	return [UIColor colorWithRed:253/255.0f green:245/255.0f blue:230/255.0f alpha:1.0];
}

+ (UIColor *)ivoryColor
{
	return [UIColor colorWithRed:255/255.0f green:255/255.0f blue:240/255.0f alpha:1.0];
}

+ (UIColor *)seashellColor
{
	return [UIColor colorWithRed:255/255.0f green:245/255.0f blue:238/255.0f alpha:1.0];
}

+ (UIColor *)ghostWhiteColor
{
	return [UIColor colorWithRed:248/255.0f green:248/255.0f blue:255/255.0f alpha:1.0];
}

+ (UIColor *)snowColor
{
	return [UIColor colorWithRed:255/255.0f green:250/255.0f blue:250/255.0f alpha:1.0];
}

+ (UIColor *)linenColor
{
	return [UIColor colorWithRed:250/255.0f green:240/255.0f blue:230/255.0f alpha:1.0];
}

#pragma mark - Grays

+ (UIColor *)black25PercentColor
{
	return [UIColor colorWithWhite:0.25 alpha:1.0];
}

+ (UIColor *)black50PercentColor
{
	return [UIColor colorWithWhite:0.5  alpha:1.0];
}

+ (UIColor *)black75PercentColor
{
	return [UIColor colorWithWhite:0.75 alpha:1.0];
}

+ (UIColor *)warmGrayColor
{
	return [UIColor colorWithRed:133/255.0f green:117/255.0f blue:112/255.0f alpha:1.0];
}

+ (UIColor *)coolGrayColor
{
	return [UIColor colorWithRed:118/255.0f green:122/255.0f blue:133/255.0f alpha:1.0];
}

+ (UIColor *)charcoalColor
{
	return [UIColor colorWithRed:34/255.0f green:34/255.0f blue:34/255.0f alpha:1.0];
}

#pragma mark - Blues

+ (UIColor *)tealColor
{
	return [UIColor colorWithRed:28/255.0f green:160/255.0f blue:170/255.0f alpha:1.0];
}

+ (UIColor *)steelBlueColor
{
	return [UIColor colorWithRed:103/255.0f green:153/255.0f blue:170/255.0f alpha:1.0];
}

+ (UIColor *)robinEggColor
{
	return [UIColor colorWithRed:141/255.0f green:218/255.0f blue:247/255.0f alpha:1.0];
}

+ (UIColor *)pastelBlueColor
{
	return [UIColor colorWithRed:99/255.0f green:161/255.0f blue:247/255.0f alpha:1.0];
}

+ (UIColor *)turquoiseColor
{
	return [UIColor colorWithRed:112/255.0f green:219/255.0f blue:219/255.0f alpha:1.0];
}

+ (UIColor *)skyBlueColor
{
	return [UIColor colorWithRed:0/255.0f green:178/255.0f blue:238/255.0f alpha:1.0];
}

+ (UIColor *)indigoColor
{
	return [UIColor colorWithRed:13/255.0f green:79/255.0f blue:139/255.0f alpha:1.0];
}

+ (UIColor *)denimColor
{
	return [UIColor colorWithRed:67/255.0f green:114/255.0f blue:170/255.0f alpha:1.0];
}

+ (UIColor *)blueberryColor
{
	return [UIColor colorWithRed:89/255.0f green:113/255.0f blue:173/255.0f alpha:1.0];
}

+ (UIColor *)cornflowerColor
{
	return [UIColor colorWithRed:100/255.0f green:149/255.0f blue:237/255.0f alpha:1.0];
}

+ (UIColor *)babyBlueColor
{
	return [UIColor colorWithRed:190/255.0f green:220/255.0f blue:230/255.0f alpha:1.0];
}

+ (UIColor *)midnightBlueColor
{
	return [UIColor colorWithRed:13/255.0f green:26/255.0f blue:35/255.0f alpha:1.0];
}

+ (UIColor *)fadedBlueColor
{
	return [UIColor colorWithRed:23/255.0f green:137/255.0f blue:155/255.0f alpha:1.0];
}

+ (UIColor *)icebergColor
{
	return [UIColor colorWithRed:200/255.0f green:213/255.0f blue:219/255.0f alpha:1.0];
}

+ (UIColor *)waveColor
{
	return [UIColor colorWithRed:102/255.0f green:169/255.0f blue:251/255.0f alpha:1.0];
}

#pragma mark - Greens

+ (UIColor *)emeraldColor
{
	return [UIColor colorWithRed:1/255.0f green:152/255.0f blue:117/255.0f alpha:1.0];
}

+ (UIColor *)grassColor
{
	return [UIColor colorWithRed:99/255.0f green:214/255.0f blue:74/255.0f alpha:1.0];
}

+ (UIColor *)pastelGreenColor
{
	return [UIColor colorWithRed:126/255.0f green:242/255.0f blue:124/255.0f alpha:1.0];
}

+ (UIColor *)seafoamColor
{
	return [UIColor colorWithRed:77/255.0f green:226/255.0f blue:140/255.0f alpha:1.0];
}

+ (UIColor *)paleGreenColor
{
	return [UIColor colorWithRed:176/255.0f green:226/255.0f blue:172/255.0f alpha:1.0];
}

+ (UIColor *)cactusGreenColor
{
	return [UIColor colorWithRed:99/255.0f green:111/255.0f blue:87/255.0f alpha:1.0];
}

+ (UIColor *)chartreuseColor
{
	return [UIColor colorWithRed:69/255.0f green:139/255.0f blue:0/255.0f alpha:1.0];
}

+ (UIColor *)hollyGreenColor
{
	return [UIColor colorWithRed:32/255.0f green:87/255.0f blue:14/255.0f alpha:1.0];
}

+ (UIColor *)oliveColor
{
	return [UIColor colorWithRed:91/255.0f green:114/255.0f blue:34/255.0f alpha:1.0];
}

+ (UIColor *)oliveDrabColor
{
	return [UIColor colorWithRed:107/255.0f green:142/255.0f blue:35/255.0f alpha:1.0];
}

+ (UIColor *)moneyGreenColor
{
	return [UIColor colorWithRed:134/255.0f green:198/255.0f blue:124/255.0f alpha:1.0];
}

+ (UIColor *)honeydewColor
{
	return [UIColor colorWithRed:216/255.0f green:255/255.0f blue:231/255.0f alpha:1.0];
}

+ (UIColor *)limeColor
{
	return [UIColor colorWithRed:56/255.0f green:237/255.0f blue:56/255.0f alpha:1.0];
}

+ (UIColor *)cardTableColor
{
	return [UIColor colorWithRed:87/255.0f green:121/255.0f blue:107/255.0f alpha:1.0];
}

#pragma mark - Reds

+ (UIColor *)salmonColor
{
	return [UIColor colorWithRed:233/255.0f green:87/255.0f blue:95/255.0f alpha:1.0];
}

+ (UIColor *)brickRedColor
{
	return [UIColor colorWithRed:151/255.0f green:27/255.0f blue:16/255.0f alpha:1.0];
}

+ (UIColor *)easterPinkColor
{
	return [UIColor colorWithRed:241/255.0f green:167/255.0f blue:162/255.0f alpha:1.0];
}

+ (UIColor *)grapefruitColor
{
	return [UIColor colorWithRed:228/255.0f green:31/255.0f blue:54/255.0f alpha:1.0];
}

+ (UIColor *)pinkColor
{
	return [UIColor colorWithRed:255/255.0f green:95/255.0f blue:154/255.0f alpha:1.0];
}

+ (UIColor *)indianRedColor
{
	return [UIColor colorWithRed:205/255.0f green:92/255.0f blue:92/255.0f alpha:1.0];
}

+ (UIColor *)strawberryColor
{
	return [UIColor colorWithRed:190/255.0f green:38/255.0f blue:37/255.0f alpha:1.0];
}

+ (UIColor *)coralColor
{
	return [UIColor colorWithRed:240/255.0f green:128/255.0f blue:128/255.0f alpha:1.0];
}

+ (UIColor *)maroonColor
{
	return [UIColor colorWithRed:80/255.0f green:4/255.0f blue:28/255.0f alpha:1.0];
}

+ (UIColor *)watermelonColor
{
	return [UIColor colorWithRed:242/255.0f green:71/255.0f blue:63/255.0f alpha:1.0];
}

+ (UIColor *)tomatoColor
{
	return [UIColor colorWithRed:255/255.0f green:99/255.0f blue:71/255.0f alpha:1.0];
}

+ (UIColor *)pinkLipstickColor
{
	return [UIColor colorWithRed:255/255.0f green:105/255.0f blue:180/255.0f alpha:1.0];
}

+ (UIColor *)paleRoseColor
{
	return [UIColor colorWithRed:255/255.0f green:228/255.0f blue:225/255.0f alpha:1.0];
}

+ (UIColor *)crimsonColor
{
	return [UIColor colorWithRed:187/255.0f green:18/255.0f blue:36/255.0f alpha:1.0];
}

#pragma mark - Purples

+ (UIColor *)eggplantColor
{
	return [UIColor colorWithRed:105/255.0f green:5/255.0f blue:98/255.0f alpha:1.0];
}

+ (UIColor *)pastelPurpleColor
{
	return [UIColor colorWithRed:207/255.0f green:100/255.0f blue:235/255.0f alpha:1.0];
}

+ (UIColor *)palePurpleColor
{
	return [UIColor colorWithRed:229/255.0f green:180/255.0f blue:235/255.0f alpha:1.0];
}

+ (UIColor *)coolPurpleColor
{
	return [UIColor colorWithRed:140/255.0f green:93/255.0f blue:228/255.0f alpha:1.0];
}

+ (UIColor *)violetColor
{
	return [UIColor colorWithRed:191/255.0f green:95/255.0f blue:255/255.0f alpha:1.0];
}

+ (UIColor *)plumColor
{
	return [UIColor colorWithRed:139/255.0f green:102/255.0f blue:139/255.0f alpha:1.0];
}

+ (UIColor *)lavenderColor
{
	return [UIColor colorWithRed:204/255.0f green:153/255.0f blue:204/255.0f alpha:1.0];
}

+ (UIColor *)raspberryColor
{
	return [UIColor colorWithRed:135/255.0f green:38/255.0f blue:87/255.0f alpha:1.0];
}

+ (UIColor *)fuschiaColor
{
	return [UIColor colorWithRed:255/255.0f green:20/255.0f blue:147/255.0f alpha:1.0];
}

+ (UIColor *)grapeColor
{
	return [UIColor colorWithRed:54/255.0f green:11/255.0f blue:88/255.0f alpha:1.0];
}

+ (UIColor *)periwinkleColor
{
	return [UIColor colorWithRed:135/255.0f green:159/255.0f blue:237/255.0f alpha:1.0];
}

+ (UIColor *)orchidColor
{
	return [UIColor colorWithRed:218/255.0f green:112/255.0f blue:214/255.0f alpha:1.0];
}

#pragma mark - Yellows

+ (UIColor *)goldenrodColor
{
	return [UIColor colorWithRed:215/255.0f green:170/255.0f blue:51/255.0f alpha:1.0];
}

+ (UIColor *)yellowGreenColor
{
	return [UIColor colorWithRed:192/255.0f green:242/255.0f blue:39/255.0f alpha:1.0];
}

+ (UIColor *)bananaColor
{
	return [UIColor colorWithRed:229/255.0f green:227/255.0f blue:58/255.0f alpha:1.0];
}

+ (UIColor *)mustardColor
{
	return [UIColor colorWithRed:205/255.0f green:171/255.0f blue:45/255.0f alpha:1.0];
}

+ (UIColor *)buttermilkColor
{
	return [UIColor colorWithRed:254/255.0f green:241/255.0f blue:181/255.0f alpha:1.0];
}

+ (UIColor *)goldColor
{
	return [UIColor colorWithRed:139/255.0f green:117/255.0f blue:18/255.0f alpha:1.0];
}

+ (UIColor *)creamColor
{
	return [UIColor colorWithRed:240/255.0f green:226/255.0f blue:187/255.0f alpha:1.0];
}

+ (UIColor *)lightCreamColor
{
	return [UIColor colorWithRed:240/255.0f green:238/255.0f blue:215/255.0f alpha:1.0];
}

+ (UIColor *)wheatColor
{
	return [UIColor colorWithRed:240/255.0f green:238/255.0f blue:215/255.0f alpha:1.0];
}

+ (UIColor *)beigeColor
{
	return [UIColor colorWithRed:245/255.0f green:245/255.0f blue:220/255.0f alpha:1.0];
}

#pragma mark - Oranges

+ (UIColor *)peachColor
{
	return [UIColor colorWithRed:242/255.0f green:187/255.0f blue:97/255.0f alpha:1.0];
}

+ (UIColor *)burntOrangeColor
{
	return [UIColor colorWithRed:184/255.0f green:102/255.0f blue:37/255.0f alpha:1.0];
}

+ (UIColor *)pastelOrangeColor
{
	return [UIColor colorWithRed:248/255.0f green:197/255.0f blue:143/255.0f alpha:1.0];
}

+ (UIColor *)cantaloupeColor
{
	return [UIColor colorWithRed:250/255.0f green:154/255.0f blue:79/255.0f alpha:1.0];
}

+ (UIColor *)carrotColor
{
	return [UIColor colorWithRed:237/255.0f green:145/255.0f blue:33/255.0f alpha:1.0];
}

+ (UIColor *)mandarinColor
{
	return [UIColor colorWithRed:247/255.0f green:145/255.0f blue:55/255.0f alpha:1.0];
}

#pragma mark - Browns

+ (UIColor *)chiliPowderColor
{
	return [UIColor colorWithRed:199/255.0f green:63/255.0f blue:23/255.0f alpha:1.0];
}

+ (UIColor *)burntSiennaColor
{
	return [UIColor colorWithRed:138/255.0f green:54/255.0f blue:15/255.0f alpha:1.0];
}

+ (UIColor *)chocolateColor
{
	return [UIColor colorWithRed:94/255.0f green:38/255.0f blue:5/255.0f alpha:1.0];
}

+ (UIColor *)coffeeColor
{
	return [UIColor colorWithRed:141/255.0f green:60/255.0f blue:15/255.0f alpha:1.0];
}

+ (UIColor *)cinnamonColor
{
	return [UIColor colorWithRed:123/255.0f green:63/255.0f blue:9/255.0f alpha:1.0];
}

+ (UIColor *)almonColor
{
	return [UIColor colorWithRed:196/255.0f green:142/255.0f blue:72/255.0f alpha:1.0];
}

+ (UIColor *)eggshellColor
{
	return [UIColor colorWithRed:252/255.0f green:230/255.0f blue:201/255.0f alpha:1.0];
}

+ (UIColor *)sandColor
{
	return [UIColor colorWithRed:222/255.0f green:182/255.0f blue:151/255.0f alpha:1.0];
}

+ (UIColor *)mudColor
{
	return [UIColor colorWithRed:70/255.0f green:45/255.0f blue:29/255.0f alpha:1.0];
}

+ (UIColor *)siennaColor
{
	return [UIColor colorWithRed:160/255.0f green:82/255.0f blue:45/255.0f alpha:1.0];
}

+ (UIColor *)dustColor
{
	return [UIColor colorWithRed:236/255.0f green:214/255.0f blue:197/255.0f alpha:1.0];
}

@end
