//
//  ViewController.m
//  ColoursDemo
//
//  Created by Ben Gordon on 3/17/13.
//  Copyright (c) 2013 Ben Gordon. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self buildButtons];
    [self setColorsForAnalagousColorScheme:ColorPeach];
    [self setColorsForMonochromaticColorScheme:ColorPeach];
    [self setColorsForTriadColorScheme:ColorPeach];
    [self setColorsForComplementaryColorScheme:ColorPeach];
    
    // Set Up Scroll
    [colorScroll addSubview:scrollContentView];
    [colorScroll setContentSize:CGSizeMake(scrollContentView.frame.size.width, scrollContentView.frame.size.height)];
    [colorScroll setContentOffset:CGPointZero];
}

#pragma mark - UI for Demo
-(void)buildButtons {
    // Make shadows and set corner radius for buttons
    NSArray *btnArray = @[infoBlue,successBtn,warningBtn,dangerBtn,tealBtn,grapefruitBtn,bananaBtn,robinEggBtn,peachBtn,seafoamBtn,salmonBtn,warmGrayBtn];
    for (UIView *btn in btnArray) {
        btn.layer.cornerRadius = 8;
        [self makeShadowForView:btn withCornerRadius:8];
    }
    
    // Now set the colors
    infoBlue.backgroundColor = ColorInfoBlue;
    successBtn.backgroundColor = ColorSuccess;
    warningBtn.backgroundColor = ColorWarning;
    dangerBtn.backgroundColor = ColorDanger;
    tealBtn.backgroundColor = ColorTeal;
    grapefruitBtn.backgroundColor = ColorGrapefruit;
    bananaBtn.backgroundColor = ColorBanana;
    robinEggBtn.backgroundColor = ColorRobinEgg;
    peachBtn.backgroundColor = ColorPeach;
    seafoamBtn.backgroundColor = ColorSeafoam;
    salmonBtn.backgroundColor = ColorSalmon;
    warmGrayBtn.backgroundColor = ColorWarmGray;
}

-(void)setColorsForAnalagousColorScheme:(UIColor *)color {
    NSArray *colorScheme = [Colours generateColorSchemeFromColor:color ofType:ColorSchemeAnalagous];
    anColor1.backgroundColor = colorScheme[0];
    anColor2.backgroundColor = colorScheme[1];
    anColor3.backgroundColor = colorScheme[2];
    anColor4.backgroundColor = colorScheme[3];
    anColor5.backgroundColor = colorScheme[4];
}

-(void)setColorsForMonochromaticColorScheme:(UIColor *)color {
    NSArray *colorScheme = [Colours generateColorSchemeFromColor:color ofType:ColorSchemeMonochromatic];
    monColor1.backgroundColor = colorScheme[0];
    monColor2.backgroundColor = colorScheme[1];
    monColor3.backgroundColor = colorScheme[2];
    monColor4.backgroundColor = colorScheme[3];
    monColor5.backgroundColor = colorScheme[4];
}

-(void)setColorsForTriadColorScheme:(UIColor *)color {
    NSArray *colorScheme = [Colours generateColorSchemeFromColor:color ofType:ColorSchemeTriad];
    triColor1.backgroundColor = colorScheme[0];
    triColor2.backgroundColor = colorScheme[1];
    triColor3.backgroundColor = colorScheme[2];
    triColor4.backgroundColor = colorScheme[3];
    triColor5.backgroundColor = colorScheme[4];
}

-(void)setColorsForComplementaryColorScheme:(UIColor *)color {
    NSArray *colorScheme = [Colours generateColorSchemeFromColor:color ofType:ColorSchemeComplementary];
    comColor1.backgroundColor = colorScheme[0];
    comColor1.backgroundColor = colorScheme[1];
    comColor3.backgroundColor = colorScheme[2];
    comColor4.backgroundColor = colorScheme[3];
    comColor5.backgroundColor = colorScheme[4];
}


-(void)makeShadowForView:(UIView *)view withCornerRadius:(float)radius {
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOpacity = 0.4f;
    view.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
    view.layer.shadowRadius = 3.0f;
    view.layer.masksToBounds = NO;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:view.bounds cornerRadius:radius];
    view.layer.shadowPath = path.CGPath;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
