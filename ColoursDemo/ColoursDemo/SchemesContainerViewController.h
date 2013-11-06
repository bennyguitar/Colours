//
//  MixerContainerViewController.h
//  ColoursDemo
//
//  Created by Craig Walton on 01/11/2013.
//  Copyright (c) 2013 Ben Gordon. All rights reserved.
//

/*
 This class is a subclass of UIViewController which controls a UIScrollView, with a UIView inside it.
 The UIView is a container for an embedded ViewController, MixerViewController.
 */

#import <UIKit/UIKit.h>

@interface SchemesContainerViewController : UIViewController {
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIView *contentViewContainer;
}

@end
