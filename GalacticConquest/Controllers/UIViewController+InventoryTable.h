//
//  UIViewController+InventoryTable.h
//  GalacticConquest
//
//  Created by Rich on 4/27/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

@import UIKit;

@interface UIViewController (InventoryTable)

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
