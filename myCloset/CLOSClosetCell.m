//
//  CLOSClosetCell.m
//  myCloset
//
//  Created by Samantha Wiener on 7/10/14.
//  Copyright (c) 2014 ___rpinsker___. All rights reserved.
//

#import "CLOSClosetCell.h"

@interface CLOSClosetCell ()

//@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation CLOSClosetCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"cell created");
        
      //  self.label.text = @"CELL";
      //  self.imageView.image = [[UIImage alloc] initWithContentsOfFile:@"closetDoor.png"];
    }
    return self;
}



//// Only override drawRect: if you perform custom drawing.
//// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect
//{
//    
//}


@end
