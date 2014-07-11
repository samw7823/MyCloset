//
//  CLOSCreateItemViewController.m
//  myCloset
//
//  Created by Ruoxi Tan on 7/10/14.
//  Copyright (c) 2014 ___rpinsker___. All rights reserved.
//

#import "CLOSCreateItemViewController.h"
#import "CLOSCreateClosetViewController.h"
#import "CLOSIndividualClosetViewController.h"
@interface CLOSCreateItemViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation CLOSCreateItemViewController

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
    if (self.image) self.imageView.image = self.image;
}


- (IBAction)finishCreating:(id)sender {
    
    if (self.presentingViewController.presentingViewController) {
        
        //TODO: give closet view the information it needs
        CLOSIndividualClosetViewController *closetvc = [[CLOSIndividualClosetViewController alloc] init];
        
        UITabBarController *tabBar = (UITabBarController *)(self.presentingViewController.presentingViewController);
        tabBar.selectedIndex = 0;

        [tabBar dismissViewControllerAnimated:YES completion:^{
            
            //TODO:if profileView is wrapped in a navigation controller, come back here and change how closet view is presented
            tabBar.selectedViewController.hidesBottomBarWhenPushed = NO;
                    [tabBar.selectedViewController presentViewController:closetvc animated:NO completion:NULL];
        }];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
