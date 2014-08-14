//
//  CollisionEvent.h
//  GalacticConquest
//
//  Created by Rich on 3/12/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//


@import SpriteKit;
#import "AstrialObject.h"

@interface CollisionEvent : NSObject
@property (nonatomic) float collisionTime;
@property (nonatomic) AstrialObject *astrial1;
@property (nonatomic) AstrialObject *astrial2;
@property (nonatomic) CGPoint a1Velocity;
@property (nonatomic) CGPoint a2Velocity;

@end
