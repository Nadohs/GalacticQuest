//
//  SpaceStation.m
//  GalacticConquest
//
//  Created by Rich on 3/17/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

#import "SpaceStation.h"

@implementation SpaceStation

-(void)reduceSize{
    
}


-(void)takeHit:(float)hitPoints location:(CGPoint)hitLocation{
    //open store controller
    [[NSNotificationCenter defaultCenter] postNotificationName:@"openStore" object:self];
}

@end
