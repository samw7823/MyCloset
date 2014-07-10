//
//  CLOSloginViewController.m
//  myCloset
//
//  Created by Ruoxi Tan on 7/10/14.
//  Copyright (c) 2014 ___rpinsker___. All rights reserved.
//

#import "CLOSloginViewController.h"

#import "CLOSProfileViewController.h"
#import "CLOSSearchViewController.h"
#import "CLOSCameraViewController.h"
#import "CLOSInventoryViewController.h"
#import "CLOSsignUpViewController.h"

#import <Parse/Parse.h>

@interface CLOSloginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation CLOSloginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
    return self;
}


-(IBAction)login:(id)sender
{

    [self.view endEditing:YES];
    
    NSError *error;
    
    [PFUser logInWithUsername:self.username.text password:self.password.text error: &error];
    
    if ([PFUser currentUser]) {
        
        NSLog(@"There is current user");
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
    } else {
        NSLog(@"Error logging in: %@", error);
    }
}
- (IBAction)makeNewAccount:(id)sender {
    [self.view endEditing:YES];
    
    CLOSsignUpViewController *signUpvc = [[CLOSsignUpViewController alloc] init];
    [self presentViewController:signUpvc animated:YES completion:nil];
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(backgroundTouched)];
    [self.view addGestureRecognizer:tap];

}

- (IBAction)backgroundTouched {
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
