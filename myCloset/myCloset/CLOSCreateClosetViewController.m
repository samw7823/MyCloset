//
//  CLOSCreateClosetViewController.m
//  myCloset
//
//  Created by Ruoxi Tan on 7/10/14.
//  Copyright (c) 2014 ___rpinsker___. All rights reserved.
//

#import "CLOSCreateClosetViewController.h"
#import <Parse/Parse.h>

@interface CLOSCreateClosetViewController ()
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@end

@implementation CLOSCreateClosetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)donePressed:(id)sender
{
   // PFUser *currentUser = [PFUser currentUser];
    PFUser *u = [PFUser currentUser];
    
    PFObject *closet = [PFObject objectWithClassName:@"Closet"];
    closet[@"name"] = self.nameTextField.text;
    closet[@"owner"] = u;
    [closet save];

    PFRelation *relation = [u relationForKey:@"ownedClosets"];
    [relation addObject:closet];
    //TODO: allow user to choose own image
   // PFFile *file = [PFFile fileWithName:@"closetDoorImage" contentsAtPath:[[NSBundle mainBundle] pathForResource:@"closetDoor" ofType:@".png"]];
    //closet[@"image"] = file;
    
//    [closet saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//         [self dismissViewControllerAnimated:YES completion:NULL];
//    }];
        [u saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
             [self dismissViewControllerAnimated:YES completion:NULL];
        }];
    
    
    
//    [closet saveInBackground];
//    [closet saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        NSLog(@"saved");
//        [currentUser setObject:closet forKey:@"assocCloset"];
////        [currentUser addObject:closet forKey:@"ownedClosets"];
//        [currentUser saveEventually:^(BOOL succeeded, NSError *error) {
//            NSLog(@"err? %@, succ? %@", error, succeeded ? @"Y" : @"N");
//        }];
//    }];
    
//    NSArray *usersClosets = [currentUser objectForKey:@"ownedClosets"];
//    NSMutableArray *mutableUsersClosets;
//    if (!usersClosets) {
//            mutableUsersClosets = [[NSMutableArray alloc] init];
//    }
//    else {
//        mutableUsersClosets = [usersClosets mutableCopy];
//    }
//    [mutableUsersClosets addObject:closet];
//    currentUser[@"ownedClosets"] = [mutableUsersClosets copy];
    
    


    
   
}

- (IBAction)cancelPressed:(id)sender
{
     [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
