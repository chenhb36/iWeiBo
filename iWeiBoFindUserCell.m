//
//  iWeiBoFindUserCell.m
//  iWeiBo
//
//  Created by Alaysh on 11/17/13.
//  Copyright (c) 2013 Alaysh. All rights reserved.
//

#import "iWeiBoFindUserCell.h"
#import "iWeiBoFindUserModel.h"
#import "iWeiBoEngine.h"
#import "iWeiBoAppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "UserModel.h"

@implementation iWeiBoFindUserCell

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

- (void)configureForCell:(UserModel *)aUser image:(UIImage *)anImage
{
    //NSLog(@"User:%@",aUser);
    self.userDescriptionLabel.text = aUser.description;
    self.userNameLabel.text = aUser.screen_name;
    self.userLocationLabel.text = aUser.location;
    self.userImage.image = anImage;
    CALayer *layer = [self.userImage layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:6.0];
    //NSLog(@"image:%@",anImage);
}

@end
