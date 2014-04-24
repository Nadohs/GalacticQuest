//
//  CollisionManager.h
//  GalacticConquest
//
//  Created by Rich on 3/24/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollisionManager : NSObject

-(NSArray*)checkParticleCollisions:(NSArray*)particles;
-(BOOL)checkSpaceStationCollision;
+(CollisionManager *) sharedManager;
@property (nonatomic) AstrialObject *ship;
@end
