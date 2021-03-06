//
//  FiringModule.m
//  GalacticConquest
//
//  Created by Rich on 3/13/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "FiringModule.h"
#import "AstrialObject.h"
#import "HitParticle.h"
#import "AstrialObjectManager.h"
#import "CollisionManager.h"




@implementation FiringModule

-(void)collideParticle:(HitParticle*)particle withAstrial:(AstrialObject*)astrial{
    [self.fireProjectiles removeObject:particle];
    CGPoint convertedLocation = particle.position;
    [astrial takeHit:particle.hitPoints location:convertedLocation];
    [particle removeFromParent];
    particle = nil;
}

-(void)addBasicProjectileAngle:(float)angle startPoint:(CGPoint)startPoint{
    HitParticle *newParticle = [HitParticle spriteNodeWithImageNamed:@"mmCircle2"];
    [newParticle setSize:CGSizeMake(4, 4)];
    [newParticle setColor:[UIColor yellowColor]];
    newParticle.colorBlendFactor = 1.0;
    [newParticle setPosition:startPoint];
    [newParticle setAngle:angle+(M_PI*90/180)];
    [newParticle setZPosition:3.0];
    
    //Particle attached to node here
    [[AstrialObjectManager sharedManager]addNonCollidable:newParticle];
    
    [self.fireProjectiles addObject:newParticle];
    
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),
                   ^(void){
                       dispatch_sync(dispatch_get_main_queue(),^{
                       [self.fireProjectiles removeObject:newParticle];
                           [HitParticle killParticle:newParticle];

//                           newParticle = nil;
//                       [newParticle removeFromParent];
                       });


                   });
}



-(void)update:(CFTimeInterval)currentTime {
    
    NSArray *particles = [NSArray arrayWithArray:self.fireProjectiles];
    NSArray *astrials  = [[AstrialObjectManager sharedManager] localCollidables];
    
    //Progress Projectile Movement
    
    for (HitParticle *particle in particles) {
        NSLog(@"move particle");
        float particleSpeed = 100;
        float new_x = particle.position.x + cos(particle.angle) * particleSpeed;
        float new_y = particle.position.y + sin(particle.angle) * particleSpeed;
        CGPoint oldPos = particle.position;
        SKAction *moveProjectile = [SKAction moveTo:CGPointMake(new_x, new_y) duration:0.1];
        [particle runAction:moveProjectile];
        
        for( AstrialObject *ast in astrials){
            CGRect frame1 = [ast  calculateAccumulatedFrame];
            
            if (CGRectContainsPoint(frame1, oldPos)) {
                [self collideParticle:particle withAstrial:ast];
            }
            
        }
    }
    
    //Check particle collisions
//    NSArray*willCollide = [[CollisionManager sharedManager] checkParticleCollisions:particles];
//    if (willCollide) {
//        [self collideParticle:willCollide[0] withAstrial:willCollide[1]];
//    }
    
//    //random error :malloc: *** error for object 0x1c3f0e00: pointer being freed was not allocated
//    *** set a breakpoint in malloc_error_break to debug
    
}



-(id)init{
    self = [super init];
    if (self) {
        _fireProjectiles = [[NSMutableArray alloc]init];
    }
    return self;
}




-(id)initWithShip:(AstrialObject*)ship{
    self = [super init];
    if (self) {
        _fireProjectiles = [[NSMutableArray alloc]init];
       // [_fireProjectiles addObject:ship];
    }
    return self;
}


@end
