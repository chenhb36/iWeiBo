//
//  iWeiBoMyWeiboCell.h
//  iWeiBo
//
//  Created by Alaysh on 11/17/13.
//  Copyright (c) 2013 Alaysh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WeiboModel;
@interface iWeiBoMyWeiboCell : UITableViewCell

@property (nonatomic,weak) IBOutlet UITextView *contentLabel;
@property (nonatomic,weak) IBOutlet UILabel *dateLabel;

- (void)configureForCell:(WeiboModel *)weibo;

@end
