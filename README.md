![ScreenShot](Screenshots/banner.png)

[![Build Status](https://travis-ci.org/bennyguitar/Colours.svg?branch=4.0)](https://travis-ci.org/bennyguitar/Colours)

[![Gitter chat](https://badges.gitter.im/bennyguitar/Colours.png)](https://gitter.im/bennyguitar/Colours)

## Installation

Drag the included **Colours.h** and **Colours.m** files into your project. They are located in the top-level directory. You can see a demo of how to use these with the included Xcode project as well.

<code>#import "Colours.h"</code> into the classes you want to use this category in and you're all set.

**Cocoapods**

<code>pod 'Colours'</code>

or, for Swift:

<code>pod 'Colours/Swift'</code>

**NSColor**

Colours supports <code>NSColor</code> out of the box! Just make sure you have the <code>AppKit</code> framework installed (it comes that way for a new application) and you will be set. This README uses UIColor for its examples, just substitute NSColor and the methods are all the same.

**Swift**

A Swift version of Colours now exists that contains everything in the Obj-C version except:

* Color Components Dictionary (use the tuples instead)
* Sorting/Comparing Colors
* Distance between Colors

Also, instead of dictionaries and arrays of color components, tuples are used instead. So instead of `[someRedColor rgbaArray]`, you would use `someRedColor.rgba()` which gives you a tuple of four `CGFloats` like `(1.0, 0.0, 0.0, 1.0)`. To get just the red value, you would write `someRedColor.rgba().r`.

## Table of Contents
* [Color Palette](#color-palette)
* [Using Predefined Colors](#using-predefined-colors)
* [Color Helper Methods](#color-helper-methods)
  * [Hex String](#hex-string)
  * [RGBA](#rgba)
  * [HSBA](#hsba)
  * [CIELAB](#cielab)
  * [CMYK](#cmyk)
  * [Color Components](#color-components)
  * [Darken/Lighten Components](#darkenlighten-colors)
  * [Black or White Contrasting Color](#black-or-white-contrasting-color)
  * [Complementary Color](#complementary-color)
* [Distance between 2 Colors](#distance-between-2-colors)
* [Generating Color Schemes](#generating-color-schemes)
* [Android](#android)
* [Xamarin](#xamarin)
* [Reap What I Sow!](#reap-what-i-sow)

## Color Palette

<table><tr><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/0.png" width="50" height="50" alt="infoBlueColor" /></td><td><b>infoBlueColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/1.png" width="50" height="50" alt="successColor" /></td><td><b>successColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/2.png" width="50" height="50" alt="warningColor" /></td><td><b>warningColor</b></td></tr><tr><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/3.png" width="50" height="50" alt="dangerColor" /></td><td><b>dangerColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/4.png" width="50" height="50" alt="antiqueWhiteColor" /></td><td><b>antiqueWhiteColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/5.png" width="50" height="50" alt="oldLaceColor" /></td><td><b>oldLaceColor</b></td></tr><tr><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/6.png" width="50" height="50" alt="ivoryColor" /></td><td><b>ivoryColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/7.png" width="50" height="50" alt="seashellColor" /></td><td><b>seashellColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/8.png" width="50" height="50" alt="ghostWhiteColor" /></td><td><b>ghostWhiteColor</b></td></tr><tr><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/9.png" width="50" height="50" alt="snowColor" /></td><td><b>snowColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/10.png" width="50" height="50" alt="linenColor" /></td><td><b>linenColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/11.png" width="50" height="50" alt="black25PercentColor" /></td><td><b>black25PercentColor</b></td></tr><tr><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/12.png" width="50" height="50" alt="black50PercentColor" /></td><td><b>black50PercentColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/13.png" width="50" height="50" alt="black75PercentColor" /></td><td><b>black75PercentColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/14.png" width="50" height="50" alt="warmGrayColor" /></td><td><b>warmGrayColor</b></td></tr><tr><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/15.png" width="50" height="50" alt="coolGrayColor" /></td><td><b>coolGrayColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/16.png" width="50" height="50" alt="charcoalColor" /></td><td><b>charcoalColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/17.png" width="50" height="50" alt="tealColor" /></td><td><b>tealColor</b></td></tr><tr><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/18.png" width="50" height="50" alt="steelBlueColor" /></td><td><b>steelBlueColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/19.png" width="50" height="50" alt="robinEggColor" /></td><td><b>robinEggColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/20.png" width="50" height="50" alt="pastelBlueColor" /></td><td><b>pastelBlueColor</b></td></tr><tr><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/21.png" width="50" height="50" alt="turquoiseColor" /></td><td><b>turquoiseColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/22.png" width="50" height="50" alt="skyBlueColor" /></td><td><b>skyBlueColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/23.png" width="50" height="50" alt="indigoColor" /></td><td><b>indigoColor</b></td></tr><tr><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/24.png" width="50" height="50" alt="denimColor" /></td><td><b>denimColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/25.png" width="50" height="50" alt="blueberryColor" /></td><td><b>blueberryColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/26.png" width="50" height="50" alt="cornflowerColor" /></td><td><b>cornflowerColor</b></td></tr><tr><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/27.png" width="50" height="50" alt="babyBlueColor" /></td><td><b>babyBlueColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/28.png" width="50" height="50" alt="midnightBlueColor" /></td><td><b>midnightBlueColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/29.png" width="50" height="50" alt="fadedBlueColor" /></td><td><b>fadedBlueColor</b></td></tr><tr><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/30.png" width="50" height="50" alt="icebergColor" /></td><td><b>icebergColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/31.png" width="50" height="50" alt="waveColor" /></td><td><b>waveColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/32.png" width="50" height="50" alt="emeraldColor" /></td><td><b>emeraldColor</b></td></tr><tr><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/33.png" width="50" height="50" alt="grassColor" /></td><td><b>grassColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/34.png" width="50" height="50" alt="pastelGreenColor" /></td><td><b>pastelGreenColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/35.png" width="50" height="50" alt="seafoamColor" /></td><td><b>seafoamColor</b></td></tr><tr><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/36.png" width="50" height="50" alt="paleGreenColor" /></td><td><b>paleGreenColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/37.png" width="50" height="50" alt="cactusGreenColor" /></td><td><b>cactusGreenColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/38.png" width="50" height="50" alt="chartreuseColor" /></td><td><b>chartreuseColor</b></td></tr><tr><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/39.png" width="50" height="50" alt="hollyGreenColor" /></td><td><b>hollyGreenColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/40.png" width="50" height="50" alt="oliveColor" /></td><td><b>oliveColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/41.png" width="50" height="50" alt="oliveDrabColor" /></td><td><b>oliveDrabColor</b></td></tr><tr><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/42.png" width="50" height="50" alt="moneyGreenColor" /></td><td><b>moneyGreenColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/43.png" width="50" height="50" alt="honeydewColor" /></td><td><b>honeydewColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/44.png" width="50" height="50" alt="limeColor" /></td><td><b>limeColor</b></td></tr><tr><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/45.png" width="50" height="50" alt="cardTableColor" /></td><td><b>cardTableColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/46.png" width="50" height="50" alt="salmonColor" /></td><td><b>salmonColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/47.png" width="50" height="50" alt="brickRedColor" /></td><td><b>brickRedColor</b></td></tr><tr><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/48.png" width="50" height="50" alt="easterPinkColor" /></td><td><b>easterPinkColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/49.png" width="50" height="50" alt="grapefruitColor" /></td><td><b>grapefruitColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/50.png" width="50" height="50" alt="pinkColor" /></td><td><b>pinkColor</b></td></tr><tr><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/51.png" width="50" height="50" alt="indianRedColor" /></td><td><b>indianRedColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/52.png" width="50" height="50" alt="strawberryColor" /></td><td><b>strawberryColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/53.png" width="50" height="50" alt="coralColor" /></td><td><b>coralColor</b></td></tr><tr><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/54.png" width="50" height="50" alt="maroonColor" /></td><td><b>maroonColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/55.png" width="50" height="50" alt="watermelonColor" /></td><td><b>watermelonColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/56.png" width="50" height="50" alt="tomatoColor" /></td><td><b>tomatoColor</b></td></tr><tr><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/57.png" width="50" height="50" alt="pinkLipstickColor" /></td><td><b>pinkLipstickColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/58.png" width="50" height="50" alt="paleRoseColor" /></td><td><b>paleRoseColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/59.png" width="50" height="50" alt="crimsonColor" /></td><td><b>crimsonColor</b></td></tr><tr><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/60.png" width="50" height="50" alt="eggplantColor" /></td><td><b>eggplantColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/61.png" width="50" height="50" alt="pastelPurpleColor" /></td><td><b>pastelPurpleColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/62.png" width="50" height="50" alt="palePurpleColor" /></td><td><b>palePurpleColor</b></td></tr><tr><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/63.png" width="50" height="50" alt="coolPurpleColor" /></td><td><b>coolPurpleColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/64.png" width="50" height="50" alt="violetColor" /></td><td><b>violetColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/65.png" width="50" height="50" alt="plumColor" /></td><td><b>plumColor</b></td></tr><tr><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/66.png" width="50" height="50" alt="lavenderColor" /></td><td><b>lavenderColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/67.png" width="50" height="50" alt="raspberryColor" /></td><td><b>raspberryColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/68.png" width="50" height="50" alt="fuschiaColor" /></td><td><b>fuschiaColor</b></td></tr><tr><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/69.png" width="50" height="50" alt="grapeColor" /></td><td><b>grapeColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/70.png" width="50" height="50" alt="periwinkleColor" /></td><td><b>periwinkleColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/71.png" width="50" height="50" alt="orchidColor" /></td><td><b>orchidColor</b></td></tr><tr><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/72.png" width="50" height="50" alt="goldenrodColor" /></td><td><b>goldenrodColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/73.png" width="50" height="50" alt="yellowGreenColor" /></td><td><b>yellowGreenColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/74.png" width="50" height="50" alt="bananaColor" /></td><td><b>bananaColor</b></td></tr><tr><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/75.png" width="50" height="50" alt="mustardColor" /></td><td><b>mustardColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/76.png" width="50" height="50" alt="buttermilkColor" /></td><td><b>buttermilkColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/77.png" width="50" height="50" alt="goldColor" /></td><td><b>goldColor</b></td></tr><tr><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/78.png" width="50" height="50" alt="creamColor" /></td><td><b>creamColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/79.png" width="50" height="50" alt="lightCreamColor" /></td><td><b>lightCreamColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/80.png" width="50" height="50" alt="wheatColor" /></td><td><b>wheatColor</b></td></tr><tr><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/81.png" width="50" height="50" alt="beigeColor" /></td><td><b>beigeColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/82.png" width="50" height="50" alt="peachColor" /></td><td><b>peachColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/83.png" width="50" height="50" alt="burntOrangeColor" /></td><td><b>burntOrangeColor</b></td></tr><tr><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/84.png" width="50" height="50" alt="pastelOrangeColor" /></td><td><b>pastelOrangeColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/85.png" width="50" height="50" alt="cantaloupeColor" /></td><td><b>cantaloupeColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/86.png" width="50" height="50" alt="carrotColor" /></td><td><b>carrotColor</b></td></tr><tr><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/87.png" width="50" height="50" alt="mandarinColor" /></td><td><b>mandarinColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/88.png" width="50" height="50" alt="chiliPowderColor" /></td><td><b>chiliPowderColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/89.png" width="50" height="50" alt="burntSiennaColor" /></td><td><b>burntSiennaColor</b></td></tr><tr><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/90.png" width="50" height="50" alt="chocolateColor" /></td><td><b>chocolateColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/91.png" width="50" height="50" alt="coffeeColor" /></td><td><b>coffeeColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/92.png" width="50" height="50" alt="cinnamonColor" /></td><td><b>cinnamonColor</b></td></tr><tr><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/93.png" width="50" height="50" alt="almondColor" /></td><td><b>almondColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/94.png" width="50" height="50" alt="eggshellColor" /></td><td><b>eggshellColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/95.png" width="50" height="50" alt="sandColor" /></td><td><b>sandColor</b></td></tr><tr><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/96.png" width="50" height="50" alt="mudColor" /></td><td><b>mudColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/97.png" width="50" height="50" alt="siennaColor" /></td><td><b>siennaColor</b></td><td><img src="https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/Colors/98.png" width="50" height="50" alt="dustColor" /></td><td><b>dustColor</b></td></tr></table>


## Using Predefined Colors

Colours was set up to be exactly like using an Apple predefined system color. For instance, to get a stark red, you type <code>[UIColor redColor]</code>. You don't get a lot of variation on this though without diving into the <code>colorWithRed:green:blue:alpha:</code> method and customizing the heck out of it. Well, I took the liberty of creating 100 colors to use in the same system color way that Apple uses with iOS. So instead of the redColor example earlier, just substitute one of the colors from the giant palette above, like so: <code>[UIColor indigoColor]</code>.


## Color Helper Methods

Beyond giving you a list of a ton of colors with no effort, this category also gives you some methods that allow different color manipulations and translations. Here's how you use these:

#### Hex String

You can convert the commonly seen hexadecimal color string (ahh, thank you CSS) to a UIColor, and vice versa, very easily using the following methods:

```objc
UIColor *newColor = [UIColor colorFromHexString:@"#f587e4"];
NSString *hexString = [newColor hexString];
```

#### RGBA

**RGBA Array to and from a UIColor**

The color -> array method creates an array of 4 NSNumbers representing the RGBA values of the color. These are not in the 0-255 range, but rather normalized in the 0-1 range. So if your R is 230, then it will be represented in the array as 0.902.

```objc
NSArray *colorArray = [[UIColor seafoamColor] rgbaArray];
UIColor *newColor = [UIColor colorFromRGBAArray:colorArray];
```

**RGBA Dictionary to and from a UIColor**

Similar to the array method above, this returns an NSDictionary that contains NSNumbers. Static keys are used to access the different color components of the dictionary. This allows you to use autocorrect to use the returned dictionary faster.

* `kColoursRGBA_R`
* `kColoursRGBA_G`
* `kColoursRGBA_B`
* `kColoursRGBA_A`

```objc
NSDictionary *colorDict = [[UIColor seafoamColor] rgbaDictionary];
UIColor *newColor = [UIColor colorFromRGBADictionary:colorDict];

// You can also get a single component like so:
NSNumber *r = colorDict[kColoursRGBA_R];
```

#### HSBA

Like both of the RGBA methods above, you can also get the Hue, Saturation and Brightness values from a UIColor and create an array or dictionary out of them, or vice versa. The colorDictionary returned also uses static keys like the RGBA version of this method. Here are the ones to use:

* `kColoursHSBA_H`
* `kColoursHSBA_S`
* `kColoursHSBA_B`
* `kColoursHSBA_A`

```objc
NSArray *colorArray = [[UIColor seafoamColor] hsbaArray];
NSDictionary *colorDict = [[UIColor seafoamColor] hsbaDictionary];

UIColor *newColor1 = [UIColor colorFromHSBAArray:colorArray];
UIColor *newColor2 = [UIColor colorFromHSBADictionary:colorDictionary];
```

#### CIELAB

Like both of the RGBA methods above, you can also get the CIE\_Lightness, CIE\_a and CIE\_b values from a UIColor and create an array or dictionary out of them, or vice versa. The colorDictionary returned also uses static keys like the RGBA version of this method. Here are the ones to use:

* `kColoursCIE_L`
* `kColoursCIE_A`
* `kColoursCIE_B`
* `kColoursCIE_alpha`

```objc
NSArray *colorArray = [[UIColor seafoamColor] CIE_LabArray];
NSDictionary *colorDict = [[UIColor seafoamColor] CIE_LabDictionary];

UIColor *newColor1 = [UIColor colorFromCIE_LabArray:colorArray];
UIColor *newColor2 = [UIColor colorFromCIE_LabDictionary:colorDictionary];
```

#### CMYK

Like both of the RGBA methods above, you can also get the CMYKY values from a UIColor and create an array or dictionary out of them, or vice versa. The colorDictionary returned also uses static keys like the RGBA version of this method. Here are the ones to use:

* `kColoursCMYK_C`
* `kColoursCMYK_M`
* `kColoursCMYK_Y`
* `kColoursCMYK_K`

```objc
NSArray *colorArray = [[UIColor seafoamColor] cmykArray];
NSDictionary *colorDict = [[UIColor seafoamColor] cmykDictionary];

UIColor *newColor1 = [UIColor colorFromCMYKArray:colorArray];
UIColor *newColor2 = [UIColor colorFromCMYKDictionary:colorDictionary];
```

#### Color Components

This method returns a dictionary containing values for each of the keys (RGBA, HSBA, CIE_LAB, CMYK) from above. This means you can get a hue value and a Lightness value from the same source. Here's how you use this:

```objc
NSDictionary *components = [someColor colorComponents];
CGFloat H = components[kColoursHSBA_H];
CGFloat L = components[kColoursCIE_L];
```

You can also retrieve singular values instead of the entire dictionary by calling any of these methods below on a UIColor. This will be significantly slower at getting all of the values for one color, versus just retrieving one. If you need more than one, call the specific array or dictionary method from above.

```obj
CGFloat R = [[UIColor tomatoColor] red];
CGFloat G = [[UIColor tomatoColor] green];
CGFloat B = [[UIColor tomatoColor] blue];
CGFloat H = [[UIColor tomatoColor] hue];
CGFloat S = [[UIColor tomatoColor] saturation];
CGFloat B = [[UIColor tomatoColor] brightness];
CGFloat CIE_L = [[UIColor tomatoColor] CIE_Lightness];
CGFloat CIE_A = [[UIColor tomatoColor] CIE_a];
CGFloat CIE_B = [[UIColor tomatoColor] CIE_b];
CGFloat alpha = [[UIColor tomatoColor] alpha];
```

#### Darken/Lighten Colors

You can darken or lighten a color by using these methods. The only parameter is a percentage float from 0 -> 1, so a 25% lighter color would use the parameter 0.25.

```objc
UIColor *lighterColor = [[UIColor seafoamColor] lighten:0.25f];
UIColor *darkerColor = [[UIColor seafoamColor] darken:0.25f];
```

#### Black or White Contrasting Color

A lot of times you may want to put text on top of a view that is a certain color, and you want to be sure that it will look good on top of it. With this method you will return either white or black, depending on the how well each of them contrast on top of it. Here's how you use this:

```objc
UIColor *contrastingColor = [[UIColor seafoamColor] blackOrWhiteContrastingColor];
```

#### Complementary Color

This method will create a UIColor instance that is the exact opposite color from another UIColor on the color wheel. The same saturation and brightness are preserved, just the hue is changed.

```objc
UIColor *complementary = [[UIColor seafoamColor] complementaryColor];
```

## Distance between 2 Colors

`5.1.0 +`

Detecting a difference in two colors is not as trivial as it sounds. One's first instinct is to go for a difference in RGB values, leaving you with a sum of the differences of each point. It looks great! Until you actually start comparing colors. Why do these two reds have a different distance than these two blues *in real life* vs computationally? Human visual perception is next in the line of things between a color and your brain. Some colors are just perceived to have larger variants inside of their respective areas than others, so we need a way to model this human variable to colors. Enter CIELAB. This color formulation is supposed to be this model. So now we need to standardize a unit of distance between any two colors that works independent of how humans visually perceive that distance. Enter CIE76,94,2000. These are methods that use user-tested data and other mathematically and statistically significant correlations to output this info. You can read the wiki articles below to get a better understanding historically of how we moved to newer and better color distance formulas, and what their respective pros/cons are.

**Finding Distance**

```objc
CGFloat distance = [someColor distanceFromColor:someOtherColor type:ColorDistanceCIE94];
BOOL isNoticablySimilar = distance < threshold;
```

**References**

* [Color Difference](http://en.wikipedia.org/wiki/Color_difference)
* [Just Noticeable Difference](http://en.wikipedia.org/wiki/Just_noticeable_difference)
* [CIELAB Specification](http://en.wikipedia.org/wiki/CIELAB)

## Generating Color Schemes

You can create a 5-color scheme based off of a UIColor using the following method. It takes in a UIColor and one of the ColorSchemeTypes defined in Colours. It returns an NSArray of 4 new UIColor objects to create a pretty nice color scheme that complements the root color you passed in.

```objc
NSArray *colorScheme = [color colorSchemeOfType:ColorSchemeType];
```

**ColorSchemeTypes**

* ColorSchemeAnalagous
* ColorSchemeMonochromatic
* ColorSchemeTriad
* ColorSchemeComplementary

Here are the different examples starting with a color scheme based off of <code>[UIColor seafoamColor]</code>.

**ColorSchemeAnalagous**

![Analagous](https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/analagous.png)

**ColorSchemeMonochromatic**

![Monochromatic](https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/monochromatic.png)

**ColorSchemeTriad**

![Triad](https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/triad.png)

**ColorSchemeComplementary**

![Complementary](https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/complementary.png)

## Android

My friend, [Matt York](https://github.com/MatthewYork) ported a version of this repository over to Android, so you can use these exact same colors and color methods in your Android apps as well. You can find it here: [Colours for Android](https://github.com/MatthewYork/Colours).

## Xamarin

[akamud](https://github.com/akamud/) has graciously ported this library as a Xamarin Android component, which can be found at [https://github.com/akamud/Colours](https://github.com/akamud/Colours). An iOS Xamarin component is in the works as well.

Reap What I Sow!
================

This project is distributed under the standard MIT License. Please use this and twist it in whatever fashion you wish - and recommend any cool changes to help the code.


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/bennyguitar/colours/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

