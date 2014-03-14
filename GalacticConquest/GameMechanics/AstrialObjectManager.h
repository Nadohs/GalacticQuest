//
//  AstrialObjectManager.h
//  GalacticConquest
//
//  Created by Rich on 3/7/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface AstrialObjectManager : NSObject

@property (nonatomic) SKNode *background;
@property (nonatomic) NSMutableArray *astrialObjects;

-(void)addCollidable:(AstrialObject*)astrialObj;
-(void)addNonCollidable:(AstrialObject*)astrialObj;

+ (AstrialObjectManager *) sharedManager;
@end
