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
@property (nonatomic, getter=isSelected) BOOL selected;



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
    CLOSCreateClosetViewController *createClosetvc = [[CLOSCreateClosetViewController alloc] init];
    [self presentViewController:createClosetvc animated:YES completion:NULL];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    
    
    
    self.user = [PFUser currentUser];
    NSString *username = [NSString stringWithFormat:@"%@'s closets",self.user.username];
    self.navBar.topItem.title = username;
    
    
    UINib *cellNib = [UINib nibWithNibName:@"CLOSClosetCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"ClosetCell"];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(150, 150)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    [self.collectionView setCollectionViewLayout:flowLayout];

    
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"ClosetCell" forIndexPath:indexPath];
    
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:100];
    
    [titleLabel setText:@"closet"];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:50];
    [imageView setImage:[UIImage imageNamed:@"closetDoor.png"]];
    
    //TODO: get the selected cell, and the closet name associated with teh selected cell
    // then 
    
    
    //TODO: set cell properties to current user
    
    return cell;
}


- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.user[@"ownedClosets"] count];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
