//
//  GCMyScene+RandomGeneration.m
//  GalacticConquest
//
//  Created by Rich on 3/17/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

#import "GCMyScene+RandomGeneration.h"
#import "GCMyScene+MiniMap.h"

@implementation GCMyScene (RandomGeneration)




#pragma mark - random generated stuff

-(UIColor*)randomColor{
    int q= arc4random()%15;
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

-(CGPoint)randomAstrialPosition{
    
    float mapBreakLeft = self.mapCenter.x - self.quatrantSize/2;
   // float mapBreakRight= self.mapCenter.x + self.quatrantSize/2;
   // float mapBreakUp   = self.mapCenter.y + self.quatrantSize/2;
    float mapBreakDown = self.mapCenter.y - self.quatrantSize/2;
    
    float newX = mapBreakLeft + arc4random() % (int)(self.quatrantSize);
    float newY = mapBreakDown + arc4random() % (int)(self.quatrantSize);
    
    return CGPointMake(newX, newY);
}


-(void)buildSpaceStuff{
    [[AstrialObjectManager sharedManager] setBackground:self.parallaxNodeBackgrounds];
    
    //Build SUNS
    float q = arc4random() % 100;
    
    for (int i = 0; i<q; i++) {
        AstrialObject  *sun = [AstrialObject spriteNodeWithImageNamed:@"round_fog"];
        sun.color = self.randomColor;
        sun.colorBlendFactor = 0.5;
        [sun setPosition:self.randomAstrialPosition];
        NSLog(@"sun is %@",NSStringFromCGPoint(sun.position));
        
        int   randRange = (900*3);
        int   minSize   = 400;
        float sunSize   = minSize + arc4random() % randRange;
        
        if (sunSize>400+(randRange/2)) {
            [sun setMmShape:mmBigSquare];
        }
        else{
            [sun setMmShape:mmSmallSquare];
        }
        
        [sun setSize:CGSizeMake(sunSize,sunSize)];
        
        [[AstrialObjectManager sharedManager] addNonCollidable:sun];
    }
    
    //BUILD ASTROIDS
    q = arc4random() % 100;
    
    for (int i = 0; i<q; i++) {
        AstrialObject  *astroid = [AstrialObject spriteNodeWithImageNamed:@"astroid"];
        astroid.color = self.randomColor;
        astroid.colorBlendFactor = 0.5;
        [astroid setPosition:self.randomAstrialPosition];
        NSLog(@"sun is %@",NSStringFromCGPoint(astroid.position));
        
        int   randRange = (100*3);
        int   minSize   = 100;
        float sunSize   = minSize + arc4random() % randRange;
        
        if (sunSize>400+(randRange/2)) {
            [astroid setMmShape:mmBigTriange];
        }
        else{
            [astroid setMmShape:mmSmallTriange];
        }
        
        [astroid setSize:CGSizeMake(sunSize,sunSize)];
        
        [[AstrialObjectManager sharedManager] addCollidable:astroid];
    }
    
    [self startTrackingAstrials];
}




@end
