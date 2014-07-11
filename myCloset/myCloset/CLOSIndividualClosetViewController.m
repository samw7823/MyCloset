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
@property (strong, nonatomic) NSArray *items;

@end

@implementation CLOSIndividualClosetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //TODO: change this if not displaying current user's closet
        self.user = [PFUser currentUser];

        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSString *title = [NSString stringWithFormat:@"items in %@",self.closet[@"name"]];
    self.navigationItem.title = title;
    
    UINib *cellNib = [UINib nibWithNibName:@"CLOSClosetCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"ClosetCell"];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(150, 150)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    [self.collectionView setCollectionViewLayout:flowLayout];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem:)];
    self.navigationItem.rightBarButtonItem = addButton;

    
    /* creating a new item */
    PFObject *sampleItem = [[PFObject alloc] initWithClassName:@"Item"];
    sampleItem[@"name"] = @"Rachel's item ";
    
    PFRelation *itemToUser = [sampleItem relationForKey:@"owner"];
    [itemToUser addObject:[PFUser currentUser]];
    
    [sampleItem save];
    
    PFRelation *closetToItems = [self.closet relationForKey:@"items"];
    [closetToItems addObject:sampleItem];
    [self.closet save];
    /* end creating a new item */
    

}

- (void) viewWillAppear:(BOOL)animated
{
    //TODO: move this code to be run after a new item is created so that it is added to a certain closet
    PFRelation *relation = [self.closet relationForKey:@"items"]; //change to specific closet
    PFQuery *query = [relation query];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.items = objects;
        [self.collectionView reloadData];
    }];
    
    // end TODO
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
   // [titleLabel setText:@"ITEM"];
    PFObject *item = self.items[indexPath.row];
    
    NSString *itemName = item[@"name"];
    [titleLabel setText:itemName];
    
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
    return [self.items count];
}

@end
