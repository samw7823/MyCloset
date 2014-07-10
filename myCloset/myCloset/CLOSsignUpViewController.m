//
//  CLOSsignUpViewController.m
//  myCloset
//
//  Created by Ruoxi Tan on 7/10/14.
//  Copyright (c) 2014 ___rpinsker___. All rights reserved.
//

#import "CLOSsignUpViewController.h"

#import "CLOSProfileViewController.h"
#import "CLOSSearchViewController.h"
#import "CLOSCameraViewController.h"
#import "CLOSInventoryViewController.h"

@interface CLOSsignUpViewController ()

@end

@implementation CLOSsignUpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}



-(IBAction)buttonTapped:(id)sender
{
    
    //TODO: Bring out tab bar once logged in; possibly using NAVIGATION CONTROLLER
    CLOSProfileViewController *profvc = [[CLOSProfileViewController alloc] init];
    profvc.title = @"Profile";
    CLOSCameraViewController *camvc = [[CLOSCameraViewController alloc] init];
    camvc.title = @"Camera";
    CLOSSearchViewController *searchvc = [[CLOSSearchViewController alloc] init];
    searchvc.title = @"Search";
    CLOSInventoryViewController *invenvc = [[CLOSInventoryViewController alloc] init];
    invenvc.title = @"Inventory";
    
    
    UITabBarController *tbc = [[UITabBarController alloc] init];
    
    tbc.viewControllers = @[profvc, camvc, searchvc, invenvc];
    
    
    [self presentViewController:tbc animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
