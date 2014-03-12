//
//  GCMyScene+MiniMap.m
//  GalacticConquest
//
//  Created by Rich on 3/7/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

#import "GCMyScene+MiniMap.h"


@implementation GCMyScene (MiniMap)
-(void)buildMiniMap{
     self.miniMap = [SKSpriteNode spriteNodeWithImageNamed:@"minimap"];
     self.miniMap.position = CGPointMake(self.size.width-self.miniMap.size.width/2,self.size.height-self.miniMap.size.height/2);
    [self.miniMap setScale:1];
     self.miniMap.name = @"miniMap";
     self.miniMap.zPosition = 1.0;
    [self addChild:self.miniMap];
    [self startTrackingShip];
     
}

-(void)startTrackingShip{
    SKSpriteNode *newNode =[SKSpriteNode spriteNodeWithColor:[UIColor orangeColor] size:CGSizeMake(10, 10)];
    [newNode setName:@"mmItem0"];
    [self.miniMap addChild:newNode];
     self.mapCenter = [self convertPoint:[self childNodeWithName:@"playerShip"].position
                toNode:self.parallaxNodeBackgrounds];

}


-(void)startTrackingAstrials{
    
    int itemCount = 1;
    float mapBreakLeft = self.mapCenter.x - self.quatrantSize/2;
    float mapBreakUp = self.mapCenter.y + self.quatrantSize/2;
    
    for (SKSpriteNode*astrialObj in self.astrialObjects) {
        SKSpriteNode *newNode =[SKSpriteNode spriteNodeWithColor:astrialObj.color size:CGSizeMake(5, 5)];
        [newNode setName:[NSString stringWithFormat:@"mmItem%i",itemCount]];
        [self.miniMap addChild:newNode];
        
        CGPoint newPos = [self convertPoint:astrialObj.position
                                     toNode:self.parallaxNodeBackgrounds];
        float newX = (newPos.x - mapBreakLeft)/self.quatrantSize;
        float newY = (newPos.y - mapBreakUp)/self.quatrantSize;
        
        [newNode setPosition:CGPointMake(newX*self.miniMap.size.width-self.miniMap.size.width/2,
                                         newY*self.miniMap.size.height+self.miniMap.size.height/2)];
        itemCount++;
    }
    NSLog(@"astrial counts %i",itemCount);
}




-(void)miniMapUpdate{
    
    float mapBreakLeft = self.mapCenter.x - self.quatrantSize/2;

    float mapBreakUp = self.mapCenter.y + self.quatrantSize/2;
    
    SKSpriteNode *shipDot = (SKSpriteNode*)[self.miniMap childNodeWithName:@"mmItem0"];
    CGPoint newPos = [self convertPoint:[self childNodeWithName:@"playerShip"].position
                                  toNode:self.parallaxNodeBackgrounds];
    float newX = (newPos.x - mapBreakLeft)/self.quatrantSize;
    float newY = (newPos.y - mapBreakUp)/self.quatrantSize;
    
    [shipDot setPosition:CGPointMake(newX*self.miniMap.size.width-self.miniMap.size.width/2,
                                     newY*self.miniMap.size.height+self.miniMap.size.height/2)];
    
}




@end
