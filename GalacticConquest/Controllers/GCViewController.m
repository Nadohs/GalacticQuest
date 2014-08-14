//
//  GCViewController.m
//  GalacticConquest
//
//  Created by Rich on 3/1/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

#import "GCViewController.h"
#import "GCMyScene.h"


@implementation GCViewController

#pragma mark - Store Connections Method



#pragma mark - Nofitication Called Methods

-(void)reloadTableStuff{
    [self.inventoryListTableView reloadData];
}


-(void)closeStoreView{
    
}


-(void)equipView{
    [self performSegueWithIdentifier:@"inventorySegue" sender:self];
}


-(void)openStoreView{//inventorySegue
    [self performSegueWithIdentifier:@"storeSegue" sender:self];
}



#pragma mark - Basic Setup Stuff

-(void)manualUnload{
    [self removeObserver:self forKeyPath:@"reloadInventory"];
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}


-(void)setupNotifications{
    NSNotification* inventoryChangeNotification = [NSNotification notificationWithName:@"reloadInventory" object:self];
    [[NSNotificationCenter defaultCenter] postNotification:inventoryChangeNotification];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadTableStuff)
                                                 name:@"reloadInventory"
                                               object:nil];
    
    NSNotification* storeCallNotification = [NSNotification notificationWithName:@"openStore" object:self];
    [[NSNotificationCenter defaultCenter] postNotification:storeCallNotification];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(openStoreView)
                                                 name:@"openStore"
                                               object:nil];
    NSNotification* equipNotifcation = [NSNotification notificationWithName:@"equipView" object:self];
    [[NSNotificationCenter defaultCenter] postNotification:equipNotifcation];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(equipView)
                                                 name:@"equipView"
                                               object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    _scene = [GCMyScene sceneWithSize:skView.bounds.size];
    _scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:_scene];
    
    CGRect frame = self.inventoryListTableView.frame;
    frame.size.height = 0;
    [self.inventoryListTableView setFrame:frame];
    
    [self setupNotifications];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    [self setEdgesForExtendedLayout:UIRectEdgeNone];


}



- (BOOL)shouldAutorotate
{
    return NO;
}



-(void)viewWillDisappear:(BOOL)animated{
    [self.scene setPaused:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    [self.scene setPaused:NO];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - button action pressed


- (IBAction)inventoryButtonPressed:(id)sender {

}
@end
