//
//  HitParticle.m
//  GalacticConquest
//
//  Created by Rich on 3/12/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

#import "HitParticle.h"

@implementation HitParticle

-(id)init{
    self = [super init];
    if (self) {
        _hitPoints = 10;
    }
    return self;
}

+(void)killParticle:(HitParticle*)particle{
    [particle removeFromParent];
    particle = nil;


}

@end
