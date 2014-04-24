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

-(void)openStoreView{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
    UIViewController *storeView  =  [storyboard instantiateViewControllerWithIdentifier:@"storeController"];
    [self.navigationController pushViewController:storeView animated:YES];
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
    NSNotification* closeStoreCallNotification = [NSNotification notificationWithName:@"closeStore" object:self];
    [[NSNotificationCenter defaultCenter] postNotification:closeStoreCallNotification];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(closeStoreView)
                                                 name:@"closeStore"
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
    [self.inventoryListTableView setHidden:YES];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    [self setEdgesForExtendedLayout:UIRectEdgeNone];


}



- (BOOL)shouldAutorotate
{
    return YES;
}



-(void)viewWillDisappear:(BOOL)animated{
    [self.scene setPaused:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    [self.scene setPaused:NO];
}


- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskPortraitUpsideDown;
    } else {
        return UIInterfaceOrientationMaskPortrait;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - button action pressed


- (IBAction)inventoryButtonPressed:(id)sender {
    BOOL isHidden =self.inventoryListTableView.hidden;
    [self.inventoryListTableView setHidden:!isHidden];
    return;
//    if (self.inventoryListTableView.hidden) {
//        [self.inventoryListTableView setHidden:NO];
//    }
    CGRect frame = self.inventoryListTableView.frame;
    if (frame.size.height == 460) {
        frame.size.height = 0;
    }
    else{
        frame.size.height = 460;
    }

    [self.inventoryListTableView setFrame:frame];
}
@end
