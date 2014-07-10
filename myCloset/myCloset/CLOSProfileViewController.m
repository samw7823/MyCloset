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

@interface CLOSProfileViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) PFUser *user;

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
    
    [self.collectionView registerClass:[CLOSClosetCell class] forCellWithReuseIdentifier:@"ClosetCell"];
    
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"ClosetCell" forIndexPath:indexPath];
    
    // set cell properties to current user
    
    return cell;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
    // return [self.user[@"Closets] count];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
