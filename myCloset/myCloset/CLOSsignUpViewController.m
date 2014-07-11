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
#import "CLOSAppDelegate.h"

#import <Parse/Parse.h>

@interface CLOSsignUpViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation CLOSsignUpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    }
    return self;
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



-(IBAction)signUp:(id)sender
{
    [self.view endEditing:YES];
    PFUser *user = [PFUser user];
    user.username = self.username.text;
    user.password = self.password.text;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"Signed Up");
            NSLog(@"There is current user");
            //set up tabbar view controller
            CLOSProfileViewController *profvc = [[CLOSProfileViewController alloc] init];
            UINavigationController *profNav = [[UINavigationController alloc] initWithRootViewController:profvc];
            profvc.title = @"Profile";
            
            
            CLOSCameraViewController *camvc = [[CLOSCameraViewController alloc] init];
            UINavigationController *camNav = [[UINavigationController alloc] initWithRootViewController:camvc];
            camNav.title = @"Camera";
            
            
            CLOSSearchViewController *searchvc = [[CLOSSearchViewController alloc] init];
            searchvc.title = @"Search";
            CLOSInventoryViewController *invenvc = [[CLOSInventoryViewController alloc] init];
            invenvc.title = @"Inventory";
            
            
            UITabBarController *tbc = [[UITabBarController alloc] init];
            
            //TODO: Do we want logout on the tab bar or only on profile?
            tbc.viewControllers = @[profNav, camNav, searchvc, invenvc];
            //        UIBarButtonItem *logout = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(logOut)];
            //        [tbc setToolbarItems:@[logout]];
            tbc.delegate = (CLOSAppDelegate *)[[UIApplication sharedApplication] delegate];
            [self presentViewController:tbc animated:YES completion:nil];
        } else {
            NSLog(@"Sign up failed with error: %@", error);
        }
    }];
    
}


- (IBAction)backgroundTouched {
    [self.view endEditing:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.username) {
        [textField resignFirstResponder];
        [self.password becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
        [self signUp:textField];
    }
    return YES;
}

- (IBAction)toLogin:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
