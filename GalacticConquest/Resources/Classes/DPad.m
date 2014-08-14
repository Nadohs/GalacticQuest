//
//  DPad.m
//  ProceduralLevelGeneration
//
//  Created by Kim Pedersen on 30/07/13.
//  Copyright (c) 2013 Kim Pedersen. All rights reserved.
//
;

#import "DPad.h"

static const CGFloat kPI_X_2 = M_PI * 2;
static const CGFloat kRAD2DEG = 180.0f / M_PI;
static const CGFloat kDEG2RAD = M_PI / 180.0f;


@implementation DPad
{
    SKShapeNode *base;
    SKShapeNode *stick;
    
    // Touch handling
    BOOL isTouching;
    CFMutableDictionaryRef trackedTouches;
    
    // Optimizations (keep squared values of all radii for faster calculations (updated internally when changing joy/thumb radii)
    CGFloat joystickRadiusSq;
    CGFloat thumbRadiusSq;
    CGFloat deadRadiusSq;
}


- (instancetype) initWithRect:(CGRect)rect
{
    if (( self = [super init] ))
    {
        // Set default property values
        _stickPosition = CGPointZero;
        _degrees = 0.0f;
        _velocity = CGPointZero;
        _autoCenter = YES;
        self.isDPad = YES;
        _hasDeadzone = NO;
        _numberOfDirections = 8;
        self.deadRadius = 0.0f;
        
        self.joystickRadius = CGRectGetWidth(rect) / 2;
        self.thumbRadius = 32.0f;
        self.deadRadius = 0.0f;
        
        // Touch handling
        trackedTouches = CFDictionaryCreateMutable(kCFAllocatorDefault, 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
        
        // Set position of node
        self.position = rect.origin;
        
        // Create base node
        base = [SKShapeNode node];
        base.fillColor = [UIColor grayColor];
        base.strokeColor = [UIColor clearColor];
        base.lineWidth = 0.0f;
        base.path = CGPathCreateWithEllipseInRect(rect, NULL);
        base.alpha = 0.5f;
        
        [self addChild:base];
        
        // Create stick node
        stick = [SKShapeNode node];
        stick.fillColor = [UIColor grayColor];
        stick.strokeColor = [UIColor clearColor];
        stick.lineWidth = 0.0f;
        stick.path = CGPathCreateWithEllipseInRect(CGRectInset(rect, CGRectGetWidth(rect) / 4, CGRectGetHeight(rect) / 4), NULL);
        
        [self addChild:stick];
        
        // Enable touch
        self.userInteractionEnabled = YES;
    }
    return self;
}


- (void) updateVelocity:(CGPoint)point
{
    // Calculate the distance and angle from center
    CGFloat dx = point.x;
    CGFloat dy = point.y;
    CGFloat dSq = dx * dx + dy * dy;
    
    if ( dSq <= deadRadiusSq )
    {
        _velocity = CGPointZero;
        _degrees = 0.0f;
        [self updateStickPosition:point];
        return;
    }
    
    CGFloat angle = atan2f(dy, dx); // in radians
    
    if ( angle < 0 )
        angle += kPI_X_2;
    
    CGFloat cosAngle;
    CGFloat sinAngle;
    
    if ( _isDPad )
    {
        CGFloat anglePerSector = 360.0f / _numberOfDirections * kDEG2RAD;
        angle = roundf(angle / anglePerSector) * anglePerSector;
    }
    
    cosAngle = cosf(angle);
    sinAngle = sinf(angle);
    
    // Note: Velocity goes from -1.0 to 1.0
    if ( dSq > joystickRadiusSq || _isDPad )
    {
        dx = cosAngle * _joystickRadius;
        dy = sinAngle * _joystickRadius;
    }
    
    _velocity = CGPointMake(dx / _joystickRadius, dy / _joystickRadius);
    _degrees = angle * kRAD2DEG;
    
    // Update the thumb's position
    [self updateStickPosition:CGPointMake(dx, dy)];
}


- (void) updateStickPosition:(CGPoint)point
{
    _stickPosition = point;
    stick.position = _stickPosition;
}


#pragma mark Properties

- (void) setIsDPad:(BOOL)isDPad
{
    _isDPad = isDPad;
    
    if ( isDPad )
    {
        _hasDeadzone = YES;
        _deadRadius = 10.0f;
    }
}


- (void) setJoystickRadius:(CGFloat)joystickRadius
{
    _joystickRadius = joystickRadius;
    joystickRadiusSq = joystickRadius * joystickRadius;
}


- (void) setThumbRadius:(CGFloat)thumbRadius
{
    _thumbRadius = thumbRadius;
    thumbRadiusSq = thumbRadius * thumbRadius;
}


- (void) setDeadRadius:(CGFloat)deadRadius
{
    _deadRadius = deadRadius;
    deadRadiusSq = deadRadius * deadRadius;
}



#pragma mark Touch Handling

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.isBeingTouched = YES;
    [touches enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        
        // First determine if the touch is within the boundries of the DPad
        UITouch *touch = (UITouch *)obj;
        
        CGPoint location = [touch locationInNode:self];
        
        location = CGPointMake(location.x - self.joystickRadius, location.y - self.joystickRadius);
        
        if ( !(location.x < -self.joystickRadius || location.x > self.joystickRadius || location.y < -self.joystickRadius || location.y > self.joystickRadius) )
        {
            CGFloat dSq = location.x * location.x + location.y * location.y;
            
            if ( joystickRadiusSq > dSq )
            {
                // Start tracking this touch
                CFDictionarySetValue(trackedTouches, (__bridge void *)touch, (__bridge void *)touch);
                
                // Signal that we have started tracking touches
                isTouching = YES;
                
                // Update the DPad
                [self updateVelocity:location];
                
                // *stop = YES;
                // NSLog(@"Touches being tracked: %li", CFDictionaryGetCount(trackedTouches));
            }
        }
        
    }];
}


- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Only process if we are tracking touches
    if ( isTouching )
    {
        // Determine if any of the touches are one of those being tracked
        [touches enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
            
            UITouch *touch = (UITouch *) CFDictionaryGetValue(trackedTouches, (__bridge void *)(UITouch *)obj);
            
            if ( touch != NULL )
            {
                // This touch is being tracked
                CGPoint location = [touch locationInNode:self];
                
                location = CGPointMake(location.x - self.joystickRadius, location.y - self.joystickRadius);
                
                [self updateVelocity:location];
            }
            
        }];
    }
}
-(void)forceStop{
    CGPoint location = CGPointZero;
//    
//    if ( !_autoCenter )
//    {
//        location = [touch locationInNode:self];
//        location = CGPointMake(location.x - self.joystickRadius, location.y - self.joystickRadius);
//    }
    
    [self updateVelocity:location];
}


- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.isBeingTouched = NO;
    if ( isTouching )
    {
        [touches enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
            
            // Determine if this is a tracked touch
            UITouch *touch = (UITouch *) CFDictionaryGetValue(trackedTouches, (__bridge void *)(UITouch *)obj);
            
            if ( touch != NULL )
            {
                // This touch was being tracked
                CGPoint location = CGPointZero;
                
                if ( !_autoCenter )
                {
                    location = [touch locationInNode:self];
                    location = CGPointMake(location.x - self.joystickRadius, location.y - self.joystickRadius);
                }
                
//                [self updateVelocity:location];
               //x [self updateVelocity:CGPointMake(834291.2, 0)];
                
                
                // Remove the touch as we are no longer tracking it
                CFDictionaryRemoveValue(trackedTouches, (__bridge void *)touch);
                
                // NSLog(@"Touches still being tracked: %li", CFDictionaryGetCount(trackedTouches));
            }
            
        }];
    }
}


- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
        self.isBeingTouched = NO;
    [self touchesEnded:touches withEvent:event];
}

@end
