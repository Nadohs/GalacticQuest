//
//  Seedling.m
//  GalacticConquest
//
//  Created by Rich on 10/27/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

#import "Seedling.h"

@implementation Seedling

-(void)setCoord:(CGPoint)coord{
    _coord = coord;
    
    if (coord.x <0 && coord.y <0) {
        _seedDirection = 444444;
    }
    else if (coord.x <0 && coord.y >0) {
        _seedDirection = 5555555;
    }
    else if (coord.x >0 && coord.y <0) {
        _seedDirection = 66666666;
    }
    else if (coord.x >0 && coord.y >0) {
        _seedDirection = 777777777;
    }else{//in case of (0,0)
        _seedDirection = 888888888;
    }
}


@end
