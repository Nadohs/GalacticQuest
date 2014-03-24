//
//  FiringModule.h
//  GalacticConquest
//
//  Created by Rich on 3/13/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "HitParticle.h"
#import "AstrialObjectManager.h"
#import "CollisionManager.h"


@interface FiringModule : NSObject

@property (nonatomic) NSMutableArray *fireProjectiles;


-(void)update:(CFTimeInterval)currentTime;
-(void)addBasicProjectileAngle:(float)angle startPoint:(CGPoint)startPoint;
@end
