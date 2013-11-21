//
//  iWeiBoFriendsViewController.m
//  iWeiBo
//
//  Created by Alaysh on 11/17/13.
//  Copyright (c) 2013 Alaysh. All rights reserved.
//

#import "iWeiBoFriendsViewController.h"
#import "iWeiBoEngine.h"
#import "iWeiBoAppDelegate.h"
#import "ArrayDataSource.h"
#import "UserModel.h"
#import "iWeiBoFriendsCell.h"
#import "iWeiBoMessageViewController.h"
#import "iWeiBoWeiBoDetailViewController.h"
#import "WeiboModel.h"

static NSString* friendCellIdentifier = @"FriendCell";

@interface iWeiBoFriendsViewController ()
@property (nonatomic,strong) iWeiBoWeiBoDetailViewController *weiBoDetailViewController;
@property(nonatomic,strong) ArrayDataSource *friendsDataSource;
@property(nonatomic,strong) NSArray *friendsArray;
@end

@implementation iWeiBoFriendsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"Friends");
    self.iweiBoEngine = [iWeiBoAppDelegate sharedDelegate].iweiBoEngine;
    [self.iweiBoEngine getFriends:^(NSArray *weiBoArray) {
        self.friendsArray = weiBoArray;
        [self setupTableView];
    } onError:^(NSError *engineError) {
        [UIAlertView showWithError:engineError];
    }];
}

- (void)setupTableView
{
    TableViewConfigureBlock configureCell = ^(iWeiBoFriendsCell *cell,UserModel *friend)
    {
        [self.iweiBoEngine imageAtURL:[NSURL URLWithString:friend.profile_image_url] completionHandler:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
            [cell configureForCell:friend image:fetchedImage];
        } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
            NSLog(@"fetch image error");
        }];
    };
    [self.iweiBoEngine useCache];
    self.friendsDataSource = [[ArrayDataSource alloc] initWithItems:self.friendsArray cellIndetifier:friendCellIdentifier configureCellBlock:configureCell];
    self.tableView.dataSource = self.friendsDataSource;
    self.tableView.delegate = (id)self;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.weiBoDetailViewController == nil) {
        self.weiBoDetailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"iWeiBoWeiBoDetailViewController"];
    }
    UserModel *user = [self.friendsArray objectAtIndex:indexPath.row];
    WeiboModel *weiBo = user.status;
    weiBo.user = user;
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
