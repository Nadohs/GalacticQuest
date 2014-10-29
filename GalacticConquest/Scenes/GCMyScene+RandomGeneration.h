//
//  GCMyScene+RandomGeneration.h
//  GalacticConquest
//
//  Created by Rich on 3/17/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

#import "GCMyScene.h"
@class Seedling;
@class Quandrant;

@interface GCMyScene (RandomGeneration)
-(UIColor*)randomColor;
-(CGPoint)randomAstrialPosition;
//-(void)buildSpaceStuff;
-(Quandrant*)buildSpaceStuff:(Seedling*)seed;
@end
