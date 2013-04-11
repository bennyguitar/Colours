//
//  ViewController.h
//  ColoursDemo
//
//  Created by Ben Gordon on 3/17/13.
//  Copyright (c) 2013 Ben Gordon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "UIColor+Colours.h"

@interface ViewController : UIViewController {
    __weak IBOutlet UIScrollView *colorScroll;
    IBOutlet UIView *scrollContentView;
    
    // Buttons
    __weak IBOutlet UIButton *infoBlue;
    __weak IBOutlet UIButton *successBtn;
    __weak IBOutlet UIButton *warningBtn;
    __weak IBOutlet UIButton *dangerBtn;
    __weak IBOutlet UIButton *tealBtn;
    __weak IBOutlet UIButton *grapefruitBtn;
    __weak IBOutlet UIButton *bananaBtn;
    __weak IBOutlet UIButton *robinEggBtn;
    __weak IBOutlet UIButton *peachBtn;
    __weak IBOutlet UIButton *seafoamBtn;
    __weak IBOutlet UIButton *salmonBtn;
    __weak IBOutlet UIButton *warmGrayBtn;
    
    // Analagous Color Scheme
    __weak IBOutlet UIView *anColor1;
    __weak IBOutlet UIView *anColor2;
    __weak IBOutlet UIView *anColor3;
    __weak IBOutlet UIView *anColor4;
    __weak IBOutlet UIView *anColor5;
    
    // Monochromatic Color Scheme
    __weak IBOutlet UIView *monColor1;
    __weak IBOutlet UIView *monColor2;
    __weak IBOutlet UIView *monColor3;
    __weak IBOutlet UIView *monColor5;
    __weak IBOutlet UIView *monColor4;
    
    // Triad Color Scheme
    __weak IBOutlet UIView *triColor1;
    __weak IBOutlet UIView *triColor2;
    __weak IBOutlet UIView *triColor3;
    __weak IBOutlet UIView *triColor4;
    __weak IBOutlet UIView *triColor5;
    
    // Complementary Color Scheme
    __weak IBOutlet UIView *comColor1;
    __weak IBOutlet UIView *comColor2;
    __weak IBOutlet UIView *comColor3;
    __weak IBOutlet UIView *comColor4;
    __weak IBOutlet UIView *comColor5;
}

@end
