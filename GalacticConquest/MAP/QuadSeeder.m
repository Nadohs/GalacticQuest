//
//  QuadSeeder.m
//  GalacticConquest
//
//  Created by Rich on 5/11/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

#import "QuadSeeder.h"
#import "Seedling.h"
#import "GalaticGenerator.h"
#import "Quandrant.h"
#import "AstrialObject.h"
#import "MapNode.h"
#import "AstrialObjectManager.h"


@interface QuadSeeder ();

@property (nonatomic, assign)    CGPoint lastQuad;
@end



@implementation QuadSeeder

//-(NSMutableArray*)activeAstrials{
//    _activeAstrials =
//}

-(void)calculateActiveAstrials{
    [_activeAstrials removeAllObjects];
    for (Quandrant*quad in [_activeQuadrants copy]) {
        [_activeAstrials addObjectsFromArray:quad.astrials];
    }
}


-(NSArray*)getCollidables{
    NSMutableArray *collidables = [NSMutableArray new];
    for (AstrialObject *ast in [self.activeAstrials copy] ) {
        if (ast.isCollidable) {
            [collidables addObject:ast];
        }

    }
    return [collidables copy];
}


-(BOOL)getItRight{
    return NO;
}


BOOL equalPoints(CGPoint one, CGPoint two){
    if (one.x != two.x) {
        return NO;
    }
    if (one.y != two.y) {
        return NO;
    }
    return YES;
}


//add weak ref to miniMap obj; on astrials

-(void)generateAstrialsFromPos:(CGPoint)pos{
    
    CGPoint current = [_galaticGen coordForPos:pos];
    
    if (current.x ==_lastQuad.x && current.y ==_lastQuad.y) {
        return;
    }
    
    _lastQuad = current;
    
    CGPoint top     = CGPointMake (current.x, current.y+1);
    CGPoint bottom  = CGPointMake (current.x, current.y-1);
    CGPoint left    = CGPointMake (current.x-1, current.y);
    CGPoint right   = CGPointMake (current.x+1, current.y);
    
    NSMutableArray *willAdd = [NSMutableArray new];
    NSMutableArray *willRem = [NSMutableArray new];
    NSMutableArray *seeds   = [NSMutableArray new];
    
    [seeds addObject : [self seedFromQuad:current]];
    [seeds addObject : [self seedFromQuad:top    ]];
    [seeds addObject : [self seedFromQuad:bottom ]];
    [seeds addObject : [self seedFromQuad:left   ]];
    [seeds addObject : [self seedFromQuad:right  ]];
    
    NSArray *curQuads = [_activeQuadrants copy];
    
    for (Quandrant *quad in curQuads) {
        BOOL shouldRemove = YES;
        for (Seedling *seed in seeds) {
            if (equalPoints(seed.coord,quad.coordinates)) {
                shouldRemove = NO;
            }
        }
        if (shouldRemove) {
            [willRem addObject:quad];
            
        }
    }
    

    for (Seedling *seed in seeds) {
        BOOL shouldAdd = YES;
        for (Quandrant *quad in curQuads) {
            if (equalPoints(seed.coord,quad.coordinates)) {
                shouldAdd = NO;
            }
        }
        if (shouldAdd) {
            [willAdd addObject:seed];
        }
    }
    
    
    //removeOldQuads
    for (Quandrant* quads in willRem) {
        [_activeQuadrants removeObject:quads];
        for (AstrialObject*ast in quads.astrials) {
            [ast.mapNode removeFromParent];
            [ast removeFromParent];

        }
    }
    
    
    //removeOldQuads
    for (Seedling*seed in willAdd) {
         Quandrant *quads = [self getQuadAt:seed.coord];
        [_activeQuadrants addObject:quads];
        for (AstrialObject*ast in quads.astrials) {
            if([ast parent]){
                continue;
            }
            [[[AstrialObjectManager sharedManager] background] addChild:ast];
        }
    }
    
    
    [self calculateActiveAstrials];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TrackMapItems" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"postQuadrantText" object:NSStringFromCGPoint(current)];
    
    
    
    
}




-(void)changeSubviews{
    
}


-(Seedling*)seedFromQuad:(CGPoint)coord{
    //Calculate seed;
    
    Seedling *seed = [[Seedling alloc]init];
    [seed setCoord : coord];
    
    double x = fabs( coord.x);
    double y = fabs( coord.y);
    
    double high  = MAX(x, y);
    double low   = MIN(x, y);
    double total = high * high;
    
    if (y>x) {
        [seed setSeedMain:(1 + total - low)];
        return seed;
    }

    double sub = total -    high;
    double pos =  sub  - (high-low) + 1;
    
    [seed setSeedMain:pos];
    return seed;
}



-(Quandrant*)getQuadAt:(CGPoint)coord{
    
    NSString  *key  = NSStringFromCGPoint(coord);
    Quandrant *quad = _processedQuads[key];
    
    if (quad) {
       return quad;
    }
    
    Seedling *seed = [self seedFromQuad  : coord];
    quad =  [_galaticGen buildSpaceStuff : seed];
    
    _processedQuads[key] = quad;
    
    return quad;
}



#pragma mark - singleton methods



-(void)singletonInit
{
    _lastQuad  = CGPointMake(0.1, 0.1);
    _processedQuads  = [NSMutableDictionary new];
    _activeQuadrants = [NSMutableArray      new];
    _activeAstrials  = [NSMutableArray      new];
    _galaticGen      = [GalaticGenerator    new];
}



+(QuadSeeder *) sharedManager
{
    static QuadSeeder *sharedInstance;
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
         sharedInstance = [[super allocWithZone:NULL] init];
        [sharedInstance singletonInit];
    });
    return sharedInstance;
}



+(id) allocWithZone:(NSZone *)zone {
    return [QuadSeeder sharedManager];
}



@end


