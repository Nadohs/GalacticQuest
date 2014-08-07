//
//  FiringModule.h
//  GalacticConquest
//
//  Created by Rich on 3/13/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

//#import <Foundation/Foundation.h>


@class CollisionManager;

@interface FiringModule : NSObject

@property (nonatomic) NSMutableArray *fireProjectiles;

-(id)initWithShip:(AstrialObject*)ship;
-(void)update:(CFTimeInterval)currentTime;
-(void)addBasicProjectileAngle:(float)angle
                    startPoint:(CGPoint)startPoint;
@end
