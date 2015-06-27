//
//  GalaticGenerator.h
//  GalacticConquest
//
//  Created by Rich on 10/28/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//


@class Seedling;
@class Quandrant;

@interface GalaticGenerator : NSObject

-(UIColor*) randomColor;
-(CGPoint)  randomAstrialPosition;

//-(void)buildSpaceStuff;

-(Quandrant*) buildSpaceStuff : (Seedling*)seed;
-(CGPoint) coordForPos : (CGPoint)curPos;

@property (nonatomic, assign) float   quatrantSize;
@property (nonatomic, assign) CGPoint mapCenter;

@end
