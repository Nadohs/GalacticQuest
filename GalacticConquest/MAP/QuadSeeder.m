//
//  QuadSeeder.m
//  GalacticConquest
//
//  Created by Rich on 5/11/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

#import "QuadSeeder.h"
#import "Seedling.h"

@implementation QuadSeeder



#pragma mark - singleton methods

-(int)stepX:(int)x fromY:(int)y{
    return 0;
}


-(int)stepY:(int)x fromY:(int)y{
    return 0;
}


-(Seedling*)seedFromQuad:(CGPoint)coord{
    //Calculate seed;
    
    Seedling*seed = [[Seedling alloc]init];
    [seed setCoord:coord];
    
    double x =fabs(coord.x);
    double y =fabs(coord.y);
    
    double high  = MAX(x, y);
    double low   = MIN(x, y);
    double total = high * high;
    
    if (y>x) {
        [seed setSeedMain:(1 + total - low)];
        return seed;
    }

    double sub = total - high;
    double pos = sub - (high - low) + 1;
    
    [seed setSeedMain:pos];
    return seed;
}




-(void)singletonInit
{
    _processedQuads = [[NSMutableDictionary alloc]init];
}


-(void)getQuadAt:(CGPoint)coord{
    NSString*key = NSStringFromCGPoint(coord);

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


