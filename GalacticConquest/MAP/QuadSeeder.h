//
//  QuadSeeder.h
//  GalacticConquest
//
//  Created by Rich on 5/11/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

@interface QuadSeeder : NSObject

@property(nonatomic)NSMutableDictionary *processedQuads;

+(QuadSeeder *) sharedManager;


@end
