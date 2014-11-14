//
//  QuadSeeder.h
//  GalacticConquest
//
//  Created by Rich on 5/11/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

@class Seedling;
@class GalaticGenerator;
@class Quandrant;
@class SKNode;

@interface QuadSeeder : NSObject


@property (nonatomic, strong) GalaticGenerator *galaticGen;
@property (nonatomic, strong) NSMutableDictionary *processedQuads;
@property (nonatomic, strong) NSMutableArray *activeAstrials;
@property (nonatomic, strong) NSMutableArray *activeQuadrants;


@property (nonatomic, weak) SKNode *miniMap;
@property (nonatomic, weak) SKNode *galaticMap;

-(NSArray*)getCollidables;



-(void)generateAstrialsFromPos : (CGPoint)pos;

-(Seedling  *) seedFromQuad    : (CGPoint)coord;
    
-(Quandrant *) getQuadAt       : (CGPoint)coord;

+(QuadSeeder*) sharedManager   ;




@end
