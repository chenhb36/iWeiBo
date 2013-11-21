//
//  iWeiBoHomeViewController.h
//  iWeiBo
//
//  Created by Alaysh on 11/16/13.
//  Copyright (c) 2013 Alaysh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class iWeiBoEngine;

@interface iWeiBoHomeViewController : UITableViewController
/// 网络引擎
@property(nonatomic, strong) iWeiBoEngine *iweiBoEngine;
/**
 *  刷新最新好友微博
 *
 *  @since  1.0
 */
- (void)refresh;
/*
 *  退出当前账号
 *
 *  @since  1.0
 */
- (IBAction)logout:(id)sender;

@end
