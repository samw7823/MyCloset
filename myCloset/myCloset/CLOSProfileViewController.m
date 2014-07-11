//
//  CLOSProfileViewController.m
//  myCloset
//
//  Created by Ruoxi Tan on 7/10/14.
//  Copyright (c) 2014 ___rpinsker___. All rights reserved.
//

#import "CLOSProfileViewController.h"
#import <Parse/Parse.h>
#import "CLOSClosetCell.h"
#import "CLOSCreateClosetViewController.h"
#import "CLOSIndividualClosetViewController.h"

@interface CLOSProfileViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) PFUser *user;
@property (strong, nonatomic) NSArray *myClosets;

@end

@implementation CLOSProfileViewController

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
    
    self.user = [PFUser currentUser];
    NSString *username = [NSString stringWithFormat:@"%@'s closets",self.user.username];
    self.navigationItem.title = username;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCloset:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    UINib *cellNib = [UINib nibWithNibName:@"CLOSClosetCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"ClosetCell"];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(150, 150)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    [self.collectionView setCollectionViewLayout:flowLayout];
    

    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //TODO: figure out ordering of closets
    PFQuery *closetsQuery = [PFQuery queryWithClassName:@"Closet"];
    [closetsQuery whereKey:@"owner" equalTo:self.user];
    [closetsQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.myClosets = objects;
        [self.collectionView reloadData];
    }];

    
    [self.collectionView reloadData];
    [self.user saveInBackground];
}

- (IBAction)addCloset:(id)sender
{
    CLOSCreateClosetViewController *createClosetvc = [[CLOSCreateClosetViewController alloc] init];
    [self presentViewController:createClosetvc animated:YES completion:NULL];
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"ClosetCell" forIndexPath:indexPath];
    
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:100];
    
    PFObject *closet = self.myClosets[indexPath.row];
    
    NSString *closetName = closet[@"name"];
    [titleLabel setText:closetName];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:50];
    [imageView setImage:[UIImage imageNamed:@"closetDoor.png"]];
    
    
    //TODO: set cell properties to current user
    
    return cell;
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PFObject *closet = self.myClosets[indexPath.row];
    CLOSIndividualClosetViewController *individualvc = [[CLOSIndividualClosetViewController alloc] init];
    individualvc.closet = closet;
    [self.navigationController pushViewController:individualvc animated:YES];
}

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
