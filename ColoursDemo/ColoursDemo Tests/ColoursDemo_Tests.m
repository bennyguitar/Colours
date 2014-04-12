//
//  ColoursDemo_Tests.m
//  ColoursDemo Tests
//
//  Created by Craig Walton on 02/11/2013.
//  Copyright (c) 2013 Ben Gordon. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Colours.h"

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

- (void)testRGBAArrayContructor {
    NSArray *arrayForRed = @[@(1),@(0),@(0),@(1)];
    NSArray *arrayForGreen = @[@(0),@(1),@(0),@(1)];
    NSArray *arrayForBlue = @[@(0),@(0),@(1),@(1)];
    
    XCTAssertEqualObjects([UIColor redColor], [UIColor colorFromRGBAArray:arrayForRed], @"Color from RGBA Array [255,0,0,255] does not give red.");
    XCTAssertEqualObjects([UIColor greenColor], [UIColor colorFromRGBAArray:arrayForGreen], @"Color from RGBA Array [0,255,0,255] does not give green.");
    XCTAssertEqualObjects([UIColor blueColor], [UIColor colorFromRGBAArray:arrayForBlue], @"Color from RGBA Array [0,0,255,255] does not give blue.");
}

- (void)testRGBADictContructor {
    NSDictionary *dictForRed = @{kColoursRGBA_R:@1,
                                 kColoursRGBA_G:@0,
                                 kColoursRGBA_B:@0,
                                 kColoursRGBA_A:@1};
    
    NSDictionary *dictForGreen =@{kColoursRGBA_R:@0,
                                  kColoursRGBA_G:@1,
                                  kColoursRGBA_B:@0,
                                  kColoursRGBA_A:@1};
    
    NSDictionary *dictForBlue = @{kColoursRGBA_R:@0,
                                  kColoursRGBA_G:@0,
                                  kColoursRGBA_B:@1,
                                  kColoursRGBA_A:@1};
    
    XCTAssertEqualObjects([UIColor redColor], [UIColor colorFromRGBADictionary:dictForRed], @"Color from RGBA Dictionary [255,0,0,255] does not give red.");
    XCTAssertEqualObjects([UIColor greenColor], [UIColor colorFromRGBADictionary:dictForGreen], @"Color from RGBA Dictionary [0,255,0,255] does not give green.");
    XCTAssertEqualObjects([UIColor blueColor], [UIColor colorFromRGBADictionary:dictForBlue], @"Color from RGBA Dictionary [0,0,255,255] does not give blue.");
}


- (void)testColorFromHex {
    XCTAssertEqualObjects([UIColor colorFromHexString:@"#ff0000"], [UIColor redColor], @"Color from #ff0000 does not give red");
    XCTAssertEqualObjects([UIColor colorFromHexString:@"#00ff00"], [UIColor greenColor], @"Color from #00ff00 does not give green");
    XCTAssertEqualObjects([UIColor colorFromHexString:@"#0000ff"], [UIColor blueColor], @"Color from #0000ff does not give blue");
}

- (void)testHexString {
    XCTAssertEqualObjects(@"#ff0000", [[UIColor redColor] hexString], @"Hex string from [UIColor redColor] does not equal #ff0000");
    XCTAssertEqualObjects(@"#00ff00", [[UIColor greenColor] hexString], @"Hex string from [UIColor greenColor] does not equal #00ff00");
    XCTAssertEqualObjects(@"#0000ff", [[UIColor blueColor] hexString], @"Hex string from [UIColor blueColor] does not equal #0000ff");
}

- (void)testToAndFromRGBAArray {
    NSArray *testArray = [[UIColor redColor] rgbaArray];
    UIColor *testColor = [UIColor colorFromRGBAArray:testArray];
    
    XCTAssertEqualObjects(testColor, [UIColor redColor], @"Serializing to and from RGBA Array does not yield the same color.");
}

- (void)testToAndFromRGBADictionary {
    NSDictionary *testDictionary = [[UIColor redColor] rgbaDictionary];
    UIColor *testColor = [UIColor colorFromRGBADictionary:testDictionary];
    
    XCTAssertEqualObjects(testColor, [UIColor redColor], @"Serializing to and from RGBA Dictionary does not yield the same color.");
}


- (void)testToAndFromHSBAArray {
    NSArray *testArray = [[UIColor redColor] hsbaArray];
    UIColor *testColor = [UIColor colorFromHSBAArray:testArray];
    
    XCTAssertEqualObjects(testColor, [UIColor redColor], @"Serializing to and from HSBA Array does not yield the same color.");
}

- (void)testToAndFromHSBADictionary {
    NSDictionary *testDictionary = [[UIColor redColor] hsbaDictionary];
    UIColor *testColor = [UIColor colorFromHSBADictionary:testDictionary];
    
    XCTAssertEqualObjects(testColor, [UIColor redColor], @"Serializing to and from HSBA Dictionary does not yield the same color.");
}

- (void)testToAndFromCIE_LabArray {
    NSArray *testArray = [[UIColor tomatoColor] CIE_LabArray];
    UIColor *testColor = [UIColor colorFromCIE_LabArray:testArray];
    
    CGFloat R1 = [[UIColor tomatoColor] red];
    CGFloat R2 =[testColor red];
    CGFloat G1 = [[UIColor tomatoColor] green];
    CGFloat G2 =[testColor green];
    CGFloat B1 = [[UIColor tomatoColor] blue];
    CGFloat B2 =[testColor blue];
    CGFloat A1 = [[UIColor tomatoColor] alpha];
    CGFloat A2 =[testColor alpha];
    XCTAssertEqualWithAccuracy(R1, R2, 0.001,  @"Serializing to and from CIE_LAB Array does not yield the same color.");
    XCTAssertEqualWithAccuracy(G1, G2, 0.001,  @"Serializing to and from CIE_LAB Array does not yield the same color.");
    XCTAssertEqualWithAccuracy(B1, B2, 0.001,  @"Serializing to and from CIE_LAB Array does not yield the same color.");
    XCTAssertEqualWithAccuracy(A1, A2, 0.001,  @"Serializing to and from CIE_LAB Array does not yield the same color.");
}

- (void)testToAndFromCIE_LabDictionary {
    NSDictionary *testDictionary = [[UIColor tomatoColor] CIE_LabDictionary];
    UIColor *testColor = [UIColor colorFromCIE_LabDictionary:testDictionary];
    
    CGFloat R1 = [[UIColor tomatoColor] red];
    CGFloat R2 =[testColor red];
    CGFloat G1 = [[UIColor tomatoColor] green];
    CGFloat G2 =[testColor green];
    CGFloat B1 = [[UIColor tomatoColor] blue];
    CGFloat B2 =[testColor blue];
    CGFloat A1 = [[UIColor tomatoColor] alpha];
    CGFloat A2 =[testColor alpha];
    XCTAssertEqualWithAccuracy(R1, R2, 0.001,  @"Serializing to and from CIE_LAB Dictionary does not yield the same color.");
    XCTAssertEqualWithAccuracy(G1, G2, 0.001,  @"Serializing to and from CIE_LAB Dictionary does not yield the same color.");
    XCTAssertEqualWithAccuracy(B1, B2, 0.001,  @"Serializing to and from CIE_LAB Dictionary does not yield the same color.");
    XCTAssertEqualWithAccuracy(A1, A2, 0.001,  @"Serializing to and from CIE_LAB Dictionary does not yield the same color.");
}

- (void)testToAndFromCMYKArray {
    NSArray *testArray = [[UIColor redColor] cmykArray];
    UIColor *testColor = [UIColor colorFromCMYKArray:testArray];
    
    XCTAssertEqualObjects(testColor, [UIColor redColor], @"Serializing to and from CMYK Array does not yield the same color.");
}

- (void)testToAndFromCMYKDictionary {
    NSDictionary *testDictionary = [[UIColor redColor] cmykDictionary];
    UIColor *testColor = [UIColor colorFromCMYKDictionary:testDictionary];
    
    XCTAssertEqualObjects(testColor, [UIColor redColor], @"Serializing to and from CMYK Dictionary does not yield the same color.");
}

- (void)testContrastingColors {
    XCTAssertEqualObjects([[UIColor eggplantColor] blackOrWhiteContrastingColor], [UIColor whiteColor], @"Contrasting color over dark does not yield white.");
    XCTAssertEqualObjects([[UIColor antiqueWhiteColor] blackOrWhiteContrastingColor], [UIColor blackColor], @"Contrasting color over light does not yield black.");
}


#pragma mark - Swizzle Tests
- (void)testSwizzleRGBA {
    NSArray *colors = [[UIColor black25PercentColor] rgbaArray];
    XCTAssertEqualObjects(colors[0], @0.25, @"Serializing from UIWhiteColorSpace to RGBA does not work with swizzled method.");
    XCTAssertEqualObjects(colors[1], @0.25, @"Serializing from UIWhiteColorSpace to RGBA does not work works with swizzled method.");
    XCTAssertEqualObjects(colors[2], @0.25, @"Serializing from UIWhiteColorSpace to RGBA does not works with swizzled method.");
    XCTAssertEqualObjects(colors[3], @1, @"Serializing from UIWhiteColorSpace to RGBA not works with swizzled method.");
}

- (void)testSwizzleHSBA {
    NSArray *colors = [[UIColor black25PercentColor] hsbaArray];
    XCTAssertEqualObjects(colors[0], @0, @"Serializing from UIWhiteColorSpace to HSBA does not work with swizzled method.");
    XCTAssertEqualObjects(colors[1], @0, @"Serializing from UIWhiteColorSpace to HSBA does not work works with swizzled method.");
    XCTAssertEqualObjects(colors[2], @0.25, @"Serializing from UIWhiteColorSpace to HSBA does not works with swizzled method.");
    XCTAssertEqualObjects(colors[3], @1, @"Serializing from UIWhiteColorSpace to HSBA not works with swizzled method.");
}


#pragma mark - Color Distance
- (void)testColorDistance {
    CGFloat distance = [[UIColor redColor] distanceFromColor:[UIColor redColor]];
    XCTAssert(distance == 0, @"Color distnace from the same color does not provide accurate results.");
}


#pragma mark - Color Sorting
- (void)testColorSortLightness {
    UIColor *c1 = [UIColor colorFromHSBAArray:@[@1,@1,@0.45,@1]];
    UIColor *c2 = [UIColor colorFromHSBAArray:@[@1,@1,@0.88,@1]];
    UIColor *c3 = [UIColor colorFromHSBAArray:@[@1,@1,@0.003,@1]];
    UIColor *c4 = [UIColor colorFromHSBAArray:@[@1,@1,@0.12,@1]];
    NSArray *sorted = [UIColor sortColors:@[c1, c2, c3, c4] withComparison:ColorComparisonLightness];
    NSArray *check = @[c2, c1, c4, c3];
    XCTAssertEqualObjects(check, sorted, @"Sorting Colors is not accurate.");
}

- (void)testColorSortDarkness {
    UIColor *c1 = [UIColor colorFromHSBAArray:@[@1,@1,@0.45,@1]];
    UIColor *c2 = [UIColor colorFromHSBAArray:@[@1,@1,@0.88,@1]];
    UIColor *c3 = [UIColor colorFromHSBAArray:@[@1,@1,@0.003,@1]];
    UIColor *c4 = [UIColor colorFromHSBAArray:@[@1,@1,@0.12,@1]];
    NSArray *sorted = [UIColor sortColors:@[c1, c2, c3, c4] withComparison:ColorComparisonDarkness];
    NSArray *check = @[c3, c4, c1, c2];
    for (NSArray *colors in @[sorted, check]) {
        for (UIColor *c in colors) {
            NSLog(@"%@", c.hexString);
        }
    }
    XCTAssertEqualObjects(check, sorted, @"Sorting Colors is not accurate.");
}

























@end
