/*
 *  MMPHomeViewController.m
 *  MMPDrawerControl
 *  Created by Midhun on 11/12/14.
 *  Copyright (c) 2014 Midhun MP. All rights reserved.
 *  Main Control that handles the drawer like navigation
 */

#import "MMPHomeViewController.h"

#pragma mark - Constants

// Enum defines the tags for the view controllers
typedef enum
{
    DrawerVCMain = 1,
    DrawerVCLeft,
    DrawerVCRight
}DrawerVC;

// Corner radius of the view controllers
#define CORNER_RADIUS 4

// Duration of the animation
#define ANIMATE_DURATION .25

// The width of mainVC that need to be shown after the movement
#define SHOW_MAIN_WIDTH 60

@interface MMPHomeViewController () <UIGestureRecognizerDelegate
>

#pragma mark - Private Properties

// Indicates whether left drawer is open or not
@property (nonatomic, assign) BOOL isLeftDrawerOpen;

// Indicates whether right drawer is open or not
@property (nonatomic, assign) BOOL isRightDrawerOpen;

// Indicates whether drawer can show or not
@property (nonatomic, assign) BOOL canShowDrawer;

// Holds the preious velocity
@property (nonatomic, assign) CGPoint previousVelocity;

@end

@implementation MMPHomeViewController

#pragma mark - View Lifecycle methods
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Public Methods

// Initializes the controls
- (void)setupDrawers
{
    [self setupMainView];
    [self setupGestures];
    
}

// Moves the main view to left and Shows the right view controller
- (void)moveLeft
{
    UIView *childView = [self getRightView];
    [self.view sendSubviewToBack:childView];
    
    [UIView animateWithDuration:ANIMATE_DURATION
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         _mainVC.view.frame = CGRectMake(-self.view.frame.size.width + SHOW_MAIN_WIDTH, 0, self.view.frame.size.width, self.view.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         if (finished)
                         {
                             _rightButton.tag = 0;
                         }
                     }];
}

// Moves the main view to right and Shows the left view controller
-(void)moveRight
{
    UIView *childView = [self getLeftView];
    [self.view sendSubviewToBack:childView];
    
    [UIView animateWithDuration:ANIMATE_DURATION
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         _mainVC.view.frame = CGRectMake(self.view.frame.size.width - SHOW_MAIN_WIDTH, 0, self.view.frame.size.width, self.view.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         if (finished)
                         {
                             _leftButton.tag = 0;
                         }
                     }];
}

// Resets the previous movements and shows the initial view controller
-(void)resetMove
{
    [UIView animateWithDuration:ANIMATE_DURATION
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         _mainVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         if (finished)
                         {
                             [self resetMainView];
                         }
                     }];
}

#pragma mark - Private Methods -


#pragma mark - Gesture
// Setting up the gesture recogniser
-(void)setupGestures
{
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveDrawer:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [panRecognizer setDelegate:self];
    
    [_mainVC.view addGestureRecognizer:panRecognizer];
}


// Handles the movement
-(void)moveDrawer:(id)sender
{
    [[[(UITapGestureRecognizer*)sender view] layer] removeAllAnimations];
    
    CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:self.view];
    CGPoint velocity        = [(UIPanGestureRecognizer*)sender velocityInView:[sender view]];
    
    switch ([(UIPanGestureRecognizer*)sender state])
    {
        case UIGestureRecognizerStateBegan:
            [self gestureMovementStartedOn:sender withVelocity:velocity];
            break;
        case UIGestureRecognizerStateChanged:
            [self gestureMovementChangedOn:sender withVelocity:velocity andTranslatedPoint:translatedPoint];
            break;
        case UIGestureRecognizerStateEnded:
            [self gestureMovementEnded];
            break;
        default:
            break;
    }
}

// Handles the Gesture Movement Started Event
- (void)gestureMovementStartedOn:(id)sender withVelocity:(CGPoint)velocity
{
    UIView *childView = nil;
    if(velocity.x > 0)
    {
        if (!_isRightDrawerOpen)
        {
            childView = [self getLeftView];
        }
    }
    else
    {
        if (!_isLeftDrawerOpen)
        {
            childView = [self getRightView];
        }
        
    }
    [self.view sendSubviewToBack:childView];
    [[sender view] bringSubviewToFront:[(UIPanGestureRecognizer*)sender view]];
}

// Handles the Gesture Movement Changed Event
- (void)gestureMovementChangedOn:(id)sender withVelocity:(CGPoint)velocity andTranslatedPoint:(CGPoint)translatedPoint
{
    _canShowDrawer = abs([sender view].center.x - _mainVC.view.frame.size.width/2) > _mainVC.view.frame.size.width/2;
    [sender view].center = CGPointMake([sender view].center.x + translatedPoint.x, [sender view].center.y);
    [(UIPanGestureRecognizer*)sender setTranslation:CGPointMake(0,0) inView:self.view];
    _previousVelocity = velocity;
}

// Handles the Gesture Movement Ended Event
- (void)gestureMovementEnded
{
    if (!_canShowDrawer)
    {
        [self resetMove];
    }
    else
    {
        if (_isLeftDrawerOpen)
        {
            [self moveRight];
        }
        else if (_isRightDrawerOpen)
        {
            [self moveLeft];
        }
    }
}

#pragma mark - Utility Methods

// Returns the Left View
-(UIView *)getLeftView
{
    // Initialize left view if it is not already there
    if (_leftVC != nil)
    {
        self.leftVC.view.tag = DrawerVCLeft;
        [self.view addSubview:self.leftVC.view];
        [self addChildViewController:_leftVC];
        [_leftVC didMoveToParentViewController:self];
        _leftVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
    self.isLeftDrawerOpen = YES;
    
    // Adds shadow
    [self showCenterViewWithShadow:YES withOffset:-2];
    return self.leftVC.view;
}

// Returns the Right View
-(UIView *)getRightView
{
    // Initialize right view if it is not already there
    if (_rightVC != nil)
    {
        self.rightVC.view.tag = DrawerVCRight;
        [self.view addSubview:self.rightVC.view];
        [self addChildViewController:self.rightVC];
        [_rightVC didMoveToParentViewController:self];
        _rightVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
    self.isRightDrawerOpen = YES;
    
    // Adds Shadow
    [self showCenterViewWithShadow:YES withOffset:2];
    return self.rightVC.view;
}


// Setup Main View
-(void)setupMainView
{
    self.mainVC.view.tag = DrawerVCMain;
    _mainVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:self.mainVC.view];
    [self addChildViewController:_mainVC];
    [_mainVC didMoveToParentViewController:self];
    [self setupGestures];
}

// Adds shadow to center view (mainVC)
-(void)showCenterViewWithShadow:(BOOL)value withOffset:(double)offset {
    if (value)
    {
        [_mainVC.view.layer setCornerRadius:CORNER_RADIUS];
        [_mainVC.view.layer setShadowColor:[UIColor blackColor].CGColor];
        [_mainVC.view.layer setShadowOpacity:0.8];
        [_mainVC.view.layer setShadowOffset:CGSizeMake(offset, offset)];
        
    }
    else
    {
        [_mainVC.view.layer setCornerRadius:0.0f];
        [_mainVC.view.layer setShadowOffset:CGSizeMake(offset, offset)];
    }
}

// Reset Main View to it's original place
-(void)resetMainView
{
    if (_leftVC != nil)
    {
        [self.leftVC.view removeFromSuperview];
        self.isLeftDrawerOpen = NO;
        
        _leftButton.tag = 1;
    }
    if (_rightVC != nil)
    {
        [self.rightVC.view removeFromSuperview];
        self.isRightDrawerOpen = NO;
        
        _rightButton.tag = 1;
    }
    // Removes the Shadow
    [self showCenterViewWithShadow:NO withOffset:0];
}
@end
