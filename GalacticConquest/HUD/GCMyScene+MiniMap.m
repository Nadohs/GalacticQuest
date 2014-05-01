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
     self.miniMap.position = CGPointMake(self.miniMap.size.width/2,(self.size.width - self.miniMap.size.height/4));
    [self.miniMap setScale:1];
     self.miniMap.name = @"miniMap";
     self.miniMap.zPosition = 1.0;
    [self addChild:self.miniMap];
    [self startTrackingShip];
}


-(void)pulseShipIcon{
    SKAction *action1 = [SKAction resizeToWidth:12 height:12 duration:0.1];
    SKAction *action2 = [SKAction resizeToWidth:8 height:8 duration:0.1];
    
    [[self.miniMap childNodeWithName:@"mmItem0" ] runAction:action1 completion:^{
        [[self.miniMap childNodeWithName:@"mmItem0" ] runAction:action2];
    }];
    
    [[self.miniMap childNodeWithName:@"mmItem0" ] setZPosition:2.0];
    [[self.miniMap childNodeWithName:@"mmItem0" ] setZRotation:self.ship.zRotation];
}


-(void)startTrackingShip{
    
    SKSpriteNode * newNode = [AstrialObject spriteNodeWithImageNamed:@"mmShip"];
    [newNode setSize:CGSizeMake(8, 8)];
    [newNode setColor:[UIColor orangeColor]];
     newNode.colorBlendFactor = 1.0;
    [newNode setName:@"mmItem0"];

    [self.miniMap addChild:newNode];
     self.mapCenter = [self convertPoint:[self childNodeWithName:@"playerShip"].position
                                  toNode:self.parallaxNodeBackgrounds];
    
    [NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self
                                   selector:@selector(pulseShipIcon)
                                   userInfo:nil
                                    repeats:YES];
}

-(SKSpriteNode*)astrialIconFromAstrial:(AstrialObject*)astrialObj{
    SKSpriteNode *retNode;
    
    //Change to switch
    
    if (astrialObj.mmShape == mmBigSquare) {
        retNode = [AstrialObject spriteNodeWithColor:astrialObj.color size:CGSizeMake(8, 8)];
    }
    else if (astrialObj.mmShape == mmSmallSquare) {
        retNode = [AstrialObject spriteNodeWithColor:astrialObj.color size:CGSizeMake(4, 4)];
    }
    else if (astrialObj.mmShape == mmBigCircle) {
        retNode = [AstrialObject spriteNodeWithImageNamed:@"mmCircle"];
        [retNode setSize:CGSizeMake(8, 8)];
        [retNode setColor:astrialObj.color];
    }
    else if (astrialObj.mmShape == mmSmallCircle	) {
        retNode = [AstrialObject spriteNodeWithImageNamed:@"mmCircle"];
        [retNode setSize:CGSizeMake(4, 4)];
        [retNode setColor:astrialObj.color];
    }
    else if (astrialObj.mmShape == mmBigTriange) {
        retNode = [AstrialObject spriteNodeWithImageNamed:@"mmTriange"];
        [retNode setSize:CGSizeMake(8, 8)];
        [retNode setColor:astrialObj.color];
    }
    else if (astrialObj.mmShape == mmSmallTriange) {
        retNode = [AstrialObject spriteNodeWithImageNamed:@"mmTriange"];
        [retNode setSize:CGSizeMake(4, 4)];
        [retNode setColor:astrialObj.color];
    }
    else if (astrialObj.mmShape == mmCustomImage) {
        NSString *imgName = astrialObj.mmImageName;
        retNode = [AstrialObject spriteNodeWithImageNamed:imgName];
        [retNode setSize:CGSizeMake(12, 12)];
        [retNode setColor:astrialObj.color];
    }
    retNode.colorBlendFactor = 1.0;
    return retNode;
}


-(void)startTrackingAstrials{
    
    int itemCount = 1;
    float mapBreakLeft = self.mapCenter.x - self.quatrantSize/2;
    float mapBreakUp = self.mapCenter.y + self.quatrantSize/2;
    
    for (SKSpriteNode*dot in [self.miniMap children]){
        if (dot != (SKSpriteNode*)[self.miniMap childNodeWithName:@"mmItem0"]) {
            [dot removeFromParent];
        }
    }
    
    
    for (AstrialObject*astrialObj in self.astrialObjects) {
        SKSpriteNode *newNode =[self astrialIconFromAstrial:astrialObj];
        
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
