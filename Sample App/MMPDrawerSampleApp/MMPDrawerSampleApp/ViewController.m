//
//  ViewController.m
//  MMPDrawerSampleApp
//
//  Created by Midhun on 14/12/14.
//  Copyright (c) 2014 Midhun. All rights reserved.
//

#import "ViewController.h"
#import "CenterViewController.h"
@interface ViewController () <MMPMainViewDelegate>

@end

@implementation ViewController
{
    CenterViewController *center;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    center = [[CenterViewController alloc] initWithNibName:@"Center" bundle:nil];
    center.delegate  = self;
    [self setMainVC:center];
    [self setRightVC:[[UIViewController alloc] initWithNibName:@"Right" bundle:nil]];
    [self setLeftVC:[[UIViewController alloc] initWithNibName:@"Left" bundle:nil]];
    [self setupDrawers];
    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.rightButton = center.rightButton;
    self.leftButton  = center.leftButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)moveRight
{
    [super moveRight];
}

- (void)moveLeft
{
    [super moveLeft];
}

- (void)resetMove
{
    [super resetMove];
}

@end
