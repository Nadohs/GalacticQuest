//
//  GCStoreViewController.m
//  GalacticConquest
//
//  Created by Rich on 4/24/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

#import "GCStoreViewController.h"
#import "InventoryManager.h"
@interface GCStoreViewController ()

@end

@implementation GCStoreViewController


#pragma mark -Table Stuff

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[InventoryManager sharedManager] inventory] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"inventoryItem";
    if (tableView == self.buyTable) {
        MyIdentifier = @"BuyItems";
    }
    if  (tableView ==self.sellTable){
        MyIdentifier = @"inventoryItem";
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:MyIdentifier];
    }
    NSDictionary *oreSet =[[InventoryManager sharedManager] inventory][indexPath.row];
    
    [(UILabel*)[cell viewWithTag:111] setText:[oreSet objectForKey:@"name"]];
    [(UILabel*)[cell viewWithTag:112] setText:@"an ore"];
    [(UILabel*)[cell viewWithTag:211] setText:[[oreSet objectForKey:@"value"] stringValue]];
    [(UILabel*)[cell viewWithTag:311] setText:[[oreSet objectForKey:@"quantity"] stringValue]];
    
    NSLog(@"%@ ore quantity",[[oreSet objectForKey:@"quantity"] stringValue]);
    
    return cell;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];
}

-(void)viewDidDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];
}

-(void)updateCashLabel{
    NSString *cash = [NSString stringWithFormat:@"%i",[[InventoryManager sharedManager]gold]];
    [self.cashLabel setText:cash];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)sellButtonPressed:(UIButton*)sender {
    UILabel *nameLabel = (UILabel*)[sender.superview viewWithTag:111];
    [[InventoryManager sharedManager] removeItem:nameLabel.text forCash:YES];
    [self.sellTable reloadData];
    [self updateCashLabel];
}

-(IBAction)buyButtonPressed:(id)sender{
    
}
- (IBAction)undockPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
