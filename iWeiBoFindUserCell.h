//
//  iWeiBoFindUserCell.h
//  iWeiBo
//
//  Created by Alaysh on 11/17/13.
//  Copyright (c) 2013 Alaysh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class iWeiBoFindUserModel;
@class iWeiBoEngine;
@class UserModel;
@interface iWeiBoFindUserCell : UITableViewCell

@property (nonatomic,weak) IBOutlet UIImageView *userImage;
@property (nonatomic,weak) IBOutlet UILabel *userNameLabel;
@property (nonatomic,weak) IBOutlet UILabel *userLocationLabel;
@property (nonatomic,weak) IBOutlet UILabel *userDescriptionLabel;

- (void)configureForCell:(UserModel *)aUser image:(UIImage *)anImage;

@end
