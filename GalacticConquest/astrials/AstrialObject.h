//
//  AstrialObject.h
//  GalacticConquest
//
//  Created by Rich on 3/12/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

@import SpriteKit;
#import "GLCIconInfo.h"
@class Seedling;

@interface AstrialObject : SKSpriteNode

@property (nonatomic, weak) Seedling *seed;
@property (nonatomic) CGPoint velocity;
@property (nonatomic) mmIconShape mmShape;
@property (nonatomic) float angle;
@property (nonatomic) SKEmitterNode *burstNode;
@property (nonatomic) NSString *mmImageName;

@property (nonatomic) BOOL isCollidable;

-(void)takeHit:(float)hitPoints location:(CGPoint)hitLocation;
-(void)reduceSize;

@property (nonatomic) NSTimer *endPlode;


@end
