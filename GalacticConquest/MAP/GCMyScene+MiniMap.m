//
//  GCMyScene+MiniMap.m
//  GalacticConquest
//
//  Created by Rich on 3/7/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

#import "GCMyScene+MiniMap.h"
#import "MapNode.h"
#import "AstrialObjectManager.h"
#import "AstrialObject.h"
#import "QuadSeeder.h"
#import "GalaticGenerator.h"


@implementation GCMyScene (MiniMap)
-(void)buildMiniMap{
     self.miniMap = [SKSpriteNode spriteNodeWithImageNamed:@"minimap"];
     self.anchorPoint = CGPointMake(0, 0);
     self.miniMap.position = CGPointMake(self.miniMap.size.width/2+10,(screen_height - (self.miniMap.size.height/2)-10));
    [self.miniMap setScale:1];
     self.miniMap.name = @"miniMap";
     self.miniMap.zPosition = 1.0;
    [self addChild:self.miniMap];
    
    self.quadLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial"];;
    self.quadLabel.text = @"Drag this label";
    self.quadLabel.fontSize = 20;
    self.quadLabel.zPosition = self.miniMap.zPosition +3;
    self.quadLabel.fontColor = [UIColor whiteColor];
   //[self.quadLabel setBlendMode:SKBlendModeAdd];
    self.quadLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    
    CGPoint mapBottonPos = CGPointMake(10,(screen_height - (self.miniMap.size.height/2)) - self.miniMap.size.height+ 30);
    
//    mapBottonPos.y += self.miniMap.size.height;
     self.quadLabel.position = mapBottonPos;
    [self   addChild:self.quadLabel];
    [self.quadLabel setText:@"QUADRANT:(0,0)"];
    
    [self startTrackingShip];
}


-(void)postQuadrantText:(NSNotification*)notification{

    
    CGPoint coord = CGPointFromString( [notification object] );
    [self.quadLabel setText:[NSString stringWithFormat:@"QUADRANT (%i,%i)",(int)coord.x,(int)coord.y]];
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
    
    MapNode* newNode = [MapNode spriteNodeWithImageNamed:@"mmShip"];
    [newNode setAstrial:(AstrialObject*)[self childNodeWithName:@"playerShip"]];
    [newNode setSize:CGSizeMake(8, 8)];
    [newNode setColor:[UIColor orangeColor]];
     newNode.colorBlendFactor = 1.0;
    [newNode setName:@"mmItem0"];

    [self.miniMap addChild:newNode];
     self.mapCenter = [self convertPoint:[self childNodeWithName:@"playerShip"].position
                                  toNode:(SKNode*)self.parallaxNodeBackgrounds];
    
    [[[QuadSeeder sharedManager]galaticGen] setMapCenter:self.mapCenter];
    
    
    [NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self
                                   selector:@selector(pulseShipIcon)
                                   userInfo:nil
                                    repeats:YES];
}

-(MapNode*)astrialIconFromAstrial:(AstrialObject*)astrialObj{
    MapNode *retNode;
    
    //Change to switch
    
    
    if (astrialObj.mmShape == mmBigSquare) {
        retNode = [MapNode spriteNodeWithColor:astrialObj.color size:CGSizeMake(8, 8)];
    }
    else if (astrialObj.mmShape == mmSmallSquare) {
        retNode = [MapNode spriteNodeWithColor:astrialObj.color size:CGSizeMake(4, 4)];
    }
    else if (astrialObj.mmShape == mmBigCircle) {
        retNode = [MapNode spriteNodeWithImageNamed:@"mmCircle"];
        [retNode setSize:CGSizeMake(8, 8)];
        [retNode setColor:astrialObj.color];
    }
    else if (astrialObj.mmShape == mmSmallCircle	) {
        retNode = [MapNode spriteNodeWithImageNamed:@"mmCircle"];
        [retNode setSize:CGSizeMake(4, 4)];
        [retNode setColor:astrialObj.color];
    }
    else if (astrialObj.mmShape == mmBigTriange) {
        retNode = [MapNode spriteNodeWithImageNamed:@"mmTriange"];
        [retNode setSize:CGSizeMake(8, 8)];
        [retNode setColor:astrialObj.color];
    }
    else if (astrialObj.mmShape == mmSmallTriange) {
        retNode = [MapNode spriteNodeWithImageNamed:@"mmTriange"];
        [retNode setSize:CGSizeMake(4, 4)];
        [retNode setColor:astrialObj.color];
    }
    else if (astrialObj.mmShape == mmCustomImage) {
        NSString *imgName = astrialObj.mmImageName;
        retNode = [MapNode spriteNodeWithImageNamed:imgName];
        [retNode setSize:CGSizeMake(12, 12)];
        [retNode setColor:astrialObj.color];
    }
    retNode.colorBlendFactor = 1.0;
    return retNode;
}


-(void)startTrackingAstrials{
    
    int itemCount = 1;
    float mapBreakLeft = self.mapCenter.x - self.quatrantSize/2;
    float mapBreakUp   = self.mapCenter.y + self.quatrantSize/2;
    
    for (SKSpriteNode*dot in [self.miniMap children]){
        if (dot != (SKSpriteNode*)[self.miniMap childNodeWithName:@"mmItem0"]) {
            [dot removeFromParent];
        }
    }
    
    
    for (AstrialObject*astrialObj in self.astrialObjects) {
        
        if(astrialObj.mapNode){
            continue;
        }
        
        MapNode *newNode =[self astrialIconFromAstrial:astrialObj];
        
        [astrialObj setMapNode : newNode];
        [newNode    setAstrial : astrialObj];
        
        [newNode setName:[NSString stringWithFormat:@"mmItem%i",itemCount]];

        [self.miniMap addChild:newNode];
        
        CGPoint newPos = [self convertPoint:astrialObj.position
                                     toNode:(SKNode*)self.parallaxNodeBackgrounds];
        
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
    float mapBreakUp   = self.mapCenter.y + self.quatrantSize/2;
    
    SKSpriteNode *shipDot = (SKSpriteNode*)[self.miniMap childNodeWithName:@"mmItem0"];
    
    CGPoint newPos = [self convertPoint:[self childNodeWithName:@"playerShip"].position
                                  toNode:(SKNode*)self.parallaxNodeBackgrounds];
    
    float newX = (newPos.x - mapBreakLeft)/self.quatrantSize;
    float newY = (newPos.y - mapBreakUp) /self.quatrantSize;
    
    CGPoint oldPoint = shipDot.position;
    
    CGPoint newPoint = CGPointMake(newX * self.miniMap.size.width  - self.miniMap.size.width /2,
                                   newY * self.miniMap.size.height + self.miniMap.size.height/2);
    
    newPoint.x = oldPoint.x - newPoint.x;
    newPoint.y = oldPoint.y - newPoint.y;

    for (MapNode *node in [self.miniMap children]){
        
        if ([node.name isEqualToString:@"mmItem0"]) {
            continue;
        }
        if ( node.astrial.size.width < 30){
            [node.astrial removeFromParent];
            [[AstrialObjectManager sharedManager] killAstrial:node.astrial];
            [node removeFromParent];
            [node setHidden:YES];
        }
        
        SKNode *astrialObj = node.astrial;
        
        CGPoint newPos = [self convertPoint:astrialObj.position
                                     toNode:(SKNode*)self.parallaxNodeBackgrounds];
        
        float newX = (newPos.x - mapBreakLeft)/self.quatrantSize;
        float newY = (newPos.y - mapBreakUp)/self.quatrantSize;
        
        CGPoint noOffset = CGPointMake(newX*self.miniMap.size.width  - self.miniMap.size.width/2,
                                       newY*self.miniMap.size.height + self.miniMap.size.height/2);
        
        newPos.x = noOffset.x + 2*(newPoint.x);
        newPos.y = noOffset.y + 2*(newPoint.y);
        
        [node setPosition:newPos];
        
        //Check if mapNode is off of grid
        CGRect mapRect;
        mapRect.size = self.miniMap.size;
        mapRect.origin = CGPointMake(-self.miniMap.size.width/2,
                                     -self.miniMap.size.height/2);

        if (CGRectContainsPoint(mapRect, node.position)) {
            [node setHidden:NO];
        }else{
            [node setHidden:YES];
        }
        
    }
    
    [self.quadLabel setZPosition:20];
}




@end
