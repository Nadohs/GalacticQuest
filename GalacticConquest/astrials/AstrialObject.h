//
//  AstrialObject.h
//  GalacticConquest
//
//  Created by Rich on 3/12/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//


#import "GLCIconInfo.h"

@import SpriteKit;
@class  Seedling;
@class MapNode;

@interface AstrialObject : SKSpriteNode

@property (nonatomic, weak) MapNode *mapNode;
@property (nonatomic, weak) Seedling *seed;
@property (nonatomic) SKEmitterNode *burstNode;
@property (nonatomic) mmIconShape mmShape;
@property (nonatomic) NSString *mmImageName;
@property (nonatomic) CGPoint velocity;
@property (nonatomic) float angle;
@property (nonatomic) BOOL isCollidable;


-(void)takeHit:(float)hitPoints location:(CGPoint)hitLocation;
-(void)reduceSize;

@property (nonatomic) NSTimer *endPlode;


@end
