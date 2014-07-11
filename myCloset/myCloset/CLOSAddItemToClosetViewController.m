//
//  CLOSAddItemToClosetViewController.m
//  myCloset
//
//  Created by Samantha Wiener on 7/11/14.
//  Copyright (c) 2014 ___rpinsker___. All rights reserved.
//

#import "CLOSAddItemToClosetViewController.h"
#import "CLOSProfileViewController.h"
#import <Parse/Parse.h>
#import "CLOSClosetCell.h"
#import "CLOSCreateClosetViewController.h"

@interface CLOSAddItemToClosetViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) PFUser *user;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (strong, nonatomic) NSArray *myClosets;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;


@end

@implementation CLOSAddItemToClosetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)addItemCloset:(id)sender {
    //Switch to create closet view control
    CLOSCreateClosetViewController *createClosetvc = [[CLOSCreateClosetViewController alloc] init];
    [self presentViewController:createClosetvc animated:YES completion:NULL];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    
    UINib *cellNib = [UINib nibWithNibName:@"CLOSClosetCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"ClosetCell"];
    NSLog(@"registered nib");

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(150, 150)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    

    [self.collectionView setCollectionViewLayout:flowLayout];
    
    self.user = [PFUser currentUser];
    PFQuery *closetsQuery = [PFQuery queryWithClassName:@"Closet"];
    [closetsQuery whereKey:@"owner" equalTo:self.user];
    self.myClosets = [[closetsQuery findObjects] copy];


    NSString *username = [NSString stringWithFormat:@"%@'s closets",self.user.username];
    self.navBar.topItem.title = username;
    
    

    

    
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //TODO: cell not getting dequeued!!!
    
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"ClosetCell" forIndexPath:indexPath];
    NSLog(@"Dequeuing a cell");
//    if (cell == nil) {
//        cell = [[CLOSClosetCell alloc] init];
//    }
    
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:100];
    
    PFObject *closet = (PFObject *)self.myClosets[indexPath.row];
    titleLabel.text = closet[@"name"];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:50];
    [imageView setImage:[UIImage imageNamed:@"closetDoor.png"]];

    
    //TODO: set cell properties to current user
    
    return cell;
}

//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    //TODO: get the selected cell, and the closet name associated with teh selected cell
//    // then add the item object that is passed to that closet.
//    
//
//}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.myClosets count];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
