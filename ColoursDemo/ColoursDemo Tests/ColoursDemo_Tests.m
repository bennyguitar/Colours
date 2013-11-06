//
//  ColoursDemo_Tests.m
//  ColoursDemo Tests
//
//  Created by Craig Walton on 02/11/2013.
//  Copyright (c) 2013 Ben Gordon. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIColor+Colours.h"

@interface ColoursDemo_Tests : XCTestCase

@end

@implementation ColoursDemo_Tests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testRGBAArrayContructor {
    
    NSArray *arrayForRed = @[[NSNumber numberWithInt:255],[NSNumber numberWithInt:0],[NSNumber numberWithInt:0],[NSNumber numberWithInt:255]];
    NSArray *arrayForGreen = @[[NSNumber numberWithInt:0],[NSNumber numberWithInt:255],[NSNumber numberWithInt:0],[NSNumber numberWithInt:255]];
    NSArray *arrayForBlue = @[[NSNumber numberWithInt:0],[NSNumber numberWithInt:0],[NSNumber numberWithInt:255],[NSNumber numberWithInt:255]];
    
    NSAssert([[UIColor redColor] isEqual:[UIColor colorWithRGBAArray:arrayForRed]],
             @"Color from RGBA Array [255,0,0,255] does not give red.");
    
    NSAssert([[UIColor greenColor] isEqual:[UIColor colorWithRGBAArray:arrayForGreen]],
             @"Color from RGBA Array [0,255,0,255] does not give green.");
    
    NSAssert([[UIColor blueColor] isEqual:[UIColor colorWithRGBAArray:arrayForBlue]],
             @"Color from RGBA Array [0,0,255,255] does not give blue.");
}

-(void)testRGBADictContructor {
    
    NSDictionary *dictForRed = @{@"r": [NSNumber numberWithInt:255],@"g": [NSNumber numberWithInt:0],@"b": [NSNumber numberWithInt:0],@"a": [NSNumber numberWithInt:255]};
    NSDictionary *dictForGreen =@{@"r": [NSNumber numberWithInt:0],@"g": [NSNumber numberWithInt:255],@"b": [NSNumber numberWithInt:0],@"a": [NSNumber numberWithInt:255]};
    NSDictionary *dictForBlue = @{@"r": [NSNumber numberWithInt:0],@"g": [NSNumber numberWithInt:0],@"b": [NSNumber numberWithInt:255],@"a": [NSNumber numberWithInt:255]};
    
    NSAssert([[UIColor redColor] isEqual:[UIColor colorWithRGBADict:dictForRed]],
             @"Color from RGBA Dict [r:255,g:0,b:0,a:255] does not give red.");
    
    NSAssert([[UIColor greenColor] isEqual:[UIColor colorWithRGBADict:dictForGreen]],
             @"Color from RGBA Dict [r:0,g:255,b:0,a:255] does not give green.");
    
    NSAssert([[UIColor blueColor] isEqual:[UIColor colorWithRGBADict:dictForBlue]],
             @"Color from RGBA Dict [r:0,g:0,b:255,a:255] does not give blue.");
}


-(void)testColorFromHex
{
    NSAssert([[UIColor colorFromHexString:@"#ff0000"] isEqual:[UIColor redColor]],
             @"Color from #ff0000 does not give red");
    
    NSAssert([[UIColor colorFromHexString:@"#00ff00"] isEqual:[UIColor greenColor]],
             @"Color from #00ff00 does not give green");
    
    NSAssert([[UIColor colorFromHexString:@"#0000ff"] isEqual:[UIColor blueColor]],
             @"Color from #0000ff does not give blue");
    
}

-(void)testHexString
{
    NSAssert([[[UIColor redColor] hexString] isEqualToString:@"#ff0000"],
             @"Hex string from [UIColor redColor] does not equal #ff0000");
    
    NSAssert([[[UIColor greenColor] hexString] isEqualToString:@"#00ff00"],
             @"Hex string from [UIColor greenColor] does not equal #00ff00");
    
    NSAssert([[[UIColor blueColor] hexString] isEqualToString:@"#0000ff"],
             @"Hex string from [UIColor blueColor] does not equal #0000ff");
}



@end
