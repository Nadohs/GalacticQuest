//
//  Seedling.h
//  GalacticConquest
//
//  Created by Rich on 10/27/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Seedling : NSObject

@property (nonatomic, assign) unsigned int seedMain;

//first random call is directionalSeed = arcRandom % seed.seedDirection;
//to reseed based on direction of quadrant

@property (nonatomic, assign) int seedDirection;

@property (nonatomic, assign) CGPoint coord;

@end
