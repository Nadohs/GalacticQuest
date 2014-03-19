//
//  GCMyScene.m
//  GalacticConquest
//
//  Created by Rich on 3/1/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

#import "GCMyScene.h"
#import "GCMyScene+MiniMap.h"
#import "GCMyScene+RandomGeneration.h"
#import "AstrialObjectManager.h"


@implementation GCMyScene

#pragma mark - getters


-(NSArray*)astrialObjects{
    return (NSArray*)[[AstrialObjectManager sharedManager] astrialObjects];
}

-(CGPoint)shipPosition{
   return  [self convertPoint:[self childNodeWithName:@"playerShip"].position
                toNode:self.parallaxNodeBackgrounds];
}


#pragma mark - Game Backgrounds

-(void)setupBackground{

    //1
    //NSArray *parallaxBackgroundNames = @[@"Trifid_Nebula@2x.png"];
    CGSize planetSizes = CGSizeMake(2000.0, 1333.0);
    _parallaxNodeBackgrounds = [[FMMParallaxNode alloc] initWithBackground:@"Trifid_Nebula@2x.png"
                                                                       size:planetSizes
                                                       pointsPerSecondSpeed:125.0];
    
     _parallaxNodeBackgrounds.position = CGPointMake((self.size.width/2.0)-planetSizes.width/2,
                                                     (self.size.height/2.0)-planetSizes.height/2);
    
    [_parallaxNodeBackgrounds randomizeNodesPositions];
    
    [self addChild:_parallaxNodeBackgrounds];
}


#pragma mark - Setup Methods

-(void)setupDpad{
    
    //HUD overlay
    self.hud = [SKNode node];
    
    // Create the DPads
    self.dPad = [[DPad alloc] initWithRect:CGRectMake(0, 0, 64.0f, 64.0f)];
    self.dPad.position = CGPointMake(64.0f / 4, 64.0f / 4);
    self.dPad.numberOfDirections = 24;
    self.dPad.deadRadius = 8.0f;
    
    [self.hud addChild:self.dPad];
    
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
    [fireButton setName:@"fireButton"];
    [self.hud addChild:fireButton];
}



-(void)setupHUD
{
    [self setupStopPedal];
    [self setupFireButton];
}



-(void)setupShipToLocation:(CGPoint)location{
    NSLog(@"Center is %@",NSStringFromCGPoint(location));
     self.ship = [AstrialObject spriteNodeWithImageNamed:@"Spaceship"];
    [self.ship setSize:CGSizeMake(50, 50)];
    
     self.ship.position = location;
    [self addChild:self.ship];
    [self.ship setName:@"playerShip"];
    [self setShipStartPos:self.shipPosition];
    
}

#pragma mark - init method

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor blackColor];
        
        [self setQuatrantSize:30000];
        [self setupBackground];
        [self setupDpad];
        [self setupShipToLocation:CGPointMake(self.size.width  / 2,
                                              self.size.height / 2)];
        [self addThruster];
        [self setupHUD];

        [self buildMiniMap];
        [self buildSpaceStuff];
        _bulletBox = [[FiringModule alloc]init];
        [[AstrialObjectManager sharedManager] recalculateLocalCollidablesFrom:self.shipPosition];
    }
    return self;
}


#pragma mark - Touch Events

-(void)fireButtonPressed{
    [self.bulletBox addBasicProjectileAngle:self.currentAngle startPoint:self.shipPosition];
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
        [self fireButtonPressed];
    }
}


#pragma mark - Particle Stuff

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


#pragma mark - update method

-(void)checkShipDrift:(float)drift{
    CGPoint curPos = self.shipPosition;
    if (drift > fabs(curPos.x - self.shipStartPos.x)) {
        return;
    }
    if (drift > fabs(curPos.y - self.shipStartPos.y)) {
        return;
    }
    self.shipStartPos = curPos;
    [[AstrialObjectManager sharedManager] recalculateLocalCollidablesFrom:self.shipPosition];
}

-(void)update:(CFTimeInterval)currentTime {

    [self.bulletBox update:currentTime];
    
    [self checkShipDrift:500];

    CGPoint newVelocity = self.dPad.velocity;
    
    float newAngle = self.dPad.degrees;
    
    newAngle -=90;
    
    NSLog(@"angle %f",newAngle);
    NSLog(@"rotation angle dif == %f",(self.currentAngle - newAngle));
    
    float rotateTime = 0.2;

    if  ((self.currentAngle !=newAngle)&&
        !(newVelocity.x==0&&newVelocity.y==0)){


        NSLog(@"has action? %i",[self hasActions]);
        
        NSLog(@"degree to rotate %f",self.dPad.degrees);

        NSLog(@"adjAng to rotate %f",newAngle);
        

        
        newAngle = M_PI*newAngle/180;
        NSLog(@"angle %f",newAngle);
        
        
        if (fabs(newAngle-self.currentAngle)>1) {
            rotateTime = 0;
        }
        
        SKAction *action2 = [SKAction rotateToAngle:newAngle duration:rotateTime
                             ];

        [self.ship runAction:action2];
        
        self.currentAngle = newAngle;

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
