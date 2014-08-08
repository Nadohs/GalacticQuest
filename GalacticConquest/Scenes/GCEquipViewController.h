//
//  GCEquipViewController.h
//  GalacticConquest
//
//  Created by Rich on 4/27/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIViewController+InventoryTable.h"


@interface GCEquipViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *inventoryTable;

- (IBAction)equipmentButton:(id)sender;

- (IBAction)exitButtonPressed:(id)sender;
@end
