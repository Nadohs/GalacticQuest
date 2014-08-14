//
//  GCStoreViewController.h
//  GalacticConquest
//
//  Created by Rich on 4/24/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

@import UIKit;

@interface GCStoreViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *sellTable;
- (IBAction)undockPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *buyTable;
- (IBAction)sellButtonPressed:(id)sender;
- (IBAction)buyButtonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *cashLabel;

@end
