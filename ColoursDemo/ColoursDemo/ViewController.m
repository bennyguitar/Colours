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
