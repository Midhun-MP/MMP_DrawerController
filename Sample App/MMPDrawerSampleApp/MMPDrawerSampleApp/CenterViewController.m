//
//  CenterViewController.m
//  MMPDrawerSampleApp
//
//  Created by Midhun on 14/12/14.
//  Copyright (c) 2014 Midhun. All rights reserved.
//

#import "CenterViewController.h"

@interface CenterViewController ()

@end

@implementation CenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)moveLeft:(id)sender
{
    UIButton *button = sender;
    switch (button.tag) {
        case 0:
        {
            [_delegate resetMove];
            break;
        }
            
        case 1:
        {
            [_delegate moveLeft];
            break;
        }
            
        default:
            break;
    }
}
- (IBAction)moveRight:(id)sender
{
    UIButton *button = sender;
    switch (button.tag) {
        case 0:
        {
            [_delegate resetMove];
            break;
        }
            
        case 1:
        {
            [_delegate moveRight];
            break;
        }
            
        default:
            break;
    }
}

- (void)moveLeft
{
    [_delegate moveLeft];
}

- (void)moveRight
{
    [_delegate moveRight];
}

- (void)resetMove
{
    [_delegate resetMove];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
