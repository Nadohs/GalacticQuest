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


-(void)addCollidable:(SKNode*)astrialObj{
    [self.background addChild:astrialObj];
    [self.astrialObjects addObject:astrialObj];
}

-(void)addNonCollidable:(SKNode*)astrialObj{
    [self.astrialObjects addObject:astrialObj];
}

#pragma mark - Inititialize Stuff -

-(void)singletonInit
{
    self.astrialObjects = [[NSMutableArray alloc]init];
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
