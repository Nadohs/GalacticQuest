//
//  GCViewController.h
//  GalacticConquest
//

//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@interface GCViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *inventoryButton;
- (IBAction)inventoryButtonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *inventoryListTableView;
@end
