//
//  iWeiBoFriendsCell.m
//  iWeiBo
//
//  Created by Alaysh on 11/17/13.
//  Copyright (c) 2013 Alaysh. All rights reserved.
//

#import "iWeiBoFriendsCell.h"
#import "UserModel.h"
#import "iWeiBoEngine.h"
#import "iWeiBoAppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@implementation iWeiBoFriendsCell



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureForCell:(UserModel *)friend image:(UIImage *)anImage
{
    self.friendDescriptionLabel.text = friend.description;
    self.friendNameLabel.text = friend.name;
    self.friendLocationLabel.text = friend.location;
    self.friendImage.image = anImage;
    CALayer *layer = [self.friendImage layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:6.0];
    //NSLog(@"image:%@",anImage);
}

@end
