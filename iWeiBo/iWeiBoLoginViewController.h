//
//  iWeiBoLoginViewController.h
//  iWeiBo
//
//  Created by Alaysh on 11/16/13.
//  Copyright (c) 2013 Alaysh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class iWeiBoEngine;

@interface iWeiBoLoginViewController : UIViewController<UIWebViewDelegate,NSURLConnectionDataDelegate>
/// 网络引擎
@property(nonatomic,strong) iWeiBoEngine* iweiBoEngine;
/// 网络视图    实现用户登录
@property(nonatomic,strong) IBOutlet UIWebView *webView;

@end
