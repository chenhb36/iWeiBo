//
//  iWeiBoWeiBoDetailViewController.m
//  iWeiBo
//
//  Created by Alaysh on 11/19/13.
//  Copyright (c) 2013 Alaysh. All rights reserved.
//

#import "iWeiBoWeiBoDetailViewController.h"
#import "UserModel.h"
#import "WeiboModel.h"

@interface iWeiBoWeiBoDetailViewController ()

@end

@implementation iWeiBoWeiBoDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    self.userName.text = self.weibo.user.name;
    self.description.text = self.weibo.user.description;
    self.location.text = self.weibo.user.location;
    self.followersCountsLabel.text = [NSString stringWithFormat:@"粉丝数:%@",self.weibo.user.followers_count];
    self.friendsCountsLabel.text = [NSString stringWithFormat:@"朋友数:%@",self.weibo.user.friends_count];
    self.statusCountsLabel.text = [NSString stringWithFormat:@"微博数:%@",self.weibo.user.statuses_count];
    self.weiBoView.text = self.weibo.text;
    if (self.weibo.relWeibo) {
        self.weiBoView.text = [NSString stringWithFormat:@"%@\n  @%@\n%@",self.weibo.text,self.weibo.relWeibo.user.name,self.weibo.relWeibo.text];
    }
    CALayer *layer = [self.image layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:6.0];
    //self.statusCountsLabel.text = [NSString stringWithFormat:@"微博数:%d",self.myWeiBoArray.count];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
