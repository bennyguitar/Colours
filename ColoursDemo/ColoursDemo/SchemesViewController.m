//
//  MixerViewController.m
//  ColoursDemo
//
//  Created by Craig Walton on 01/11/2013.
//  Copyright (c) 2013 Ben Gordon. All rights reserved.
//

#import "SchemesViewController.h"
#import "UIColor+Colours.h"

@interface SchemesViewController ()

@end

@implementation SchemesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // sort UIView objects into arrays
    anViewsArray = @[anColor1, anColor2, anColor3, anColor4, anColor5];
    monViewsArray = @[monColor1, monColor2, monColor3, monColor4, monColor5];
    triViewsArray = @[triColor1, triColor2, triColor3, triColor4, triColor5];
    comViewsArray = @[comColor1, comColor2, comColor3, comColor4, comColor5];
    
    [redStepper setValue:(int)(redSlider.value*255.0f)];
    [greenStepper setValue:(int)(greenSlider.value*255.0f)];
    [blueStepper setValue:(int)(blueSlider.value*255.0f)];
    
    [self updateLabels];
    [self updateColourSchemeViews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateLabels
{
    [redLabel setText:[NSString stringWithFormat:@"Red %.f",redSlider.value*255]];
    [greenLabel setText:[NSString stringWithFormat:@"Green %.f",greenSlider.value*255]];
    [blueLabel setText:[NSString stringWithFormat:@"Blue %.f",blueSlider.value*255]];
}

-(void)updateColourSchemeViews
{
    // Sets all colour scheme UIView objects to color based on sliders
    UIColor *color = [self colorFromSliders];
    
    [self setColourSchemeViews:anViewsArray toSchemeType:ColorSchemeAnalagous usingColor:color];
    [self setColourSchemeViews:monViewsArray toSchemeType:ColorSchemeMonochromatic usingColor:color];
    [self setColourSchemeViews:triViewsArray toSchemeType:ColorSchemeTriad usingColor:color];
    [self setColourSchemeViews:comViewsArray toSchemeType:ColorSchemeComplementary usingColor:color];
   
}

-(void)setColourSchemeViews:(NSArray *)array toSchemeType:(ColorScheme)cs usingColor:(UIColor *)color
{
    // Takes an array of 5 UIView objects and will set their backgroundColor based on provided color and
    // ColorScheme type
    NSArray *colourScheme = [color colorSchemeOfType:cs];
    
    [((UIView *)array[0]) setBackgroundColor:color];
    [((UIView *)array[1]) setBackgroundColor:colourScheme[0]];
    [((UIView *)array[2]) setBackgroundColor:colourScheme[1]];
    [((UIView *)array[3]) setBackgroundColor:colourScheme[2]];
    [((UIView *)array[4]) setBackgroundColor:colourScheme[3]];
}

-(UIColor *)colorFromSliders
{
    return [UIColor colorWithRed:redSlider.value green:greenSlider.value blue:blueSlider.value alpha:1];
}

#pragma mark - Controls IBActions

-(IBAction)stepperChanged:(UIStepper *)sender
{
    UISlider *correspondingSlider;
    if([sender isEqual:redStepper]) correspondingSlider = redSlider;
    else if([sender isEqual:greenStepper]) correspondingSlider = greenSlider;
    else if([sender isEqual:blueStepper]) correspondingSlider = blueSlider;
    
    // set the corresponding slider's value to the stepper value divided by 255
    [correspondingSlider setValue:sender.value/255.0f animated:YES];
    
    [self updateLabels];
    [self updateColourSchemeViews];
}

-(IBAction)sliderChanged:(UISlider *)sender
{
    UIStepper *correspondingStepper;
    if([sender isEqual:redSlider]) correspondingStepper = redStepper;
    else if([sender isEqual:greenSlider]) correspondingStepper = greenStepper;
    else if([sender isEqual:blueSlider]) correspondingStepper = blueStepper;
    
    // set the corresponding stepper's value to the slider value times 255
    [correspondingStepper setValue:(int)(sender.value*255.0f)];
    
    [self updateLabels];
    [self updateColourSchemeViews];
}

@end
