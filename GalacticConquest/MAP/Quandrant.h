//
//  Quandrant.h
//  GalacticConquest
//
//  Created by Rich on 5/11/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//
@class Seedling;
@interface Quandrant : NSObject

@property (nonatomic,strong) Seedling *seed;
@property (nonatomic,assign) CGPoint coordinates;
@property (nonatomic,strong) NSMutableArray *astrials;

@end
