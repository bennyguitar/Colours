//
//  ColoursDemoContainerViewController.m
//  ColoursDemo
//
//  Created by Craig Walton on 01/11/2013.
//  Copyright (c) 2013 Ben Gordon. All rights reserved.
//

#import "ColoursDemoContainerViewController.h"

@interface ColoursDemoContainerViewController ()

@end

@implementation ColoursDemoContainerViewController

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
	// Do any additional setup after loading the view.
}

-(void)viewDidLayoutSubviews
{
    //set the scroll view's content size based on how big the container view is
    //the container view is where the actual content is embedded in
    [scrollView setContentSize:contentViewContainer.bounds.size];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
