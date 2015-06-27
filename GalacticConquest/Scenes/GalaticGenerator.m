//
//  GalaticGenerator.m
//  GalacticConquest
//
//  Created by Rich on 10/28/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

#import "GalaticGenerator.h"

#import "SpaceStation.h"
#import "AstrialObjectManager.h"

#import "Seedling.h"
#import "Quandrant.h"

@interface GalaticGenerator()

@property (nonatomic,assign)CGPoint currentCoord;
@end

@implementation GalaticGenerator


#pragma mark - 

-(CGPoint)coordForPos:(CGPoint)curPos{
    
    float posX = curPos.x;// - (self.quatrantSize/2);
    float posY = curPos.y ;//- (self.quatrantSize/2);
    
    long quadX = posX / self.quatrantSize;
    long quadY = posY / self.quatrantSize;
    NSLog(@"posX:   %f,PosY:   %f", posX, posY);
    NSLog(@"coordX: %f,coordY: %f", quadX, quadY);
    if (posX < 0||posY<0) {
        
    }
    return CGPointMake(quadX,quadY);
}



#pragma mark - random generated stuff

-(UIColor*)randomColor{
    // I WANT NICE SOLD COLORS,
    // SO I DECIDED NOT TO SIMPLY RANDOMIZE RGB VALUES
    
    int q= random()%16;
    switch (q) {
        case 1:
            return [UIColor blackColor];
            break;
        case 2:
            return [UIColor darkGrayColor];
            break;
        case 3:
            return [UIColor lightGrayColor];
            break;
        case 4:
            return [UIColor whiteColor];
            break;
        case 5:
            return [UIColor yellowColor];
            break;
        case 6:
            return [UIColor darkGrayColor];
            break;
        case 7:
            return [UIColor cyanColor];
            break;
        case 8:
            return [UIColor blueColor];
            break;
        case 9:
            return [UIColor greenColor];
            break;
        case 10:
            return [UIColor darkGrayColor];
            break;
        case 11:
            return [UIColor redColor];
            break;
        case 12:
            return [UIColor grayColor];
            break;
        case 13:
            return [UIColor magentaColor];
            break;
        case 14:
            return [UIColor orangeColor];
            break;
        case 15:
            return [UIColor purpleColor];
            break;
        case 0:
            return [UIColor brownColor];
            break;
        default:
            break;
    }
    return [UIColor blueColor];
}

-(CGPoint)adjMapCenter{
    CGPoint mCenter = self.mapCenter;
    mCenter.x += self.quatrantSize * _currentCoord.x;
    mCenter.y += self.quatrantSize * _currentCoord.y;
    
    return mCenter;
}


//-(CGPoint)centerFromCoord:(CGPoint)coord{
//    CGPoint mCenter;
// 
//    
//    
//    return mCenter;
//}


-(CGPoint)randomAstrialPosition{
    
    float mapBreakLeft = self.adjMapCenter.x - self.quatrantSize/2;
 // float mapBreakRight= self.mapCenter.x + self.quatrantSize/2;
 // float mapBreakUp   = self.mapCenter.y + self.quatrantSize/2;
    float mapBreakDown = self.adjMapCenter.y - self.quatrantSize/2;
    
    float newX = mapBreakLeft + random() % (int)(self.quatrantSize);
    float newY = mapBreakDown + random() % (int)(self.quatrantSize);
    
    return CGPointMake(newX, newY);
}



-(Quandrant*)buildSpaceStuff:(Seedling*)seed{
    
    _currentCoord = seed.coord;
    
    //PROCEDURAL GENERATION BOUNDARY CALCULATIONS
    //max      ==  4294967295
    //min      == -2147483648
    //range    ==  6442450944  (2147483648 * 3)
    //midPoint ==  1073741824 (3221225472 + -2147483648)
    //lowMid   == -2147483648 to 1073741823
    //midHigh  ==  1073741824 to 4294967295
    
    
    //SEED PROCEDURALLY GENERATED MAP WITH srandom();
    srandom(seed.seedMain);
    
    //DIRECTIONAL SEED
    int throwAway = random() % seed.seedDirection;
    NSLog(@"seed directional res = %i", throwAway);
    
//    [[AstrialObjectManager sharedManager] setBackground:(SKNode*)self.parallaxNodeBackgrounds];
    
    Quandrant*quad = [[Quandrant alloc]init];
    
    quad.seed = seed;
    
    //Build SUNS
    float q = random() % 100;
    
    for (int i = 0; i<q; i++) {
        AstrialObject  *sun = [AstrialObject spriteNodeWithImageNamed:@"round_fog"];
        sun.isCollidable = NO;
        sun.seed  = seed;
        sun.color = self.randomColor;
        
        sun.colorBlendFactor = 0.5;
        [sun setPosition:self.randomAstrialPosition];
        NSLog(@"sun is %@",NSStringFromCGPoint(sun.position));
        
        int   randRange = (900*3);
        int   minSize   = 400;
        float sunSize   = minSize + random() % randRange;
        
        if (sunSize>minSize+(randRange/2)) {
            [sun setMmShape:mmBigCircle];
        }
        else{
            [sun setMmShape:mmSmallCircle];
        }
        
        [sun setSize:CGSizeMake(sunSize,sunSize)];
        [quad.astrials addObject:sun];
        //  [[AstrialObjectManager sharedManager] addNonCollidable:sun];
    }
    
    //BUILD ASTROIDS
    q = random() % 100;
    
    for (int i = 0; i<q; i++) {
        AstrialObject  *astroid = [AstrialObject spriteNodeWithImageNamed:@"astroid"];
        astroid.isCollidable = YES;
        astroid.seed  = seed;
        astroid.color = self.randomColor;
        astroid.colorBlendFactor = 0.5;
        [astroid setPosition:self.randomAstrialPosition];
        NSLog(@"sun is %@",NSStringFromCGPoint(astroid.position));
        
        int   randRange = (100*3);
        int   minSize   =  100;
        float sunSize   =  minSize + random() % randRange;
        
        if (sunSize > minSize + (randRange/2) ) {
            [astroid setMmShape:mmBigTriange];
        }
        else{
            [astroid setMmShape:mmSmallTriange];
        }
        
        [astroid setSize:CGSizeMake(sunSize,sunSize)];
        
        [quad.astrials addObject:astroid];
        // [[AstrialObjectManager sharedManager] addCollidable:astroid];
    }
    
    
    //BUILD SPACE STATIONS
    q = random() % 3;
    
    for (int i = 0; i<q; i++) {
        SpaceStation  *spaceStation = [SpaceStation spriteNodeWithImageNamed:@"space_station"];
        spaceStation.isCollidable = YES;
        spaceStation.seed  = seed;
        spaceStation.color = self.randomColor;
        spaceStation.colorBlendFactor = 0.5;
        [spaceStation setPosition:self.randomAstrialPosition];
        NSLog(@"sun is %@",NSStringFromCGPoint(spaceStation.position));
        
        int   randRange = (100*3);
        int   minSize   =  500;
        float sunSize   =  minSize + random() % randRange;
        
        if (sunSize > minSize + (randRange/2)) {
            [spaceStation setMmShape:mmCustomImage];
        }
        else{
            [spaceStation setMmShape:mmCustomImage];
        }
        
        [spaceStation setMmImageName:@"stationIcon"];
        
        [spaceStation setSize:CGSizeMake(sunSize,sunSize)];
        [quad.astrials addObject:spaceStation];
    }
    //    [self startTrackingAstrials];
    
    return quad;
}


-(instancetype)init{
    self = [super init];
    if (self) {
        [self setQuatrantSize:30000];
    }
    return self;
}



@end
