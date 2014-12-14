/*
 *  MMPHomeViewController.h
 *  MMPDrawerControl
 *  Created by Midhun on 11/12/14.
 *  Copyright (c) 2014 Midhun MP. All rights reserved.
 *  Main Control that handles the drawer like navigation
 */

#import <UIKit/UIKit.h>

@interface MMPHomeViewController : UIViewController

#pragma mark - Public Properties
// Holds the main view controller (The Center View Controller)
@property (nonatomic, strong) UIViewController *mainVC;

// Holds the right view controller
@property (nonatomic, strong) UIViewController *rightVC;

// Holds the left view controller
@property (nonatomic, strong) UIViewController *leftVC;

// Right button of Center VC
@property (nonatomic, strong) UIButton *rightButton;

// Left button of Center VC
@property (nonatomic, strong) UIButton *leftButton;

#pragma mark - Public Methods

// Initializes the controls
- (void)setupDrawers;

// Moves the main view to left and Shows the right view controller
- (void)moveLeft;

// Moves the main view to right and Shows the left view controller
- (void)moveRight;

// Resets the previous movements and shows the initial view controller
- (void)resetMove;

@end
