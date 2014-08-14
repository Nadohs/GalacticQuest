//
//  GCViewController.h
//  GalacticConquest
//

//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

@import UIKit;
@import SpriteKit;
#import "UIViewController+InventoryTable.h"

@interface GCViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton    *inventoryButton;
@property (weak, nonatomic) IBOutlet UITableView *inventoryListTableView;

@property (strong, nonatomic) SKScene *scene;

-(IBAction)inventoryButtonPressed:(id)sender;
//-(void)openSuperMarket;

@end
