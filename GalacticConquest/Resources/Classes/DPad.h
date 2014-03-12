//
//  DPad.h
//  ProceduralLevelGeneration
//
//  Created by Kim Pedersen on 30/07/13.
//  Copyright (c) 2013 Kim Pedersen. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface DPad : SKNode

@property (nonatomic, readonly) CGPoint stickPosition;
@property (nonatomic, readonly) CGFloat degrees;
@property (nonatomic, readonly) CGPoint velocity;
@property (nonatomic, assign) BOOL isBeingTouched;
@property (nonatomic, assign) BOOL autoCenter;
@property (nonatomic, assign) BOOL isDPad;
@property (nonatomic, assign) BOOL hasDeadzone;     // Turns deadzone on/off for joystick, always YES if isDPad == YES
@property (nonatomic, assign) NSUInteger numberOfDirections;    // Only used when isDPad == YES

@property (nonatomic, assign) CGFloat joystickRadius;
@property (nonatomic, assign) CGFloat thumbRadius;
@property (nonatomic, assign) CGFloat deadRadius;   // Size of deadzone in joystick (how far you must move before input starts). Automatically set is isDPad == YES

- (instancetype) initWithRect:(CGRect)rect;

-(void)forceStop;
@end
