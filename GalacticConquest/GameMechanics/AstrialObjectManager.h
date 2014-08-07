//
//  AstrialObjectManager.h
//  GalacticConquest
//
//  Created by Rich on 3/7/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

//#import <Foundation/Foundation.h>

//@class HitParticle;
//@class AstrialObject;
@import  SpriteKit;


@interface AstrialObjectManager : NSObject

@property (nonatomic) SKNode *background;
@property (nonatomic) NSMutableArray *astrialObjects;
@property (nonatomic) NSMutableArray *localCollidables;
@property (nonatomic) NSMutableArray *collidableAstrials;
@property (nonatomic) BOOL canDock;

-(void)addCollidable:(AstrialObject*)astrialObj;
-(void)addNonCollidable:(AstrialObject*)astrialObj;
-(void)killAstrial:(AstrialObject*)astrialObj;

-(void)recalculateLocalCollidablesFrom:(CGPoint)local;


+ (AstrialObjectManager *) sharedManager;



@end
