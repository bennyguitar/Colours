//
//  ViewController.h
//  ColoursDemo
//
//  Created by Ben Gordon on 3/17/13.
//  Copyright (c) 2013 Ben Gordon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Colours.h"

@interface ColoursDemoViewController : UIViewController {
    
    // Buttons
    IBOutlet UIButton *infoBlue;
    IBOutlet UIButton *successBtn;
    IBOutlet UIButton *warningBtn;
    IBOutlet UIButton *dangerBtn;
    IBOutlet UIButton *tealBtn;
    IBOutlet UIButton *grapefruitBtn;
    IBOutlet UIButton *bananaBtn;
    IBOutlet UIButton *robinEggBtn;
    IBOutlet UIButton *peachBtn;
    IBOutlet UIButton *seafoamBtn;
    IBOutlet UIButton *salmonBtn;
    IBOutlet UIButton *warmGrayBtn;
    
    // Analagous Color Scheme
    IBOutlet UIView *anColor1;
    IBOutlet UIView *anColor2;
    IBOutlet UIView *anColor3;
    IBOutlet UIView *anColor4;
    IBOutlet UIView *anColor5;
    
    // Monochromatic Color Scheme
    IBOutlet UIView *monColor1;
    IBOutlet UIView *monColor2;
    IBOutlet UIView *monColor3;
    IBOutlet UIView *monColor5;
    IBOutlet UIView *monColor4;
    
    // Triad Color Scheme
    IBOutlet UIView *triColor1;
    IBOutlet UIView *triColor2;
    IBOutlet UIView *triColor3;
    IBOutlet UIView *triColor4;
    IBOutlet UIView *triColor5;
    
    // Complementary Color Scheme
    IBOutlet UIView *comColor1;
    IBOutlet UIView *comColor2;
    IBOutlet UIView *comColor3;
    IBOutlet UIView *comColor4;
    IBOutlet UIView *comColor5;
}

@end
