//
//  CollisionManager.m
//  GalacticConquest
//
//  Created by Rich on 3/24/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

#import "CollisionManager.h"
#import "AstrialObjectManager.h"


@implementation CollisionManager

-(NSArray*)checkParticleCollisions:(NSArray*)particles{
    
    NSArray *astrials  = [[AstrialObjectManager sharedManager] localCollidables];
    

    //Check collision of single projectile
    
    NSArray* (^checkCollision)(HitParticle *particle) = ^NSArray*(HitParticle *particle){
        
        for (AstrialObject* astrial in astrials) {
            
            
            CGRect frame1 = [astrial  calculateAccumulatedFrame];
            CGRect frame2 = [particle calculateAccumulatedFrame];
            
            if (CGRectContainsRect(frame1, frame2)) {
                return @[particle,astrial];
            }
        }
        return nil;
    };
    
    //Check all projectiles for collisions
    
    for (HitParticle *particle in particles) {
        if (!particle) {
            continue;
        }
       return checkCollision(particle);
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
