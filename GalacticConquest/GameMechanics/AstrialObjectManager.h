//
//  AstrialObjectManager.h
//  GalacticConquest
//
//  Created by Rich on 3/7/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

@import  SpriteKit;
@class AstrialObject;

@interface AstrialObjectManager : NSObject

@property (weak, nonatomic) SKNode *background;
@property (strong, nonatomic) NSMutableArray *astrialObjects;
@property (strong, nonatomic) NSMutableArray *localCollidables;
@property (strong, nonatomic) NSArray *collidableAstrials;
@property (assign, nonatomic) BOOL canDock;

-(void)addCollidable:(AstrialObject*)astrialObj;
-(void)addNonCollidable:(AstrialObject*)astrialObj;
-(void)killAstrial:(AstrialObject*)astrialObj;

-(void)recalculateLocalCollidablesFrom:(CGPoint)local;


+ (AstrialObjectManager *) sharedManager;



@end
