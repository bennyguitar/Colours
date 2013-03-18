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
}

@end
