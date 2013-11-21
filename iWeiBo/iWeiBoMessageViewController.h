//
//  iWeiBoMessageViewController.h
//  iWeiBo
//
//  Created by Alaysh on 11/17/13.
//  Copyright (c) 2013 Alaysh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UserModel;
@class iWeiBoEngine;
@interface iWeiBoMessageViewController : UIViewController

@property (nonatomic,weak) IBOutlet UITableView *tableView;
@property (nonatomic,weak) IBOutlet UILabel *userName;
@property (nonatomic,weak) IBOutlet UILabel *description;
@property (nonatomic,weak) IBOutlet UILabel *location;
@property (nonatomic,weak) IBOutlet UILabel *followersCountsLabel;
@property (nonatomic,weak) IBOutlet UILabel *statusCountsLabel;
@property (nonatomic,weak) IBOutlet UILabel *friendsCountsLabel;
@property (nonatomic,weak) IBOutlet UIImageView *image;
/// 网络引擎
@property (nonatomic,strong) iWeiBoEngine *iweiBoEngine;
@property (nonatomic,strong) UserModel *user;
/**
 *  设置所要显示的用户
 *
 *  @param  aUser   用户模型
 *
 *  @since  1.0
 */
- (void)configureView:(UserModel *)aUser;

@end
