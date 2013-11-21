//
//  iWeiBoMessageViewController.m
//  iWeiBo
//
//  Created by Alaysh on 11/17/13.
//  Copyright (c) 2013 Alaysh. All rights reserved.
//

#import "iWeiBoMessageViewController.h"
#import "iWeiBoAppDelegate.h"
#import "iWeiBoEngine.h"
#import "UserModel.h"
#import "WeiboModel.h"
#import "ArrayDataSource.h"
#import "iWeiBoMyWeiboCell.h"
#import <QuartzCore/QuartzCore.h>
#import "iWeiBoWeiBoDetailViewController.h"

static NSString *weiboCellIdentifier = @"WeiBoMyWeiBoCell";
@interface iWeiBoMessageViewController ()
@property (nonatomic,strong) iWeiBoWeiBoDetailViewController *weiBoDetailViewController;
@property (nonatomic,strong) NSArray *myWeiBoArray;
@property (nonatomic,strong) ArrayDataSource *myWeiBoDataSource;
@end

@implementation iWeiBoMessageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setupTableView
{
    TableViewConfigureBlock configureCell = ^(iWeiBoMyWeiboCell *cell,WeiboModel *weibo)
    {
        [cell configureForCell:weibo];
    };
    self.myWeiBoDataSource = [[ArrayDataSource alloc] initWithItems:self.myWeiBoArray cellIndetifier:weiboCellIdentifier configureCellBlock:configureCell];
    self.tableView.dataSource = self.myWeiBoDataSource;
    self.tableView.delegate = (id)self;
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.userName.text = self.user.name;
    self.description.text = self.user.description;
    self.location.text = self.user.location;
    [self.iweiBoEngine imageAtURL:[NSURL URLWithString:self.user.profile_image_url] completionHandler:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
        self.image.image = fetchedImage;
        CALayer *layer = [self.image layer];
        [layer setMasksToBounds:YES];
        [layer setCornerRadius:6.0];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [UIAlertView showWithError:error];
    }];
    self.followersCountsLabel.text = [NSString stringWithFormat:@"粉丝数:%@",self.user.followers_count];
    self.friendsCountsLabel.text = [NSString stringWithFormat:@"朋友数:%@",self.user.friends_count];
    self.statusCountsLabel.text = [NSString stringWithFormat:@"微博数:%@",self.user.statuses_count];
}
- (void)configureView:(UserModel *)aUser
{
    self.user = aUser;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"Message");
    self.iweiBoEngine = [iWeiBoAppDelegate sharedDelegate].iweiBoEngine;
    if (self.user==nil) {
        [self.iweiBoEngine getAccountMessage:^(UserModel *aUser) {
            //[self configureView:aUser];
            self.user = aUser;
            //NSLog(@"self.user:%@",self.user);
            self.userName.text = self.user.name;
            self.description.text = self.user.description;
            self.location.text = self.user.location;
            [self.iweiBoEngine imageAtURL:[NSURL URLWithString:self.user.profile_image_url] completionHandler:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
                self.image.image = fetchedImage;
                CALayer *layer = [self.image layer];
                [layer setMasksToBounds:YES];
                [layer setCornerRadius:6.0];
            } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
                [UIAlertView showWithError:error];
            }];
            self.followersCountsLabel.text = [NSString stringWithFormat:@"粉丝数:%@",self.user.followers_count];
            self.friendsCountsLabel.text = [NSString stringWithFormat:@"朋友数:%@",self.user.friends_count];
            
            
        } onError:^(NSError *engineError) {
            [UIAlertView showWithError:engineError];
        }];
    }
    
    [self.iweiBoEngine getMyWeibo:^(NSArray *weiBoArray) {
        self.myWeiBoArray = weiBoArray;
        self.statusCountsLabel.text = [NSString stringWithFormat:@"微博数:%d",self.myWeiBoArray.count];
        [self setupTableView];
    } onError:^(NSError *engineError) {
        NSLog(@"Get WeiBo error");
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.weiBoDetailViewController == nil) {
        self.weiBoDetailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"iWeiBoWeiBoDetailViewController"];
    }
    WeiboModel *weiBo = [self.myWeiBoArray objectAtIndex:indexPath.row];
    [self.iweiBoEngine imageAtURL:[NSURL URLWithString:weiBo.user.profile_image_url] completionHandler:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
        self.weiBoDetailViewController.image.image = fetchedImage;
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"fetch image error");
    }];
    if (weiBo.relWeibo.thumbnailImage) {
        [self.iweiBoEngine imageAtURL:[NSURL URLWithString:weiBo.relWeibo.thumbnailImage] completionHandler:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
            self.weiBoDetailViewController.relWeiBoimage.image = fetchedImage;
        } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
            NSLog(@"fetch image error");
        }];
    }
    else
        self.weiBoDetailViewController.relWeiBoimage.image = nil;
    
    [self.weiBoDetailViewController setWeibo:weiBo];
    [self.navigationController pushViewController:self.weiBoDetailViewController animated:YES];
}
@end
