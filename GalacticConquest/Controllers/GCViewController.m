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

-(void)reloadTableStuff{
    [self.inventoryListTableView reloadData];
}



#pragma mark - Basic Setup Stuff

-(void)manualUnload{
    [self removeObserver:self forKeyPath:@"reloadInventory"];
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    SKScene * scene = [GCMyScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
    
    CGRect frame = self.inventoryListTableView.frame;
    frame.size.height = 0;
    [self.inventoryListTableView setFrame:frame];
    
     NSNotification* inventoryChangeNotification = [NSNotification notificationWithName:@"reloadInventory" object:self];
    [[NSNotificationCenter defaultCenter] postNotification:inventoryChangeNotification];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadTableStuff)
                                                 name:@"reloadInventory"
                                               object:nil];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];

}



- (BOOL)shouldAutorotate
{
    return YES;
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
