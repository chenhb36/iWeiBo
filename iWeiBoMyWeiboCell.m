//
//  iWeiBoMyWeiboCell.m
//  iWeiBo
//
//  Created by Alaysh on 11/17/13.
//  Copyright (c) 2013 Alaysh. All rights reserved.
//

#import "iWeiBoMyWeiboCell.h"
#import "WeiboModel.h"
#import "NSDate+RFC1123.h"

@implementation iWeiBoMyWeiboCell

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

- (void)configureForCell:(WeiboModel *)weibo
{
    
    self.contentLabel.text = weibo.text;
    NSString *dateStr = [weibo.createDate stringByReplacingOccurrencesOfString:@"+0800" withString:@""];
    self.contentLabel.scrollEnabled = YES;
    self.contentLabel.userInteractionEnabled = YES;
    self.contentLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.dateLabel.text = dateStr;
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

