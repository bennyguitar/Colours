Colours for iOS
=============

A beautiful set of predefined UIColors, and UIColor methods, ready to use in your next iOS project.

![ScreenShot](https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/iphone1.png)![ScreenShot](https://raw.github.com/bennyguitar/Colours-for-iOS/master/Screenshots/iphone2.png)

## Installation ##

Drag the included **Colours.h and Colours.m** files into your project. They are located in the top-level directory. You can see a demo of how to use these with the included Xcode project as well.

Import Colours.h into your ViewController.h file, and that's it.


## Using Colours ##

It's very simple. Whenever you set a property that is a UIColor, like self.view.backgroundColor, instead of doing something like <code>self.view.backgroundColor = [UIColor redColor]</code> use one of the new colors like so <code>self.view.backgroundColor = ColorTeal</code>

**System Colors**

* ColorInfoBlue
* ColorSuccess
* ColorWarning
* ColorDanger

**Grays**

* Color25PercentBlack
* Color50PercentBlack
* Color75PercentBlack
* ColorWarmGray
* ColorCoolGray

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
* ColorMoneyGreen

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

**Yellows**

* ColorGoldenrod
* ColorYellowGreen
* ColorBanana
* ColorMustard
* ColorButtermilk
* ColorGold

**Oranges**

* ColorPeach
* ColorBurntOrange
* ColorPastelOrange
* ColorCantaloupe
* ColorCarrot

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

## Colours Methods ##

You can grab a UIColor from a hexString by calling colorFromHex:
```shell
NSString *hexString = @"#f587e4";
UIColor *newColor = [Colours colorFromHex:hexString];
```
If you'd like the RGBA values of any UIColor, just call the rgbaArrayFromColor method. It returns an array of 4 NSNumbers, RGBA - in that order. Here's how you'd call this:
```shell
NSArray *colorArray = [Colours rgbaArrayFromColor:self.view.backgroundColor];
float r = [colorArray[0] floatValue];
float g = [colorArray[1] floatValue];
float b = [colorArray[2] floatValue];
float a = [colorArray[3] floatValue];
```
 
Reap What I Sow!
================

This project is distributed under the standard MIT License. Please use this and twist it in whatever fashion you wish - and recommend any cool changes to help the code.
