//
//  BattleMechanics.h
//  GalacticConquest
//
//  Created by Rich on 3/7/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface BattleMechanics : SKNode

@property (nonatomic) SKNode *playerShip;
//@property (nonatomic) SKNode *main;

-(void)firedPlayerFromAngle: (int)degree;

-(void)firedEnemy:(SKNode*)enemyNode FireFromAngle:(int)degree;

@end
