//
//  iWeiBoFindUserViewController.m
//  iWeiBo
//
//  Created by Alaysh on 11/18/13.
//  Copyright (c) 2013 Alaysh. All rights reserved.
//

#import "iWeiBoFindUserViewController.h"
#import "iWeiBoAppDelegate.h"
#import "iWeiBoEngine.h"
#import "ArrayDataSource.h"
#import "iWeiBoFindUserCell.h"
#import "iWeiBoFindUserModel.h"
#import "UserModel.h"
#import "iWeiBoWeiBoDetailViewController.h"
#import "WeiboModel.h"

static NSString *UsersCellIdentifier = @"UsersCell";

@interface iWeiBoFindUserViewController ()
@property (nonatomic,strong) iWeiBoWeiBoDetailViewController *weiBoDetailViewController;
@property(nonatomic,strong) ArrayDataSource *usersDataSource;
@property(nonatomic,strong) NSArray *usersArray;
@end

@implementation iWeiBoFindUserViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"Find :%@",searchBar.text);
    [self.searchBar resignFirstResponder];// 放弃第一响应者
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.iweiBoEngine findUsers:searchBar.text onSuccess:^(NSArray *weiBoArray) {
        self.usersArray = weiBoArray;
        [self setupTableView];
    } onError:^(NSError *engineError) {
        [UIAlertView showWithError:engineError];
    }];
    
}

- (void)setupTableView
{
    TableViewConfigureBlock configureCell = ^(iWeiBoFindUserCell *cell,iWeiBoFindUserModel *user)
    {
        [self.iweiBoEngine findUser:user.uid onSuccess:^(UserModel *aUser) {
            //NSLog(@"aUser.profile_image_url:%@",aUser.profile_image_url);
            [self.iweiBoEngine imageAtURL:[NSURL URLWithString:aUser.profile_image_url] completionHandler:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
                [cell configureForCell:aUser image:fetchedImage];
            } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
                NSLog(@"fetch image error");
            }];
            [cell configureForCell:aUser image:nil];
        } onError:^(NSError *engineError) {
            
        }];
    };
    self.usersDataSource = [[ArrayDataSource alloc] initWithItems:self.usersArray cellIndetifier:UsersCellIdentifier configureCellBlock:configureCell];
    self.tableView.dataSource = self.usersDataSource;
    self.tableView.delegate = (id)self;
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"FindUser");
    self.iweiBoEngine = [iWeiBoAppDelegate sharedDelegate].iweiBoEngine;
    
	// Do any additional setup after loading the view.
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
    iWeiBoFindUserModel *findUser = [self.usersArray objectAtIndex:indexPath.row];
    [self.iweiBoEngine findUser:findUser.uid onSuccess:^(UserModel *aUser) {
        WeiboModel *weiBo = aUser.status;
        weiBo.user = aUser;
        
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
        
    } onError:^(NSError *engineError) {
        NSLog(@"Show User error");
    }];
    
}
@end
