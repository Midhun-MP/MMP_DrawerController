//
//  CenterViewController.h
//  MMPDrawerSampleApp
//
//  Created by Midhun on 14/12/14.
//  Copyright (c) 2014 Midhun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMPNavigationProtocols.h"

@interface CenterViewController : UIViewController <MMPMainViewDelegate>

@property (nonatomic, assign) id<MMPMainViewDelegate> delegate;

@property (nonatomic, weak) IBOutlet UIButton *leftButton;
@property (nonatomic, weak) IBOutlet UIButton *rightButton;

@end
