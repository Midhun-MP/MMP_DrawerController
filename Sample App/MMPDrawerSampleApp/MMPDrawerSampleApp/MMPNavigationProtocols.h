/*
 *  MMPNavigationProtocols.h
 *  MMPDrawerControl
 *  Created by Midhun on 13/12/14.
 *  Copyright (c) 2014 Midhun MP. All rights reserved.
 *  Protocols used for the control
 */

#import <Foundation/Foundation.h>

/**
 * Main View Controller should implement this protocol
 */
@protocol MMPMainViewDelegate <NSObject>

// Move to Left
- (void)moveLeft;

// Move to Right
- (void)moveRight;

// Reset all movement
- (void)resetMove;

@end

@interface MMPNavigationProtocols : NSObject

@end
