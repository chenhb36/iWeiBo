//
//  iWeiBoCell.m
//  iWeiBo
//
//  Created by Alaysh on 11/17/13.
//  Copyright (c) 2013 Alaysh. All rights reserved.
//

#import "iWeiBoCell.h"
#import "WeiboModel.h"
#import "NSDate+RFC1123.h"
#import <QuartzCore/QuartzCore.h>
@implementation iWeiBoCell

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

- (void)configureForCell:(WeiboModel *)weibo image:(UIImage*)anImage;
{
    self.userLabel.text = weibo.user.name;
    self.contentLabel.text = weibo.text;
    NSString *dateStr = [weibo.createDate stringByReplacingOccurrencesOfString:@"+0800" withString:@""];
    self.dateLabel.text = dateStr;
    self.repostsCountLabel.text = [NSString stringWithFormat:@"转发数:%@",weibo.repostsCount];
    self.commentCountLabel.text = [NSString stringWithFormat:@"评论数:%@",weibo.commentsCount];
    self.userImage.image = anImage;
    CALayer *layer = [self.userImage layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:6.0];
}

- (NSDateFormatter*)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter)
    {
        dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.timeStyle = NSDateFormatterMediumStyle;
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    }
    return dateFormatter;
}

@end
