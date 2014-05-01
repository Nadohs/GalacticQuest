//
//  GCEquipViewController.h
//  GalacticConquest
//
//  Created by Rich on 4/27/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InventoryManager.h"
#import "UIViewController+InventoryTable.h"


@interface GCEquipViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *inventoryTable;
- (IBAction)equipmentButton:(id)sender;

- (IBAction)exitButtonPressed:(id)sender;
@end
