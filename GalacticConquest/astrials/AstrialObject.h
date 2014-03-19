//
//  AstrialObject.h
//  GalacticConquest
//
//  Created by Rich on 3/12/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface AstrialObject : SKSpriteNode

@property (nonatomic) CGPoint velocity;
@property (nonatomic) mmIconShape mmShape;
@property (nonatomic) float angle;
@property (nonatomic) SKEmitterNode *burstNode;
@property (nonatomic) NSString *mmImageName;

-(void)takeHit:(float)hitPoints location:(CGPoint)hitLocation;
-(void)reduceSize;
@property (nonatomic) NSTimer *endPlode;


@end
