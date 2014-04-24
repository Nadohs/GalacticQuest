//
//  GCViewController.h
//  GalacticConquest
//

//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "GCViewController+InventoryTable.h"

@interface GCViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *inventoryButton;
@property (weak, nonatomic) IBOutlet UITableView *inventoryListTableView;

-(IBAction)inventoryButtonPressed:(id)sender;
-(void)openSuperMarket;

@end
