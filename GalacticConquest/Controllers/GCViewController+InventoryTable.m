//
//  GCViewController+InventoryTable.m
//  GalacticConquest
//
//  Created by Rich on 3/15/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

#import "GCViewController+InventoryTable.h"
#import "InventoryManager.h"

@implementation GCViewController (InventoryTable)

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[InventoryManager sharedManager] inventory] count];
}



-(UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"inventoryItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:MyIdentifier] ;
    }
    NSDictionary *oreSet =[[InventoryManager sharedManager] inventory][indexPath.row];

    [(UILabel*)[cell viewWithTag:111] setText:[oreSet objectForKey:@"name"]];
    [(UILabel*)[cell viewWithTag:112] setText:@"an ore"];
    [(UILabel*)[cell viewWithTag:211] setText:[[oreSet objectForKey:@"value"] stringValue]];
    NSLog(@"%@ ore quantity",[[oreSet objectForKey:@"quantity"] stringValue]);
    [(UILabel*)[cell viewWithTag:311] setText:[[oreSet objectForKey:@"quantity"] stringValue]];
    return cell;
}

@end
