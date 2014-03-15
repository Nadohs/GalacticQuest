//
//  AstrialObject.m
//  GalacticConquest
//
//  Created by Rich on 3/12/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

#import "AstrialObject.h"
#import "InventoryManager.h"
#import "AstrialObjectManager.h"

@implementation AstrialObject



//-(void)takeHit:(float)hitPoints{
//
//}

-(void)reduceSize{
    if (self.size.height-20<=0 ) {
    //    [[AstrialObjectManager sharedManager] killAstrial:self];
        return;
    }
    CGSize newSize = self.size;
    newSize.width -=20;
    newSize.height -=20;
    [self setSize:newSize];
}

-(void)getMinned{
    [[InventoryManager sharedManager] mineRandomOre];
}

-(void)takeHit:(float)hitPoints location:(CGPoint)hitLocation{
//    [self removeExplosion];
    NSString *burstPath =  [[NSBundle mainBundle] pathForResource:@"explosion" ofType:@"sks"];
    
     self.burstNode = [NSKeyedUnarchiver unarchiveObjectWithFile:burstPath];
    [self.burstNode setNumParticlesToEmit:250];
    [self.burstNode setPosition:hitLocation];
    
    if (![self.children containsObject:self.burstNode]) {
        [self.parent addChild:self.burstNode];
    }
    else{
        [self.burstNode resetSimulation];
    }
    [self reduceSize];
    [self getMinned];
}


-(void)removeExplosion{
    [self.burstNode removeFromParent];
     self.burstNode = nil;
}

@end
