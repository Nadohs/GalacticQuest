//
//  AstrialObjectManager.m
//  GalacticConquest
//
//  Created by Rich on 3/7/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

#import "AstrialObjectManager.h"

#import "AstrialObject.h"
#import "HitParticle.h"
#import "SpaceStation.h"
#import "QuadSeeder.h"


@implementation AstrialObjectManager

#pragma mark -

-(NSMutableArray *)astrialObjects{
    return [[[QuadSeeder sharedManager] getCollidables] mutableCopy];
}

-(void)recalculateLocalCollidablesFrom:(CGPoint)local{
    BOOL station = NO;
    float collideRange = 3000;
    
    _collidableAstrials = [[QuadSeeder sharedManager] getCollidables];
    
    NSMutableArray *tempLocalCollidables = [[NSMutableArray alloc]init];
    CGRect localFrame = CGRectMake(local.x-collideRange/2,
                                   local.y-collideRange/2,
                                   collideRange,
                                   collideRange);
    
    for (AstrialObject *astrial in self.collidableAstrials) {
        if (CGRectContainsPoint(localFrame, astrial.position)) {
            [tempLocalCollidables addObject:astrial];
            if ([astrial isKindOfClass:SpaceStation.class]) {
                station= YES;
            }
        }
    }
    _canDock = station;
    _localCollidables = tempLocalCollidables;
    if (_localCollidables.count>1){
        NSLog(@"%@",_localCollidables);}
}


#pragma mark - add/remove Astrials

-(void)addCollidable:(AstrialObject*)astrialObj{
    [_background          addChild : astrialObj];
//    [_collidableAstrials addObject : astrialObj];
    [_astrialObjects     addObject : astrialObj];
}



-(void)addNonCollidable:(AstrialObject*)astrialObj {
        [_background      addChild : astrialObj];
    if (![astrialObj isKindOfClass : HitParticle.class]){
        [_astrialObjects addObject : astrialObj];
    }else{
        NSLog(@"added hitParticle to astrials GOOD");
    }
}



-(void)killAstrial:(AstrialObject*)astrialObj{
    [astrialObj removeFromParent];
//    [_collidableAstrials removeObject : astrialObj];
    [_astrialObjects     removeObject : astrialObj];
}




#pragma mark - getters/setters




-(NSArray*)collidableAstrials{
    

    return [NSArray arrayWithArray : _collidableAstrials];
}

-(NSArray*)localCollidables{
    
    
    return [NSArray arrayWithArray : _localCollidables];
}



#pragma mark - Inititialize Stuff



-(void)singletonInit
{
    _astrialObjects     = [[NSMutableArray alloc]init];
    _collidableAstrials = [[NSMutableArray alloc]init];
    _localCollidables   = [[NSMutableArray alloc]init];
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
