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

@interface CLOSloginViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation CLOSloginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moveUp:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moveDown:) name:UIKeyboardWillHideNotification object:nil];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //redirecting to tab bar
    PFUser *currentUser = [PFUser currentUser];
    
    //Is user cached?
    if (currentUser) {
        NSLog(@"There is current user");
        //set up tabbar view controller
        CLOSProfileViewController *profvc = [[CLOSProfileViewController alloc] init];
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
        tbc.viewControllers = @[profvc, camNav, searchvc, invenvc];
        //        UIBarButtonItem *logout = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(logOut)];
        //        [tbc setToolbarItems:@[logout]];
        
        [self presentViewController:tbc animated:NO completion:nil];
    }

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

////Animations to move up/down view when keyboard appears/disappears
//-(void)moveUp:(NSNotification *)aNotification
//{
//    //Get user info
//    NSDictionary *userInfo = [aNotification userInfo];
//    
//    NSTimeInterval animationDuration;
//    UIViewAnimationCurve animationCurve;
//    CGRect keyboardFrame;
//    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
//    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
//    
//    [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] getValue:&keyboardFrame];
//     //animate
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationCurve:animationCurve];
//    [UIView setAnimationDuration:animationDuration];
//    
//    [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - keyboardFrame.size.height / 4, self.view.frame.size.width, self.view.frame.size.height)];
//    
//    [UIView commitAnimations];
//}
//
//-(void)moveDown:(NSNotification *)aNotification
//{
//    //Get user info
//    NSDictionary *userInfo = [aNotification userInfo];
//    
//    NSTimeInterval animationDuration;
//    UIViewAnimationCurve animationCurve;
//    CGRect keyboardFrame;
//    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
//    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
//    
//    
//    [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] getValue:&keyboardFrame];
//    //animate
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationCurve:animationCurve];
//    [UIView setAnimationDuration:animationDuration];
//    
//    [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + keyboardFrame.size.height / 4, self.view.frame.size.width, self.view.frame.size.height)];
//
//    [UIView commitAnimations];
//}




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
        [self login:textField];
    }
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
