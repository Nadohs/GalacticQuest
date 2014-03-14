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





#pragma mark - Basic Setup Stuff

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
}


- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

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
