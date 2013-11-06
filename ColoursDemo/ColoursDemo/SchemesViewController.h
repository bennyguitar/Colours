//
//  MixerViewController.h
//  ColoursDemo
//
//  Created by Craig Walton on 01/11/2013.
//  Copyright (c) 2013 Ben Gordon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SchemesViewController : UIViewController {
    
    // Colour Labels
    IBOutlet UILabel *redLabel;
    IBOutlet UILabel *greenLabel;
    IBOutlet UILabel *blueLabel;
    
    // Colour Controls
    IBOutlet UISlider *redSlider;
    IBOutlet UISlider *greenSlider;
    IBOutlet UISlider *blueSlider;
    IBOutlet UIStepper *redStepper;
    IBOutlet UIStepper *greenStepper;
    IBOutlet UIStepper *blueStepper;
    
    // Arrays for Colour Scheme Views
    NSArray *anViewsArray;
    NSArray *monViewsArray;
    NSArray *triViewsArray;
    NSArray *comViewsArray;
    
    // Analagous Colour Scheme
    IBOutlet UIView *anColor1;
    IBOutlet UIView *anColor2;
    IBOutlet UIView *anColor3;
    IBOutlet UIView *anColor4;
    IBOutlet UIView *anColor5;
    
    // Monochromatic Colour Scheme
    IBOutlet UIView *monColor1;
    IBOutlet UIView *monColor2;
    IBOutlet UIView *monColor3;
    IBOutlet UIView *monColor5;
    IBOutlet UIView *monColor4;
    
    // Triad Colour Scheme
    IBOutlet UIView *triColor1;
    IBOutlet UIView *triColor2;
    IBOutlet UIView *triColor3;
    IBOutlet UIView *triColor4;
    IBOutlet UIView *triColor5;
    
    // Complementary Colour Scheme
    IBOutlet UIView *comColor1;
    IBOutlet UIView *comColor2;
    IBOutlet UIView *comColor3;
    IBOutlet UIView *comColor4;
    IBOutlet UIView *comColor5;
}

-(IBAction)stepperChanged:(id)sender;
-(IBAction)sliderChanged:(id)sender;

@end
