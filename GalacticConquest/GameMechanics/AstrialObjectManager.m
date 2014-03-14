//
//  AstrialObjectManager.m
//  GalacticConquest
//
//  Created by Rich on 3/7/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

#import "AstrialObjectManager.h"


@implementation AstrialObjectManager

//-(id)init{
//    self = [super init];
//    if (self) {
//        self.astrialObjects = [[NSMutableArray alloc]init];
//    }
//    return self;
//}


-(void)addCollidable:(AstrialObject*)astrialObj{
    [self.background addChild:astrialObj];
    [self.collidableAstrials addObject:astrialObj];
    [self.astrialObjects addObject:astrialObj];
}


-(void)addNonCollidable:(AstrialObject*)astrialObj {
    [self.background addChild:astrialObj];
    if (![astrialObj isKindOfClass:HitParticle.class]){
        [self.astrialObjects addObject:astrialObj];
    }else{
        NSLog(@"added hitParticle to astrials GOOD");
    }
}


#pragma mark - Inititialize Stuff -

-(void)singletonInit
{
    self.astrialObjects     = [[NSMutableArray alloc]init];
    self.collidableAstrials = [[NSMutableArray alloc]init];
}


+ (AstrialObjectManager *) sharedManager
{
    static AstrialObjectManager *sharedInstance;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        sharedInstance =  [[super allocWithZone:NULL] init];
        [sharedInstance singletonInit];
    });
    return sharedInstance;
}


+ (id) allocWithZone:(NSZone *)zone {
    return [AstrialObjectManager sharedManager];
}

@end
