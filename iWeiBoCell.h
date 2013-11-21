//
//  iWeiBoCell.h
//  iWeiBo
//
//  Created by Alaysh on 11/17/13.
//  Copyright (c) 2013 Alaysh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WeiboModel;
@interface iWeiBoCell : UITableViewCell

@property (nonatomic,weak) IBOutlet UILabel *userLabel;
@property (nonatomic,weak) IBOutlet UILabel *contentLabel;
@property (nonatomic,weak) IBOutlet UILabel *dateLabel;
@property (nonatomic,weak) IBOutlet UILabel *repostsCountLabel;
@property (nonatomic,weak) IBOutlet UILabel *commentCountLabel;
@property (nonatomic,weak) IBOutlet UIImageView *userImage;
- (void)configureForCell:(WeiboModel *)weibo image:(UIImage*)anImage;

@end
