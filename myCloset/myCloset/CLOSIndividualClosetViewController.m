//
//  CLOSIndividualClosetViewController.m
//  myCloset
//
//  Created by Ruoxi Tan on 7/10/14.
//  Copyright (c) 2014 ___rpinsker___. All rights reserved.
//

#import "CLOSIndividualClosetViewController.h"
#import <Parse/Parse.h>

@interface CLOSIndividualClosetViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@end

@implementation CLOSIndividualClosetViewController

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
    NSString *title = [NSString stringWithFormat:@"items in %@",self.closet[@"name"]];
    self.navigationItem.title = title;
    
   // UIBarButtonItem
   // self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] init];
   // self.navigationItem.rightBarButtonItem
    
    UINib *cellNib = [UINib nibWithNibName:@"CLOSClosetCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"ClosetCell"];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(150, 150)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    [self.collectionView setCollectionViewLayout:flowLayout];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"ClosetCell" forIndexPath:indexPath];
    
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:100];
    [titleLabel setText:@"ITEM"];
/*    NSArray *items = self.closet[@"itemsInCloset"];
    PFObject *item = items[indexPath.row];
    
    NSString *itemName = item[@"name"];
    [titleLabel setText:itemName]; */
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:50];
  //  [imageView setImage:[UIImage imageNamed:@"closetDoor.png"]];
    
    
    //TODO: set cell properties to current user
    
    return cell;
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    PFObject *closet = self.myClosets[indexPath.row];
//    CLOSIndividualClosetViewController *individualvc = [[CLOSIndividualClosetViewController alloc] init];
//    individualvc.closet = closet;
//    [self.navigationController pushViewController:individualvc animated:YES];
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //return [self.closet[@"itemsInCloset"] count];
    return 10;
}

@end
