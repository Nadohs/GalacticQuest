//
//  InventoryManager.m
//  GalacticConquest
//
//  Created by Rich on 3/14/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

#import "InventoryManager.h"
#import "NameGenerator.h"

@implementation InventoryManager

#pragma mark - manage inventory

-(void)updateInventory{
    NSMutableArray *invList = [[NSMutableArray alloc]init];
    for (NSDictionary *oreSet in self.oreList) {
        if ([[oreSet objectForKey:@"quantity"] intValue]>0) {
            [invList addObject:oreSet];
            //                        forKey:[oreSet objectForKey:@"name"]];
        }
    }
    _inventory = [NSArray arrayWithArray:invList];
    [self sendNotifcationToReloadInventory];
}




-(void)mineRandomOre{
    
    int roll = 1 + arc4random() % 100;
    int oreInRange = arc4random() % 5;
    if (roll >95 && roll <=100) {
        oreInRange+=15;
        //5%
    }
    if (roll >75 && roll <=95) {
        oreInRange+=10;
        //20%
    }
    if (roll >50 && roll <=75) {
        oreInRange+=5;
        //25%
    }
    if (roll >0 && roll <=50) {
        oreInRange+=0;
        //50%
    }
    
    NSDictionary *oreSet = [self.oreList objectAtIndex:oreInRange];
    int newQuant = [[oreSet objectForKey:@"quantity"]intValue]+1;
    NSDictionary *newOreSet = @{@"name":[oreSet objectForKey:@"name"],
                                @"value":[oreSet objectForKey:@"value"],
                                @"quantity":[NSNumber numberWithInt:newQuant] };
    
    [_oreList replaceObjectAtIndex:oreInRange withObject:newOreSet];
    [self updateInventory];
}



#pragma mark - getter

-(NSArray*)oreList{
    return [NSArray arrayWithArray:_oreList];
}

-(void)sendNotifcationToReloadInventory{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadInventory" object:self];
}


#pragma mark - setup ores

-(void)buildOreList{
    _oreList = [[NSMutableArray alloc] initWithCapacity:20];
    NSArray*oresNames = [NameGenerator getRandomNameListQuantity:20];
    int i = 0;
    for (NSString *ore in oresNames) {
        NSNumber *priceValue = @0;
        if (i < 5 && i >=0) {
            int value = arc4random()%100+100;
            priceValue = [NSNumber numberWithInt:value];
        }
        if (i < 10 && i >=5) {
            int value = arc4random()%250+100;
            priceValue = [NSNumber numberWithInt:value];
        }
        if (i < 15 && i >=10) {
            int value = arc4random()%450+100;
            priceValue = [NSNumber numberWithInt:value];
        }
        if (i < 20 && i >=15) {
            int value = arc4random()%1000+100;
            priceValue = [NSNumber numberWithInt:value];
        }
        NSDictionary *oreSet = @{@"name":ore,
                                 @"value":priceValue,
                                 @"quantity":@0 };
        
        [_oreList addObject:oreSet];
        
        i++;
    }
}

-(void)removeItem:(NSString*)item
          forCash:(BOOL)cashIn{
    
    NSMutableArray *invList = [[NSMutableArray alloc]init];
    int q = 0;
    int money = 0;
    for (NSDictionary *oreSet in self.oreList) {
        if ([[oreSet objectForKey:@"name"] isEqualToString:item]) {
            
            NSDictionary *oreSet = [self.oreList objectAtIndex:q];
            int newQuant = [[oreSet objectForKey:@"quantity"]intValue]-1;
            if (newQuant <0) {
                newQuant=0;
            }
            NSDictionary *newOreSet = @{@"name":[oreSet objectForKey:@"name"],
                                        @"value":[oreSet objectForKey:@"value"],
                                        @"quantity":[NSNumber numberWithInt:newQuant] };
            money =[[oreSet objectForKey:@"value"] intValue];
            [_oreList replaceObjectAtIndex:q withObject:newOreSet];
            [self updateInventory];
        }
        q++;
    }
    
    if (cashIn) {
        self.gold += money;
    }
    
    _inventory = [NSArray arrayWithArray:invList];
    [self sendNotifcationToReloadInventory];
    [self updateInventory];
}


#pragma mark - singleton methods

-(void)singletonInit
{
    [self buildOreList];
    _gold = 0;
}




+(InventoryManager *) sharedManager
{
    static InventoryManager *sharedInstance;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        sharedInstance =  [[super allocWithZone:NULL] init];
        [sharedInstance singletonInit];
    });
    return sharedInstance;
}


+(id) allocWithZone:(NSZone *)zone {
    return [InventoryManager sharedManager];
}



@end
