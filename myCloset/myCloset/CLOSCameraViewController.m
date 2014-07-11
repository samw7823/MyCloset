//
//  CLOSCameraViewController.m
//  myCloset
//
//  Created by Ruoxi Tan on 7/10/14.
//  Copyright (c) 2014 ___rpinsker___. All rights reserved.
//

#import "CLOSCameraViewController.h"
#import "CLOSCreateItemViewController.h"

@interface CLOSCameraViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end

@implementation CLOSCameraViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];

}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.allowsEditing = YES;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera || UIImagePickerControllerSourceTypePhotoLibrary;
    } else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    imagePicker.delegate = self;
    self.hidesBottomBarWhenPushed = YES;
    [self presentViewController:imagePicker animated:YES completion:NULL];

    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //Get picked image from info dictionary and create a new item
    UIImage *image = info[UIImagePickerControllerEditedImage];
    CLOSCreateItemViewController *createItemvc = [[CLOSCreateItemViewController alloc] init];
    createItemvc.image = image;
    [picker presentViewController:createItemvc animated:YES completion:NULL];

    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
