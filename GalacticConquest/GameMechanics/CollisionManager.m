//
//  CollisionManager.m
//  GalacticConquest
//
//  Created by Rich on 3/24/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

#import "CollisionManager.h"
#import "AstrialObjectManager.h"
#import "AstrialObject.h"
#import "SpaceStation.h"
#import "HitParticle.h"

@implementation CollisionManager

//-(BOOL)checkSpaceStationCollision{
//    NSArray *astrials  = [[AstrialObjectManager sharedManager] localCollidables];
//    for (SpaceStation*station in astrials) {
//        if (![station isKindOfClass:SpaceStation.class]) {
//            [NSException raise:@"not a space station" format:@""];
//        }
//        
//        
//    }
//    
//    return NO;
//}



-(NSArray*)checkParticleCollisions:(NSArray*)particles{
    //Check collision of single projectile
    
    NSArray *(^checkCollision)(HitParticle *particle, NSArray *astrials) =
    
      ^NSArray *(HitParticle *particle, NSArray *astrials){
        
        for (AstrialObject* astrial in astrials) {
            
            
            CGRect frame1 = [astrial  calculateAccumulatedFrame];
            CGRect frame2 = [particle calculateAccumulatedFrame];
            
            if (CGRectContainsRect(frame1, frame2)) {
                return @[particle ,astrial];
            }
        }
        return nil;
    };
    
    //Check touch space station
//    for (SpaceStation *station in particles) {
//        if (![station isKindOfClass:SpaceStation.class]){
//            continue;
//        }
//        
//        CGRect frame1 = [station  calculateAccumulatedFrame];
//        CGRect frame2 = [self.ship calculateAccumulatedFrame];
//        if (CGRectContainsRect(frame1, frame2)) {
//            [station takeHit:0 location:CGPointMake(0,0)];
//            break;
//        }
//        
//    }
    
    
    //Check all projectiles for collisions
    
    NSArray *astrialList  = [[AstrialObjectManager sharedManager] collidableAstrials];
    
    for (HitParticle *particle in particles) {
        if (!particle) {
            continue;
        }
       return checkCollision(particle, astrialList);
    }
    return nil;
}

#pragma mark - singleton methods

-(void)singletonInit
{

}



+(CollisionManager *) sharedManager
{
    static CollisionManager *sharedInstance;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        sharedInstance =  [[super allocWithZone:NULL] init];
        [sharedInstance singletonInit];
    });
    return sharedInstance;
}


+(id) allocWithZone:(NSZone *)zone {
    return [CollisionManager sharedManager];
}

@end
