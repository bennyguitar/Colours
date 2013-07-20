//
//  ColorsViewController.m
//  ColoursDemo
//
//  Created by Brian Partridge on 7/20/13.
//  Copyright (c) 2013 Ben Gordon. All rights reserved.
//

#import "ColorsViewController.h"

@interface ColorsViewController ()

@property (nonatomic, strong) NSArray *colors;

@end

@implementation ColorsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.colors = @[@"infoBlue",
                    @"success",
                    @"warning",
                    @"danger",
                    @"antiqueWhite",
                    @"oldLace",
                    @"ivory",
                    @"seashell",
                    @"ghostWhite",
                    @"snow",
                    @"linen",
                    @"black25Percent",
                    @"black50Percent",
                    @"black75Percent",
                    @"warmGray",
                    @"coolGray",
                    @"charcoal",
                    @"teal",
                    @"steelBlue",
                    @"robinEgg",
                    @"pastelBlue",
                    @"turquoise",
                    @"skyeBlue",
                    @"indigo",
                    @"denim",
                    @"blueberry",
                    @"cornflower",
                    @"babyBlue",
                    @"midnightBlue",
                    @"fadedBlue",
                    @"iceberg",
                    @"wave",
                    @"emerald",
                    @"grass",
                    @"pastelGreen",
                    @"seafoam",
                    @"paleGreen",
                    @"cactusGreen",
                    @"chartreuse",
                    @"hollyGreen",
                    @"olive",
                    @"oliveDrab",
                    @"moneyGreen",
                    @"honeydew",
                    @"lime",
                    @"cardTable",
                    @"salmon",
                    @"brickRed",
                    @"easterPink",
                    @"grapefruit",
                    @"pink",
                    @"indianRed",
                    @"strawberry",
                    @"coral",
                    @"maroon",
                    @"watermelon",
                    @"tomato",
                    @"pinkLipstick",
                    @"paleRose",
                    @"crimson",
                    @"eggplant",
                    @"pastelPurple",
                    @"palePurple",
                    @"coolPurple",
                    @"violet",
                    @"plum",
                    @"lavender",
                    @"raspberry",
                    @"fuschia",
                    @"grape",
                    @"periwinkle",
                    @"orchid",
                    @"goldenrod",
                    @"yellowGreen",
                    @"banana",
                    @"mustard",
                    @"buttermilk",
                    @"gold",
                    @"cream",
                    @"lightCream",
                    @"wheat",
                    @"beige",
                    @"peach",
                    @"burntOrange",
                    @"pastelOrange",
                    @"cantaloupe",
                    @"carrot",
                    @"mandarin",
                    @"chiliPowder",
                    @"burntSienna",
                    @"chocolate",
                    @"coffee",
                    @"cinnamon",
                    @"almon",
                    @"eggshell",
                    @"sand",
                    @"mud",
                    @"sienna",
                    @"dust"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.colors.count;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSString *name = [self.colors objectAtIndex:indexPath.row];
    cell.textLabel.text = name;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    SEL selector = NSSelectorFromString([NSString stringWithFormat:@"%@Color", name]);
    UIView *background = [[UIView alloc] init];
    if ([[UIColor class] respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        background.backgroundColor = (UIColor *)[[UIColor class] performSelector:selector];
#pragma diagnostic pop
    }
    cell.backgroundView = background;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    [self configureCell:cell atIndexPath:indexPath];

    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
