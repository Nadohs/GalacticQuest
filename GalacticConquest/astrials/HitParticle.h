//
//  HitParticle.h
//  GalacticConquest
//
//  Created by Rich on 3/12/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

#import "AstrialObject.h"

@interface HitParticle : AstrialObject

@property (nonatomic)float hitPoints;

+(void)killParticle:(HitParticle*)particle;

@end
