//
//  iWeiBoFriendsCell.h
//  iWeiBo
//
//  Created by Alaysh on 11/17/13.
//  Copyright (c) 2013 Alaysh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UserModel;
@class iWeiBoEngine;

@interface iWeiBoFriendsCell : UITableViewCell

@property (nonatomic,weak) IBOutlet UIImageView *friendImage;
@property (nonatomic,weak) IBOutlet UILabel *friendNameLabel;
@property (nonatomic,weak) IBOutlet UILabel *friendLocationLabel;
@property (nonatomic,weak) IBOutlet UILabel *friendDescriptionLabel;

- (void)configureForCell:(UserModel *)friend image:(UIImage *)anImage;

@end
