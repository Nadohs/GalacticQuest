//
//  InventoryManager.h
//  GalacticConquest
//
//  Created by Rich on 3/14/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

//#import <Foundation/Foundation.h>


@interface InventoryManager : NSObject
//objects are dictionaries
@property (assign, nonatomic) int gold;
@property (strong, nonatomic) NSMutableArray *oreList;
@property (strong, nonatomic) NSArray *inventory;

+(InventoryManager *) sharedManager;
-(void)mineRandomOre;
-(void)removeItem:(NSString*)item forCash:(BOOL)cashIn;

@end
