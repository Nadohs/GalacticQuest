//
//  InventoryManager.h
//  GalacticConquest
//
//  Created by Rich on 3/14/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NameGenerator.h"

@interface InventoryManager : NSObject
//objects are dictionaries
@property (nonatomic) int gold;
@property (nonatomic) NSMutableArray *oreList;
@property (nonatomic) NSArray *inventory;

+(InventoryManager *) sharedManager;
-(void)mineRandomOre;
-(void)removeItem:(NSString*)item forCash:(BOOL)cashIn;

@end
