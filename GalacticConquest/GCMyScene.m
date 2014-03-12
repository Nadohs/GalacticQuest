//
//  GCMyScene.m
//  GalacticConquest
//
//  Created by Rich on 3/1/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

#import "GCMyScene.h"
#import "GCMyScene+MiniMap.h"
#import "AstrialObjectManager.h"

@implementation GCMyScene


-(NSArray*)astrialObjects{
    return (NSArray*)[[AstrialObjectManager sharedManager] astrialObjects];
}


-(void)setupBackground{
#pragma mark - Game Backgrounds
    //1
    //NSArray *parallaxBackgroundNames = @[@"Trifid_Nebula@2x.png"];
    CGSize planetSizes = CGSizeMake(2000.0, 1333.0);
    _parallaxNodeBackgrounds = [[FMMParallaxNode alloc] initWithBackground:@"Trifid_Nebula@2x.png"
                                                                       size:planetSizes
                                                       pointsPerSecondSpeed:125.0];
     _parallaxNodeBackgrounds.position = CGPointMake((self.size.width/2.0)-planetSizes.width/2, (self.size.height/2.0)-planetSizes.height/2);
    [_parallaxNodeBackgrounds randomizeNodesPositions];
    [self addChild:_parallaxNodeBackgrounds];
}


-(void)setupDpad{
    //HUD overlay
    self.hud = [SKNode node];
    
    // Create the DPads
    self.dPad = [[DPad alloc] initWithRect:CGRectMake(0, 0, 64.0f, 64.0f)];
    self.dPad.position = CGPointMake(64.0f / 4, 64.0f / 4);
    self.dPad.numberOfDirections = 24;
    self.dPad.deadRadius = 8.0f;
    
    [self.hud addChild:self.dPad];
    
    // Add the world and hud nodes to the scene
    //        [self addChild:self.world];
    [self addChild:self.hud];
}

//fire button
- (void)setupStopPedal
{
    _stopPedal = [SKSpriteNode spriteNodeWithImageNamed:@"stop_pedal"];
    _stopPedal.position = CGPointMake(self.size.width-_stopPedal.size.width/2,self.dPad.position.y+20);
   [_stopPedal setScale:0.6];
    _stopPedal.name = @"stopPedal";//how the node is identified later
    _stopPedal.zPosition = 1.0;
    [self.hud addChild:_stopPedal];
    
}
-(void)setupFireButton{
    SKSpriteNode *fireButton = [SKSpriteNode spriteNodeWithImageNamed:@"fire_button"];
    fireButton.position = CGPointMake(_stopPedal.position.x, _stopPedal.position.y+fireButton.size.height);
    [_stopPedal setName:@"fireButton"];
    [self.hud addChild:fireButton];
}



-(void)setupHUD
{
    [self setupStopPedal];
    [self setupFireButton];
}


-(void)addTitleLabel{
    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    myLabel.text = @"Hello, World!";
    myLabel.fontSize = 30;
    myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMidY(self.frame));
    [self addChild:myLabel];
}


-(void)setupItem{
     SKSpriteNode  *sun = [SKSpriteNode spriteNodeWithImageNamed:@"round_fog"];
     sun.color = [SKColor redColor];
     sun.colorBlendFactor = 0.5;
    
    [sun setSize:CGSizeMake(900, 900)];
     sun.position = CGPointMake(self.size.width/2+300, self.size.height/2);
    [sun setName:@"theSun"];
    
    [self.parallaxNodeBackgrounds addChild:sun];
}


-(void)setupShipToLocation:(CGPoint)location{
    NSLog(@"Center is %@",NSStringFromCGPoint(location));
     self.ship = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
    [self.ship setSize:CGSizeMake(50, 50)];
    
     self.ship.position = location;
    [self addChild:self.ship];
    [self.ship setName:@"playerShip"];
    
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor blackColor];
        
        [self setQuatrantSize:30000];
        [self setupBackground];
        [self setupDpad];
        [self setupShipToLocation:CGPointMake(self.size.width/2,
                                              self.size.height/2)];
       [self addThruster];
        [self setupItem];
        [self setupHUD];

        [self buildMiniMap];
        [self buildSpaceStuff];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
    CGPoint location = [touch locationInNode:self];
    }
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    //Call Touch Action
    if ([node.name isEqualToString:@"stopPedal"]) {
        [self.dPad forceStop];
    }
    if ([node.name isEqualToString:@"fireButton"]) {
        [self.dPad forceStop];
    }
}

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

    float mapBreakLeft = self.mapCenter.x - _quatrantSize/2;
    float mapBreakRight= self.mapCenter.x + _quatrantSize/2;
    float mapBreakUp   = self.mapCenter.y + _quatrantSize/2;
    float mapBreakDown = self.mapCenter.y - _quatrantSize/2;
    
    float newX = mapBreakLeft + arc4random() % (int)(self.quatrantSize);
    float newY = mapBreakDown + arc4random() % (int)(self.quatrantSize);
    
    return CGPointMake(newX, newY);
}


-(void)buildSpaceStuff{
    [[AstrialObjectManager sharedManager] setBackground:self.parallaxNodeBackgrounds];
    float q = arc4random() % 100;
    
    for (int i = 0; i<q; i++) {
        SKSpriteNode  *sun = [SKSpriteNode spriteNodeWithImageNamed:@"round_fog"];
        sun.color = self.randomColor;
        sun.colorBlendFactor = 0.5;
        [sun setPosition:self.randomAstrialPosition];
        NSLog(@"sun is %@",NSStringFromCGPoint(sun.position));
        float sunSize = 400+ arc4random() % (900*3);
        [sun setSize:CGSizeMake(sunSize,sunSize)];
        
        [[AstrialObjectManager sharedManager] addCollidable:sun];
    }
    
    [self startTrackingAstrials];
}
-(void)addThruster{

    NSString *burstPath =
        [[NSBundle mainBundle]
         pathForResource:@"thruster1" ofType:@"sks"];

        
    self.burstNode =
        [NSKeyedUnarchiver unarchiveObjectWithFile:burstPath];

    self.burstNode.position = CGPointMake(0, -self.ship.size.height+20);
    
    [self.ship addChild:self.burstNode];
    
    SKAction *action2 = [SKAction rotateToAngle:M_PI*1.0 duration:0];

    [self.burstNode runAction:action2];

}

-(void)update:(CFTimeInterval)currentTime {
    NSLog(@"PLR POS IS %@",NSStringFromCGPoint([self convertPoint:[self childNodeWithName:@"playerShip"].position
                                                                  toNode:_parallaxNodeBackgrounds]));
    NSLog(@"SUN2 POS IS %@",NSStringFromCGPoint([_parallaxNodeBackgrounds childNodeWithName:@"theSun"].position));
    CGPoint newVelocity = self.dPad.velocity;
    
    if  ((self.currentAngle !=self.dPad.degrees)&&
        !(newVelocity.x==0&&newVelocity.y==0)){
        float newAngle = self.dPad.degrees;
        newAngle -=90;

        NSLog(@"has action? %i",[self hasActions]);
        SKAction *action = [SKAction rotateToAngle:0 duration:0];
        
        NSLog(@"degree to rotate %f",self.dPad.degrees);

        NSLog(@"adjAng to rotate %f",newAngle);
        
        newAngle = M_PI*newAngle/180;
        NSLog(@"angle %f",newAngle);
        
        SKAction *action2 = [SKAction rotateToAngle:newAngle duration:0];
        [self.ship runAction:action completion:^{
        [self.ship runAction:action2];
        }];
        [self.ship runAction:action2];
        self.currentAngle = self.dPad.degrees;
    }


    if (newVelocity.x==0&&newVelocity.y==0) {
        [self.burstNode setParticleSpeed:1];
    }
    else{
        [self.burstNode setParticleSpeed:200];
    }
    
    if (newVelocity.x!=834291.2) {
        [_parallaxNodeBackgrounds updateVelocity:newVelocity withTime:currentTime];
    }
    
    [_parallaxNodeBackgrounds update:currentTime];
    [self miniMapUpdate];
}


@end
