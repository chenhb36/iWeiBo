//
//  iWeiBoWeiBoDetailViewController.h
//  iWeiBo
//
//  Created by Alaysh on 11/19/13.
//  Copyright (c) 2013 Alaysh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UserModel;
@class WeiboModel;
@interface iWeiBoWeiBoDetailViewController : UIViewController

@property (nonatomic,weak) IBOutlet UILabel *userName;
@property (nonatomic,weak) IBOutlet UILabel *description;
@property (nonatomic,weak) IBOutlet UILabel *location;
@property (nonatomic,weak) IBOutlet UILabel *followersCountsLabel;
@property (nonatomic,weak) IBOutlet UILabel *statusCountsLabel;
@property (nonatomic,weak) IBOutlet UILabel *friendsCountsLabel;
@property (nonatomic,strong) IBOutlet UIImageView *image;
@property (nonatomic,weak) IBOutlet UITextView *weiBoView;
@property (nonatomic,weak) IBOutlet UIImageView *relWeiBoimage;

@property (nonatomic,strong) WeiboModel *weibo;
@end
