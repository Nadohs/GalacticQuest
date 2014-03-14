//
//  FMMParallaxNode.m
//  SpaceShooter
//
//  Created by Tony Dahbura on 9/9/13.
//  Copyright (c) 2013 fullmoonmanor. All rights reserved.
//

#import "FMMParallaxNode.h"

//static const float BG_POINTS_PER_SEC = 50;


@implementation FMMParallaxNode
{
    
    __block NSMutableArray *_backgrounds;
    NSInteger _numberOfImagesForBackground;
    NSTimeInterval _lastUpdateTime;
    NSTimeInterval _deltaTime;
    float _pointsPerSecondSpeed;
    BOOL _randomizeDuringRollover;
    CGPoint currentVelocity;
    
    
}


- (instancetype)initWithBackground:(NSString *)file size:(CGSize)size pointsPerSecondSpeed:(float)pointsPerSecondSpeed
{
    // we add the file 3 times to avoid image flickering (9)
    return [self initWithBackgrounds:@[file, file, file,file, file, file,file, file, file]
                                size:size
                pointsPerSecondSpeed:pointsPerSecondSpeed];
    
}

- (instancetype)initWithBackgrounds:(NSArray *)files size:(CGSize)size pointsPerSecondSpeed:(float)pointsPerSecondSpeed
{
    if (self = [super init])
    {
        _pointsPerSecondSpeed = pointsPerSecondSpeed;
        _numberOfImagesForBackground = [files count];
        _backgrounds = [NSMutableArray arrayWithCapacity:_numberOfImagesForBackground];
        _randomizeDuringRollover = NO;
        [files enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            //NSLog(@"index is %i",idx);
            int idxx = idx;
            SKSpriteNode *node = [SKSpriteNode spriteNodeWithImageNamed:obj];
            node.size = size;
            node.anchorPoint = CGPointZero;
            node.position = CGPointMake(size.width * idx, 0.0);
            if (idx >= 3&& idx <=5 ) {
                idxx-=3;
            node.position = CGPointMake(size.width *idxx, -size.height);
            }
            if (idx >=6) {
                idxx-=6;
            node.position = CGPointMake(size.width *idxx, size.height);
            }
            node.name = @"background";
            //NSLog(@"node.position = x=%f,y=%f",node.position.x,node.position.y);
            [_backgrounds addObject:node];
            [self addChild:node];
        }];
    }
    return self;
}

// Add new method, above update loop
- (CGFloat)randomValueBetween:(CGFloat)low andValue:(CGFloat)high {
    return (((CGFloat) arc4random() / 0xFFFFFFFFu) * (high - low)) + low;
}


- (void)randomizeNodesPositions
{
    [_backgrounds enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        SKSpriteNode *node = (SKSpriteNode *)obj;
//        [self randomizeNodePosition:node];
        
    }];
    //flag it for random placement each main scroll through
    _randomizeDuringRollover = YES;
    
}


- (void)randomizeNodePosition:(SKSpriteNode *)node
{
//    CGFloat randomOffset = [self randomValueBetween:0 andValue:50];
//    CGFloat randomSign = [self randomValueBetween:0.0 andValue:1000.0]>500.0 ? -1 : 1;
//    randomOffset *= randomSign;
//    NSLog(@"randomsign=%f",randomSign);
//    node.position = CGPointMake(node.position.x,node.position.y+randomOffset);
    
    //I liked this look better for randomizing the placement of the nodes!
    CGFloat randomYPosition = [self randomValueBetween:0
                                              andValue:0];
    node.position = CGPointMake(node.position.x,randomYPosition);
    
}
- (void)update:(NSTimeInterval)currentTime{
    
}


- (void)updateVelocity:(CGPoint)bgVelocity
              withTime:(NSTimeInterval)currentTime{

    
    float maxSpeed = 500;
    bgVelocity.x = -bgVelocity.x*maxSpeed;
    bgVelocity.y = -bgVelocity.y*maxSpeed;

    if (_lastUpdateTime) {
        _deltaTime = currentTime - _lastUpdateTime;
    } else {
        _deltaTime = 0;
    }
    _lastUpdateTime = currentTime;
    

    CGPoint amtToMove = CGPointMake(bgVelocity.x * _deltaTime, bgVelocity.y * _deltaTime);
    amtToMove.x += currentVelocity.x;
    amtToMove.y += currentVelocity.y;


    self.position = CGPointMake(self.position.x+amtToMove.x, self.position.y+amtToMove.y);
    SKNode *backgroundScreen = self.parent;
  //  NSLog(@"SUN POS IS %@",NSStringFromCGPoint([self convertPoint:[self childNodeWithName:@"theSun"].position
//                                                           toNode:backgroundScreen]));

    
    
    [_backgrounds enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        SKSpriteNode *bg = (SKSpriteNode *)obj;
        //NSLog(@"obj %i pos is %@",idx, NSStringFromCGPoint(bg.position));
        CGPoint bgScreenPos = [self convertPoint:bg.position
                                          toNode:backgroundScreen];
        if (bgScreenPos.x <= -bg.size.width)
        {
            bg.position = CGPointMake(bg.position.x + (bg.size.width * 3), bg.position.y);
        }
        if (bgScreenPos.x >= bg.size.width)
        {
            bg.position = CGPointMake(bg.position.x - (bg.size.width * 3), bg.position.y);
        }
        
        if (bgScreenPos.y <= -bg.size.height)
        {
            bg.position = CGPointMake(bg.position.x , bg.position.y + (bg.size.height * 3));
        }
        if (bgScreenPos.y >= bg.size.height)
        {
            bg.position = CGPointMake(bg.position.x , bg.position.y - (bg.size.height * 3));
        }
        if (idx>8) {
            return;
        }
        
    }];
}

@end
