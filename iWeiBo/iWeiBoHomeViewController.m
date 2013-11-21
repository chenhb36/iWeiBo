//
//  iWeiBoHomeViewController.m
//  iWeiBo
//
//  Created by Alaysh on 11/16/13.
//  Copyright (c) 2013 Alaysh. All rights reserved.
//

#import "iWeiBoHomeViewController.h"
#import "iWeiBoAppDelegate.h"
#import "iWeiBoEngine.h"
#import "ArrayDataSource.h"
#import "WeiboModel.h"
#import "iWeiBoCell.h"
#import "iWeiBoWeiBoDetailViewController.h"

static NSString *weiboCellIdentifier = @"WeiBoCell";

@interface iWeiBoHomeViewController ()
@property (nonatomic,strong) iWeiBoWeiBoDetailViewController *weiBoDetailViewController;
@property (nonatomic,strong) NSArray *friendsWeiBos;
@property (nonatomic,strong) ArrayDataSource *friendsWeiBoDataSource;
@end

@implementation iWeiBoHomeViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)refresh
{
    NSLog(@"Refresh");
    self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"刷新中"];
    [self.iweiBoEngine getFriendsWeibo:^(NSArray *weiBoArray) {
        [self.refreshControl endRefreshing];
        self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
        self.friendsWeiBos = weiBoArray;
        [self setupTableView];
    } onError:^(NSError *engineError) {
        NSLog(@"refresh error");
        [self.refreshControl endRefreshing];
        [UIAlertView showWithError:engineError];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.tableView.contentOffset = CGPointMake(0, -self.refreshControl.frame.size.height);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"Home");
    [self addRefreshViewController];
    self.iweiBoEngine = [iWeiBoAppDelegate sharedDelegate].iweiBoEngine;
    [self.iweiBoEngine getFriendsWeibo:^(NSArray *weiBoArray) {
        self.friendsWeiBos = weiBoArray;
        [self setupTableView];
    } onError:^(NSError *engineError) {
        [UIAlertView showWithError:engineError];
    }];
}

- (void)addRefreshViewController
{
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupTableView
{
    TableViewConfigureBlock configureCell = ^(iWeiBoCell *cell,WeiboModel *weibo)
    {
        [self.iweiBoEngine imageAtURL:[NSURL URLWithString:weibo.user.profile_image_url] completionHandler:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
            [cell configureForCell:weibo image:fetchedImage];
        } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
            NSLog(@"fetch image error");
        }];
        
    };
    self.friendsWeiBoDataSource = [[ArrayDataSource alloc] initWithItems:self.friendsWeiBos cellIndetifier:weiboCellIdentifier configureCellBlock:configureCell];
    self.tableView.dataSource = self.friendsWeiBoDataSource;
    //self.tableView.delegate = (id)self.friendsWeiBoDataSource;
    [self.tableView reloadData];
}
#pragma mark - Table view data source
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)logout:(id)sender
{
    [self.iweiBoEngine logout];
    self.iweiBoEngine.accessToken = nil;
    [self.tabBarController performSegueWithIdentifier:@"logout" sender:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.weiBoDetailViewController == nil) {
        self.weiBoDetailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"iWeiBoWeiBoDetailViewController"];
    }
    WeiboModel *weiBo = [self.friendsWeiBos objectAtIndex:indexPath.row];
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
