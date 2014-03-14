//
//  AstrialObject.m
//  GalacticConquest
//
//  Created by Rich on 3/12/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

#import "AstrialObject.h"

@implementation AstrialObject



//-(void)takeHit:(float)hitPoints{
//
//}

-(void)takeHit:(float)hitPoints location:(CGPoint)hitLocation{
    if ([self.children containsObject:self.burstNode]) {
        [self.endPlode invalidate];
         self.endPlode = nil;
        [self removeExplosion];
        for (SKEmitterNode*part in [self children]){
            [part removeFromParent];
        }
    }
    
    NSString *burstPath =
    [[NSBundle mainBundle]
     pathForResource:@"explosion" ofType:@"sks"];
    
    self.burstNode =
    [NSKeyedUnarchiver unarchiveObjectWithFile:burstPath];
    [self.burstNode setNumParticlesToEmit:1000];
    [self.parent addChild:self.burstNode];
    
    [self.burstNode setPosition:hitLocation];

    self.endPlode = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(removeExplosion) userInfo:nil repeats:NO];
}


-(void)removeExplosion{
    [self.burstNode removeFromParent];
    self.burstNode = nil;
}

@end
