//
//  GCMyScene.h
//  GalacticConquest
//
//  Created by Rich on 3/1/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "DPad.h"
#import "FMMParallaxNode.h"
#import "FiringModule.h"


@interface GCMyScene : SKScene
@property (nonatomic) SKNode *hud;
@property (nonatomic) DPad *dPad;

//MainShip Properties
@property (nonatomic) AstrialObject *ship;
@property (nonatomic) CGPoint shipStartPos;

//MiniMap Properties
@property (nonatomic) SKSpriteNode *miniMap;
@property (nonatomic) CGPoint mapCenter;
@property (nonatomic) float quatrantSize;

//HUD Objects
@property (nonatomic) SKSpriteNode *stopPedal;

@property (nonatomic) float mapBreakLeft;
@property (nonatomic) float mapBreakRight;
@property (nonatomic) float mapBreakUp;
@property (nonatomic) float mapBreakDown;

//Background
@property (nonatomic) FMMParallaxNode *parallaxNodeBackgrounds;

@property (nonatomic) float currentAngle;


//Projectile Manager
@property (nonatomic) FiringModule *bulletBox;

@property (nonatomic) SKEmitterNode *burstNode;

@property (nonatomic) int frameCount;

-(NSArray*)astrialObjects;
-(CGPoint)shipPosition;

@end
