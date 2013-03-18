//
//  Colours.h
//  ColoursDemo
//
//  Created by Ben Gordon on 3/17/13.
//  Copyright (c) 2013 Ben Gordon. All rights reserved.
//

#import <Foundation/Foundation.h>

// System Colors
#define ColorInfoBlue [UIColor colorWithRed:47/255.0f green:112/255.0f blue:225/255.0f alpha:1.0]
#define ColorSuccess [UIColor colorWithRed:25/255.0f green:188/255.0f blue:63/255.0f alpha:1.0]
#define ColorWarning [UIColor colorWithRed:221/255.0f green:170/255.0f blue:59/255.0f alpha:1.0]
#define ColorDanger [UIColor colorWithRed:229/255.0f green:0/255.0f blue:15/255.0f alpha:1.0]

// Grays
#define Color25PercentBlack [UIColor colorWithWhite:0.25 alpha:1.0 alpha:1.0];
#define Color50PercentBlack [UIColor colorWithWhite:0.5 alpha:1.0 alpha:1.0];
#define Color75PercentBlack [UIColor colorWithWhite:0.75 alpha:1.0 alpha:1.0];
#define ColorWarmGray [UIColor colorWithRed:133/255.0f green:117/255.0f blue:112/255.0f alpha:1.0]
#define ColorCoolGray [UIColor colorWithRed:118/255.0f green:122/255.0f blue:133/255.0f alpha:1.0]

// Blues
#define ColorTeal [UIColor colorWithRed:28/255.0f green:160/255.0f blue:170/255.0f alpha:1.0]
#define ColorSteelBlue [UIColor colorWithRed:103/255.0f green:153/255.0f blue:170/255.0f alpha:1.0]
#define ColorRobinEgg [UIColor colorWithRed:141/255.0f green:218/255.0f blue:247/255.0f alpha:1.0]
#define ColorPastelBlue [UIColor colorWithRed:99/255.0f green:161/255.0f blue:247/255.0f alpha:1.0]

// Greens
#define ColorEmerald [UIColor colorWithRed:1/255.0f green:152/255.0f blue:117/255.0f alpha:1.0]
#define ColorGrass [UIColor colorWithRed:99/255.0f green:214/255.0f blue:74/255.0f alpha:1.0]
#define ColorPastelGreen [UIColor colorWithRed:126/255.0f green:242/255.0f blue:124/255.0f alpha:1.0]
#define ColorSeafoam [UIColor colorWithRed:77/255.0f green:226/255.0f blue:140/255.0f alpha:1.0]
#define ColorPaleGreen [UIColor colorWithRed:176/255.0f green:226/255.0f blue:172/255.0f alpha:1.0]

// Reds
#define ColorSalmon [UIColor colorWithRed:233/255.0f green:87/255.0f blue:95/255.0f alpha:1.0]
#define ColorBrickRed [UIColor colorWithRed:151/255.0f green:27/255.0f blue:16/255.0f alpha:1.0]
#define ColorEasterPink [UIColor colorWithRed:241/255.0f green:167/255.0f blue:162/255.0f alpha:1.0]
#define ColorGrapefruit [UIColor colorWithRed:228/255.0f green:31/255.0f blue:54/255.0f alpha:1.0]
#define ColorPink [UIColor colorWithRed:255/255.0f green:95/255.0f blue:154/255.0f alpha:1.0]

// Purples
#define ColorEggplant [UIColor colorWithRed:105/255.0f green:5/255.0f blue:98/255.0f alpha:1.0]
#define ColorPastelPurple [UIColor colorWithRed:207/255.0f green:100/255.0f blue:235/255.0f alpha:1.0]
#define ColorPalePurple [UIColor colorWithRed:229/255.0f green:180/255.0f blue:235/255.0f alpha:1.0]
#define ColorCoolPurple [UIColor colorWithRed:140/255.0f green:93/255.0f blue:228/255.0f alpha:1.0]

// Yellows
#define ColorGoldenrod [UIColor colorWithRed:215/255.0f green:170/255.0f blue:51/255.0f alpha:1.0]
#define ColorYellowGreen [UIColor colorWithRed:192/255.0f green:242/255.0f blue:39/255.0f alpha:1.0]
#define ColorBanana [UIColor colorWithRed:229/255.0f green:227/255.0f blue:58/255.0f alpha:1.0]

// Oranges
#define ColorPeach [UIColor colorWithRed:242/255.0f green:187/255.0f blue:97/255.0f alpha:1.0]
#define ColorBurntOrange [UIColor colorWithRed:184/255.0f green:102/255.0f blue:37/255.0f alpha:1.0]
#define ColorPastelOrange [UIColor colorWithRed:248/255.0f green:197/255.0f blue:143/255.0f alpha:1.0]

@interface Colours : NSObject

// Color Methods
+(UIColor *)colorFromHex:(NSString *)hexString;
+(NSArray *)rgbaArrayFromColor:(UIColor *)color;


@end
