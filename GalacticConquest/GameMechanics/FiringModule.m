//
//  FiringModule.m
//  GalacticConquest
//
//  Created by Rich on 3/13/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

#import "FiringModule.h"



@implementation FiringModule

-(void)collideParticle:(HitParticle*)particle withAstrial:(AstrialObject*)astrial{
    [self.fireProjectiles removeObject:particle];
    CGPoint convertedLocation = particle.position;
//    convertedLocation = [particle convertPoint:particle.position
//                                            toNode:particle.parent];
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
                       [newParticle removeFromParent];
                       [self.fireProjectiles removeObject:newParticle];
                   });
}


-(void)update:(CFTimeInterval)currentTime {

    NSArray *particles = [NSArray arrayWithArray:self.fireProjectiles];
    NSArray *astrials  = [[AstrialObjectManager sharedManager] localCollidables];

    //Progress Projectile Movement
    
    for (HitParticle *particle in particles) {
        float particleSpeed = 100;
        float new_x = particle.position.x + cos(particle.angle) * particleSpeed;
        float new_y = particle.position.y + sin(particle.angle) * particleSpeed;
        SKAction *moveProjectile = [SKAction moveTo:CGPointMake(new_x, new_y) duration:0.1];
        [particle runAction:moveProjectile];
    }

    //Check collision of single projectile
    
    void (^checkCollision)(HitParticle *particle) = ^void(HitParticle *particle){
        for (AstrialObject* astrial in astrials) {
            if (!particle) {
                continue;
            }
            
            CGRect frame1 = [astrial  calculateAccumulatedFrame];
            CGRect frame2 = [particle calculateAccumulatedFrame];
            
            if (CGRectContainsRect(frame1, frame2)) {
                [self collideParticle:particle withAstrial:astrial];
                return;
            }
        }
    };
    
    //Check all projectiles for collisions
    
    for (HitParticle *particle in particles) {
        checkCollision(particle);
    }
    
}



-(id)init{
    self = [super init];
    if (self) {
        _fireProjectiles = [[NSMutableArray alloc]init];
    }
    return self;
}


@end
