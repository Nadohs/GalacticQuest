//
//  GCMyScene.m
//  GalacticConquest
//
//  Created by Rich on 3/1/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

#import "GCMyScene.h"
#import "GCMyScene+MiniMap.h"
//#import "GCMyScene+RandomGeneration.h"

#import "AstrialObjectManager.h"
#import "AstrialObject.h"

#import "DPad.h"
#import "FMMParallaxNode.h"

#import "FiringModule.h"
#import "CollisionManager.h"


#import "QuadSeeder.h"
#import "Quandrant.h"

#import "GalaticGenerator.h"
#import "GCTextureGenerator.h"


@interface GCMyScene ()
@property (nonatomic, strong)GalaticGenerator *galacticGen;
@end

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
    
    
    [self addChild:_parallaxNodeBackgrounds];
}


#pragma mark - Setup Methods

-(void)setupDpad{
    
    //HUD overlay
    self.hud = [SKSpriteNode spriteNodeWithColor:[SKColor clearColor] size:CGSizeMake(screen_width, 250)];
    self.hud.anchorPoint = CGPointMake(0, 0);
    
    [self addChild: self.hud];
    
    // Create the DPads
    self.dPad = [[DPad alloc] initWithRect:CGRectMake(0, 0, 64.0f, 64.0f)];
    self.dPad.position   = CGPointMake(55.0f, 55.0f);
    self.dPad.numberOfDirections = 24;
    self.dPad.deadRadius = 8.0f;
    
    [self.hud addChild:self.dPad];

}


//fire button
- (void)setupStopPedal{
    NSLog(@"screen_width: %f",screen_width);
    _stopPedal = [SKSpriteNode spriteNodeWithImageNamed:@"stop_pedal"];
    _stopPedal.anchorPoint = CGPointMake(0, 0);
    _stopPedal.position = CGPointMake(screen_width-(_stopPedal.size.width/2)-20,self.dPad.position.y -35 );
   [_stopPedal setScale:0.6];
    _stopPedal.name = @"stopPedal";//how the node is identified later
    _stopPedal.zPosition = 1.0;
    [self. hud addChild:_stopPedal];
}



-(void)setupFireButton{
    SKSpriteNode *fireButton = [SKSpriteNode spriteNodeWithImageNamed:@"fire_button"];
       fireButton .anchorPoint = CGPointMake(0, 0);
 
    fireButton.position = CGPointMake(_stopPedal.position.x-5, _stopPedal.position.y+fireButton.size.height+10);
    
    [fireButton setName:@"fireButton"];
    [self.hud addChild:fireButton];
}


-(void)setupStationButton{
     _stationBut = [SKSpriteNode spriteNodeWithImageNamed:@"stationButton"];
     _stationBut.anchorPoint = CGPointMake(0, 0);
     _stationBut.position = CGPointMake(_stopPedal.position.x - (_stationBut.size.width*2), _stopPedal.position.y+5);
    [_stationBut setName:@"stationButton"];
    [self.hud addChild:_stationBut];
}


-(void)setupEquipButton{
     _equipBut = [SKSpriteNode spriteNodeWithImageNamed:@"equipButton"];
     _equipBut.anchorPoint = CGPointMake(0, 0);
     _equipBut.position = CGPointMake(_stopPedal.position.x - (_equipBut.size.width), _stopPedal.position.y+5);
    

    [_equipBut setName:@"equipButton"];
    [self.hud addChild:_equipBut];
}


-(void)setupHUD
{
    [self setupStopPedal];
    [self setupFireButton];
    [self setupStationButton];
    [self setupEquipButton];
    
    NSLog(@"\nstopPedal:%@ \nfireBut:%@\nsEquipBut:%@",NSStringFromCGRect(_stopPedal.frame),@"?",NSStringFromCGRect(_equipBut.frame));
//    [self.hud setPosition:CGPointMake(0, 0)];
    
    [self.hud frame];
    [self.hud setPosition:CGPointMake(0,
                                      0)];//CGPointMake(0, self.hud.frame.size.height*2)];

    NSLog(@"hud frame : %@",NSStringFromCGRect(self.hud.frame));;

}


CGImageRef CGGenerateNoiseImage(CGSize size, CGFloat factor){
//CF_RETURNS_RETAINED {
    NSUInteger bits = fabs(size.width) * fabs(size.height);
    char *rgba = (char *)malloc(bits);
    srand(124);
    
    rgba[0] = (rand() % 256) * factor;;
    
    for(int i = 1; i < bits; ++i){
        int pixel = (rand() % 256) * factor;
        if ((int)rgba[i-1] < 128 && pixel > 128) {
            pixel = (int)rgba[i-1] - 128/8;
        }else{

        }
        rgba[i] = pixel;
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapContext = CGBitmapContextCreate(rgba, fabs(size.width), fabs(size.height),
                                                       8, fabs(size.width), colorSpace, kCGImageAlphaNone);
    CGImageRef image = CGBitmapContextCreateImage(bitmapContext);
    
    CFRelease(bitmapContext);
    CGColorSpaceRelease(colorSpace);
    free(rgba);
    
    return image;
}



-(void)circularNode:(SKSpriteNode*)tile{
//    SKSpriteNode *tile = [SKSpriteNode spriteNodeWithColor:[UIColor   colorWithRed:0.0/255.0
//                                                                             green:128.0/255.0
//                                                                              blue:255.0/255.0
//                                                                             alpha:1.0] size:CGSizeMake(30, 30)];
    SKCropNode* cropNode = [SKCropNode node];
    SKShapeNode* mask = [SKShapeNode node];
    [mask setPath:CGPathCreateWithRoundedRect(CGRectMake(15, -15, 30, 30), 4, 4, nil)];
    [mask setFillColor:[SKColor whiteColor]];
    [cropNode setMaskNode:mask];
    [cropNode addChild:tile];
}


-(void)setupShipToLocation:(CGPoint)location{
    
    NSLog(@"Center is %@",NSStringFromCGPoint(location));
     _ship = [AstrialObject spriteNodeWithImageNamed:@"Spaceship"];
//    CGImageRef imageref = [GCTextureGenerator generateNoiseImageSized:CGSizeMake(500/2,500/2) factor:1 type:0];
//    SKTexture *texture = [SKTexture textureWithCGImage:imageref];//CGsGenerateNoiseImage(CGSizeMake(500/2,500/2),1)];
//    _ship = [AstrialObject spriteNodeWithTexture:texture];

    [self.ship setSize:CGSizeMake(500, 500)];
    
     self.ship.position = location;
    [self addChild:self.ship];
    [self.ship setName:@"playerShip"];
    [self setShipStartPos:self.shipPosition];
    
}

#pragma mark - init method

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        _frameCount =0;
        self.backgroundColor = [SKColor blackColor];
        
        [self setQuatrantSize:30000];
        [self setupBackground];
        [self setupDpad];
        [self setupShipToLocation:CGPointMake(self.size.width  / 2,
                                              self.size.height / 2)];
        [self addThruster];
        [self setupHUD];

        [self buildMiniMap];
        
        [[NSNotificationCenter defaultCenter] addObserver : self
                                                 selector : @selector(startTrackingAstrials)
                                                     name : @"TrackMapItems"
                                                   object : nil];
        
        [[NSNotificationCenter defaultCenter] addObserver : self
                                                 selector : @selector(postQuadrantText:)
                                                     name : @"postQuadrantText"
                                                   object : nil];
        
       // Seedling *seed = [[QuadSeeder sharedManager] seedFromQuad:CGPointMake(0, 0)];
        
        [[AstrialObjectManager sharedManager] setBackground:(SKNode*)self.parallaxNodeBackgrounds];
        
        _galacticGen              = [GalaticGenerator new];
        _galacticGen.mapCenter    = self.mapCenter;
        _galacticGen.quatrantSize = self.quatrantSize;
        

        [[QuadSeeder sharedManager]generateAstrialsFromPos:self.shipPosition];
        
        [[CollisionManager sharedManager] setShip:_ship];
        _bulletBox = [[FiringModule alloc]initWithShip:_ship];
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
    if ([node.name isEqualToString:@"stationButton"]) {
                [self.dPad forceStop];
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"openStore"
         object:nil];
    }
    if ([node.name isEqualToString:@"equipButton"]) {
        [self.dPad forceStop];
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"equipView"
         object:nil];
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
    [[QuadSeeder sharedManager]generateAstrialsFromPos:self.shipPosition];
    [[AstrialObjectManager sharedManager] recalculateLocalCollidablesFrom:self.shipPosition];
}

-(void)update:(CFTimeInterval)currentTime {

    NSLog(@"\nship POS : %@",NSStringFromCGPoint(self.shipPosition));
    [_stationBut setHidden:![[AstrialObjectManager sharedManager]canDock]];
    
    [self.bulletBox update:currentTime];
    
    
    //Check local collidables every 60 frames
    self.frameCount++;
    if (self.frameCount > 60) {
        self.frameCount = 0;
    }
    if (self.frameCount ==1) {
        [[QuadSeeder sharedManager]generateAstrialsFromPos:self.shipPosition];
        [[AstrialObjectManager sharedManager] recalculateLocalCollidablesFrom:self.shipPosition];
    }
    

    CGPoint newVelocity = self.dPad.velocity;
    
    float newAngle = self.dPad.degrees;
    
    newAngle -=90;
    
    //NSLog(@"angle %f",newAngle);
    //NSLog(@"rotation angle dif == %f",(self.currentAngle - newAngle));
    
    float rotateTime = 0.2;

    if  ((self.currentAngle !=newAngle)&&
        !(newVelocity.x==0&&newVelocity.y==0)){

        //NSLog(@"has action? %i",[self hasActions]);
        
        //NSLog(@"degree to rotate %f",self.dPad.degrees);

        //NSLog(@"adjAng to rotate %f",newAngle);
        
        newAngle = M_PI*newAngle/180;
        //NSLog(@"angle %f",newAngle);
        
        
        if (fabs(newAngle-self.currentAngle) > 1) {
            rotateTime = 0;
        }
        
        SKAction *action2 = [SKAction rotateToAngle:newAngle duration:rotateTime];

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
