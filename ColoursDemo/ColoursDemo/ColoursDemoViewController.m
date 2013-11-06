//
//  ViewController.m
//  ColoursDemo
//
//  Created by Ben Gordon on 3/17/13.
//  Copyright (c) 2013 Ben Gordon. All rights reserved.
//

#import "ColoursDemoViewController.h"

@interface ColoursDemoViewController ()

@end

@implementation ColoursDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self buildButtons];
    [self setColorsForAnalagousColorScheme:[UIColor seafoamColor]];
    [self setColorsForMonochromaticColorScheme:[UIColor seafoamColor]];
    [self setColorsForTriadColorScheme:[UIColor seafoamColor]];
    [self setColorsForComplementaryColorScheme:[UIColor seafoamColor]];
}

#pragma mark - UI for Demo
-(void)buildButtons
{
    // Make shadows and set corner radius for buttons
    NSArray *btnArray = @[infoBlue,successBtn,warningBtn,dangerBtn,tealBtn,grapefruitBtn,bananaBtn,robinEggBtn,peachBtn,seafoamBtn,salmonBtn,warmGrayBtn];
    for (UIView *btn in btnArray) {
        btn.layer.cornerRadius = 8;
        [self makeShadowForView:btn withCornerRadius:8];
    }
    
    // Now set the colors
    infoBlue.backgroundColor = [UIColor infoBlueColor];
    successBtn.backgroundColor = [UIColor successColor];
    warningBtn.backgroundColor = [UIColor warningColor];
    dangerBtn.backgroundColor = [UIColor dangerColor];
    tealBtn.backgroundColor = [UIColor tealColor];
    grapefruitBtn.backgroundColor = [UIColor grapefruitColor];
    bananaBtn.backgroundColor = [UIColor bananaColor];
    robinEggBtn.backgroundColor = [UIColor robinEggColor];
    peachBtn.backgroundColor = [UIColor peachColor];
    seafoamBtn.backgroundColor = [UIColor seafoamColor];
    salmonBtn.backgroundColor = [UIColor salmonColor];
    warmGrayBtn.backgroundColor = [UIColor warmGrayColor];
}

-(void)setColorsForAnalagousColorScheme:(UIColor *)color
{
	NSArray *colorScheme = [color colorSchemeOfType:ColorSchemeAnalagous];
    anColor1.backgroundColor = colorScheme[0];
    anColor2.backgroundColor = colorScheme[1];
    anColor3.backgroundColor = color;
    anColor4.backgroundColor = colorScheme[2];
    anColor5.backgroundColor = colorScheme[3];
}

-(void)setColorsForMonochromaticColorScheme:(UIColor *)color
{
    NSArray *colorScheme = [color colorSchemeOfType:ColorSchemeMonochromatic];
    monColor1.backgroundColor = colorScheme[0];
    monColor2.backgroundColor = colorScheme[1];
    monColor3.backgroundColor = color;
    monColor4.backgroundColor = colorScheme[2];
    monColor5.backgroundColor = colorScheme[3];
}

-(void)setColorsForTriadColorScheme:(UIColor *)color
{
    NSArray *colorScheme = [color colorSchemeOfType:ColorSchemeTriad];
    triColor1.backgroundColor = colorScheme[0];
    triColor2.backgroundColor = colorScheme[1];
    triColor3.backgroundColor = color;
    triColor4.backgroundColor = colorScheme[2];
    triColor5.backgroundColor = colorScheme[3];
}

-(void)setColorsForComplementaryColorScheme:(UIColor *)color
{
    NSArray *colorScheme = [color colorSchemeOfType:ColorSchemeComplementary];
    comColor1.backgroundColor = colorScheme[0];
    comColor1.backgroundColor = colorScheme[1];
    comColor3.backgroundColor = color;
    comColor4.backgroundColor = colorScheme[2];
    comColor5.backgroundColor = colorScheme[3];
}


-(void)makeShadowForView:(UIView *)view withCornerRadius:(float)radius
{
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
