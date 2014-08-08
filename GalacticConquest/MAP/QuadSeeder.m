//
//  QuadSeeder.m
//  GalacticConquest
//
//  Created by Rich on 5/11/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

#import "QuadSeeder.h"

@implementation QuadSeeder


#pragma mark - singleton methods

-(int)stepX:(int)x fromY:(int)y{
    return 0;
}


-(int)stepY:(int)x fromY:(int)y{
    return 0;
}


-(int)seedFromQuad:(CGPoint)coord{
    
    return 0;
    
}


-(void)singletonInit
{
    _processedQuads = [[NSMutableDictionary alloc]init];
}


+(QuadSeeder *) sharedManager
{
    static QuadSeeder *sharedInstance;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        sharedInstance =  [[super allocWithZone:NULL] init];
        [sharedInstance singletonInit];
    });
    return sharedInstance;
}


+(id) allocWithZone:(NSZone *)zone {
    return [QuadSeeder sharedManager];
}
@end


