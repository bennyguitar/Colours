Colours for iOS
=============

A beautiful set of 100 predefined UIColors, and UIColor methods, ready to use in your next iOS project.

![ScreenShot](https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/iphone1.png)![ScreenShot](https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/iphone2.png)

## Installation ##

Drag the included **UIColor+Colours.h and UIColor+Colours.m** files into your project. They are located in the top-level directory. You can see a demo of how to use these with the included Xcode project as well.

Import UIColor+Colours.h into your ViewController.h file, and that's it.


## Using Colours ##

It's very simple. Whenever you set a property that is a UIColor, like self.view.backgroundColor, instead of doing something like <code>self.view.backgroundColor = [UIColor redColor]</code> use one of the new colors like so <code>self.view.backgroundColor = [UIColor tealColor]</code>

**System Colors**

* ColorInfoBlue
* ColorSuccess
* ColorWarning
* ColorDanger

**Whites**

* ColorAntiqueWhite
* ColorOldLace
* ColorIvory
* ColorSeashell
* ColorGhostWhite
* ColorSnow
* ColorLinen

**Grays**

* Color25PercentBlack
* Color50PercentBlack
* Color75PercentBlack
* ColorWarmGray
* ColorCoolGray
* ColorCharcoal

**Blues**

* ColorTeal
* ColorSteelBlue
* ColorRobinEgg
* ColorPastelBlue
* ColorTurquoise
* ColorSkyBlue
* ColorIndigo
* ColorDenim
* ColorBlueberry
* ColorCornflower
* ColorBabyBlue
* ColorMidnightBlue
* ColorFadedBlue
* ColorIceberg
* ColorWave

**Greens**

* ColorEmerald
* ColorGrass
* ColorPastelGreen
* ColorSeafoam
* ColorPaleGreen
* ColorCactusGreen
* ColorChartreuse
* ColorHollyGreen
* ColorOlive
* ColorOliveDrab
* ColorMoneyGreen
* ColorHoneydew
* ColorLime
* ColorCardTable

**Reds**

* ColorSalmon
* ColorBrickRed
* ColorEasterPink
* ColorGrapefruit
* ColorPink
* ColorIndianRed
* ColorStrawberry
* ColorCoral
* ColorMaroon
* ColorWatermelon
* ColorTomato
* ColorPinkLipstick
* ColorPaleRose
* ColorCrimson

**Purples**

* ColorEggplant
* ColorPastelPurple
* ColorPalePurple
* ColorCoolPurple
* ColorViolet
* ColorPlum
* ColorLavender
* ColorRaspberry
* ColorFuschia
* ColorGrape
* ColorPeriwinkle
* ColorOrchid

**Yellows**

* ColorGoldenrod
* ColorYellowGreen
* ColorBanana
* ColorMustard
* ColorButtermilk
* ColorGold
* ColorCream
* ColorLightCream
* ColorWheat
* ColorBeige

**Oranges**

* ColorPeach
* ColorBurntOrange
* ColorPastelOrange
* ColorCantaloupe
* ColorCarrot
* ColorMandarin

**Browns**

* ColorChiliPowder
* ColorBurntSienna
* ColorChocolate
* ColorCoffee
* ColorCinnamon
* ColorAlmond
* ColorEggshell
* ColorCoffee
* ColorSand
* ColorMud
* ColorSienna
* ColorDust

## Colours Methods ##

You can grab a UIColor from a hexString by calling colorFromHex:
```objc
UIColor *newColor = [UIColor colorFromHexString:@"#f587e4"];
```

You can also grab a Hex string by calling hexString:
```objc
NSString *hexString = [color hexString];
// Output: #8ddaf7
```

If you'd like the RGBA values of any UIColor, just call the rgbaArrayFromColor method. It returns an array of 4 NSNumbers, RGBA - in that order. Here's how you'd call this:
```objc
NSArray *colorArray = [self.view.backgroundColor rgbaArray];
float r = [colorArray[0] floatValue];
float g = [colorArray[1] floatValue];
float b = [colorArray[2] floatValue];
float a = [colorArray[3] floatValue];
```

## Generating Color Schemes ##

You can create a 5-color scheme based off of a UIColor using the following method. It takes in a UIColor and one of the ColorSchemeTypes defined in Colours. It returns an NSArray of 4 new UIColor objects to create a pretty nice color scheme that complements the root color you passed in.
```objc
NSArray *colorScheme = [color generateColorSchemeOfType:ColorSchemeType];
```

**ColorSchemeTypes**

* ColorSchemeAnalagous
* ColorSchemeMonochromatic
* ColorSchemeTriad
* ColorSchemeComplementary

## CocoaPods ##

<code>pod 'Colours', '~> 1.0.1'</code>

For help setting up and maintaining dependencies using CocoaPods check out this link: http://cocoapods.org/

Reap What I Sow!
================

This project is distributed under the standard MIT License. Please use this and twist it in whatever fashion you wish - and recommend any cool changes to help the code.
