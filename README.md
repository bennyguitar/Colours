Colours for iOS
=============

A beautiful set of 100 predefined UIColors, and UIColor methods, ready to use in your next iOS project.

![ScreenShot](https://raw.github.com/craigwalton/Colours-for-iOS/master/Screenshots/iPhone-1.png)![ScreenShot](https://raw.github.com/craigwalton/Colours-for-iOS/master/Screenshots/iPhone-2.png)

## Installation ##

Drag the included **UIColor+Colours.h and UIColor+Colours.m** files into your project. They are located in the top-level directory. You can see a demo of how to use these with the included Xcode project as well.

Import UIColor+Colours.h into your ViewController.h file, and that's it.


## Using Colours ##

It's very simple. Whenever you set a property that is a UIColor, like self.view.backgroundColor, use one of the new colors as you would the system colors. So, instead of: <code>self.view.backgroundColor = [UIColor redColor]</code> do something like this: <code>self.view.backgroundColor = [UIColor tomatoColor]</code>

**System Colors**

* infoBlueColor
* successColor
* warningColor
* dangerColor

**Whites**

* antiqueWhiteColor
* oldLaceColor
* ivoryColor
* seashellColor
* ghostWhiteColor
* snowColor
* linenColor

**Grays**

* black25PercentColor
* black50PercentColor
* black75PercentColor
* warmGrayColor
* coolGrayColor
* charcoalColor

**Blues**

* tealColor
* steelBlueColor
* robinEggColor
* pastelBlueColor
* turquoiseColor
* skyBlueColor
* indigoColor
* denimColor
* blueberryColor
* cornflowerColor
* babyBlueColor
* midnightBlueColor
* fadedBlueColor
* icebergColor
* waveColor

**Greens**

* emeraldColor
* grassColor
* pastelGreenColor
* seafoamColor
* paleGreenColor
* cactusGreenColor
* chartreuseColor
* hollyGreenColor
* oliveColor
* oliveDrabColor
* moneyGreenColor
* honeydewColor
* limeColor
* cardTableColor

**Reds**

* salmonColor
* brickRedColor
* easterPinkColor
* grapefruitColor
* pinkColor
* indianRedColor
* strawberryColor
* coralColor
* maroonColor
* watermelonColor
* tomatoColor
* pinkLipstickColor
* paleRoseColor
* crimsonColor

**Purples**

* eggplantColor
* pastelPurpleColor
* palePurpleColor
* coolPurpleColor
* violetColor
* plumColor
* lavenderColor
* raspberryColor
* fuschiaColor
* grapeColor
* periwinkleColor
* orchidColor

**Yellows**

* goldenrodColor
* yellowGreenColor
* bananaColor
* mustardColor
* buttermilkColor
* goldColor
* creamColor
* lightCreamColor
* wheatColor
* beigeColor

**Oranges**

* peachColor
* burntOrangeColor
* pastelOrangeColor
* cantaloupeColor
* carrotColor
* mandarinColor

**Browns**

* chiliPowderColor
* burntSiennaColor
* chocolateColor
* coffeeColor
* cinnamonColor
* almondColor
* eggshellColor
* coffeeColor
* sandColor
* mudColor
* siennaColor
* dustColor

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
NSArray *colorScheme = [color colorSchemeOfType:ColorSchemeType];
```

**ColorSchemeTypes**

* ColorSchemeAnalagous
* ColorSchemeMonochromatic
* ColorSchemeTriad
* ColorSchemeComplementary

## CocoaPods ##

<code>pod 'Colours', '~> 2.0'</code>

For help setting up and maintaining dependencies using CocoaPods check out this link: http://cocoapods.org/

Reap What I Sow!
================

This project is distributed under the standard MIT License. Please use this and twist it in whatever fashion you wish - and recommend any cool changes to help the code.
