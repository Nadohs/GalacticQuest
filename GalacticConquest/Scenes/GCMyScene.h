//
//  GCMyScene.h
//  GalacticConquest
//
//  Created by Rich on 3/1/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

@import SpriteKit;

@class DPad;
@class FMMParallaxNode;
@class FiringModule;
@class AstrialObject;


@interface GCMyScene : SKScene
@property (strong, nonatomic) SKNode *hud;
@property (strong, nonatomic) DPad *dPad;

//MainShip Properties
@property (strong, nonatomic) AstrialObject *ship;
@property (assign, nonatomic) CGPoint shipStartPos;

//MiniMap Properties
@property (strong, nonatomic) SKSpriteNode *miniMap;
@property (assign, nonatomic) CGPoint mapCenter;
@property (assign, nonatomic) float quatrantSize;

//directions
@property (strong, nonatomic) NSMutableArray *UL;
@property (strong, nonatomic) NSMutableArray *UM;
@property (strong, nonatomic) NSMutableArray *UR;

@property (strong, nonatomic) NSMutableArray *ML;
@property (strong, nonatomic) NSMutableArray *MM;
@property (strong, nonatomic) NSMutableArray *MR;

@property (strong, nonatomic) NSMutableArray *DL;
@property (strong, nonatomic) NSMutableArray *DM;
@property (strong, nonatomic) NSMutableArray *DR;

//HUD Objects
@property (strong, nonatomic) SKSpriteNode *stopPedal;
@property (strong, nonatomic) SKSpriteNode *stationBut;
@property (strong, nonatomic) SKSpriteNode *equipBut;
@property (assign, nonatomic) float mapBreakLeft;
@property (assign, nonatomic) float mapBreakRight;
@property (assign, nonatomic) float mapBreakUp;
@property (assign, nonatomic) float mapBreakDown;

//Background
@property (strong, nonatomic) FMMParallaxNode *parallaxNodeBackgrounds;

@property (assign, nonatomic) float currentAngle;


//Projectile Manager
@property (strong, nonatomic) FiringModule *bulletBox;

@property (strong, nonatomic) SKEmitterNode *burstNode;

@property (assign, nonatomic) int frameCount;

-(NSArray*)astrialObjects;
-(CGPoint)shipPosition;

@end
