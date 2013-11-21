//
//  iWeiBoEngine.m
//  iWeiBo
//
//  Created by Alaysh on 11/16/13.
//  Copyright (c) 2013 Alaysh. All rights reserved.
//

#import "iWeiBoEngine.h"
#import "MKNetworkEngine.h"
#import "WeiboModel.h"
#import "UserModel.h"
#include "iWeiBoFriendModel.h"
#include "iWeiBoFindUserModel.h"

#define kAppKey @"3063462897"
#define kAppSecret @"42c6bc9616575e58d70e4f31a80833ca"
#define kRedirectUrl @"https://api.weibo.com/oauth2/default.html"
#define kHostUrl @"api.weibo.com"
#define QAuthURL @"oauth2/authorize"
#define access_tokenURL @"oauth2/access_token"
#define friends_timelineURL @"2/statuses/friends_timeline.json"
#define user_timelineURL @"2/statuses/user_timeline.json"
#define showURL @"2/users/show.json"
#define revokeoauth2URL @"oauth2/revokeoauth2"
#define friendsURL @"2/friendships/friends.json"
#define suggestion_usersURL @"2/search/suggestions/users.json"

@implementation iWeiBoEngine

- (id)initWithAccessToken:(NSString*)anAccessToken
{
    self = [super initWithHostName:kHostUrl customHeaderFields:nil];
    [self setAccessToken:anAccessToken];
    self.paramDic = [[NSMutableDictionary alloc] init];
    [self.paramDic setObject:self.accessToken forKey:@"access_token"];
    return self;
}

- (id)loginWithCode:(NSString*)aCode sender:(id)aSendeer
{
    NSLog(@"Login");
    NSMutableDictionary *loginDic = [[NSMutableDictionary alloc] init];
    [loginDic setObject:kAppKey forKey:@"client_id"];
    [loginDic setObject:kAppSecret forKey:@"client_secret"];
    [loginDic setObject:@"authorization_code" forKey:@"grant_type"];
    [loginDic setObject:aCode forKey:@"code"];
    [loginDic setObject:kRedirectUrl forKey:@"redirect_uri"];
    MKNetworkOperation *op = (MKNetworkOperation*)[self operationWithPath:access_tokenURL params:loginDic httpMethod:@"POST" ssl:YES];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSDictionary *responseDic = [completedOperation responseJSON];
        NSLog(@"response token :%@",[responseDic objectForKey:@"access_token"]);
        self.uid = [responseDic objectForKey:@"uid"];
        self.accessToken = [responseDic objectForKey:@"access_token"];
        [self.paramDic setObject:self.accessToken forKey:@"access_token"];
        NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
        [accountDefaults setObject:self.accessToken forKey:@"accessToken"];
        [accountDefaults setObject:self.uid forKey:@"uid"];
        [accountDefaults synchronize];
        [aSendeer performSegueWithIdentifier:@"Show" sender:nil];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [UIAlertView showWithError:error];
    }];
    [self enqueueOperation:op];
    return nil;
}

- (void)logout
{
    MKNetworkOperation *op = (MKNetworkOperation*)[self operationWithPath:revokeoauth2URL params:self.paramDic httpMethod:@"POST" ssl:YES];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        [UIAlertView showWithMessage:@"退出帐号成功"];
        self.accessToken = nil;
        self.uid = nil;
        NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
        [accountDefaults setObject:self.accessToken forKey:@"accessToken"];
        [accountDefaults setObject:self forKey:@"uid"];
        [accountDefaults synchronize];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [UIAlertView showWithMessage:@"退出帐号失败"];
    }];
}

- (void)getFriendsWeibo:(SuccessBlock)successBlock onError:(ErrorBlock)errorBlock
{
    MKNetworkOperation *op = (MKNetworkOperation*)[self operationWithPath:friends_timelineURL params:self.paramDic httpMethod:@"GET" ssl:YES];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSMutableDictionary *responseDic = [completedOperation responseJSON];
        NSMutableArray *weiBoArrayJson = [responseDic objectForKey:@"statuses"];
        NSMutableArray *weiBoArray = [[NSMutableArray alloc] init];
        [weiBoArrayJson enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            WeiboModel *weiBo = [[WeiboModel alloc] init];
            [weiBo setAttributes:obj];
            [weiBoArray addObject:weiBo];
        }];
        successBlock(weiBoArray);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        errorBlock(error);
    }];
    [self enqueueOperation:op];
    
}

- (void)getMyWeibo:(SuccessBlock)successBlock onError:(ErrorBlock)errorBlock
{
    [self.paramDic setObject:self.uid forKey:@"uid"];
    MKNetworkOperation *op = (MKNetworkOperation*)[self operationWithPath:user_timelineURL params:self.paramDic httpMethod:@"GET" ssl:YES];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSMutableDictionary *responseDic = [completedOperation responseJSON];
        NSMutableArray *weiBoArrayJson = [responseDic objectForKey:@"statuses"];
        NSMutableArray *weiBoArray = [[NSMutableArray alloc] init];
        [weiBoArrayJson enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            WeiboModel *weiBo = [[WeiboModel alloc] init];
            [weiBo setAttributes:obj];
            [weiBoArray addObject:weiBo];
        }];
        [self.paramDic removeObjectForKey:@"uid"];
        successBlock(weiBoArray);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        errorBlock(error);
    }];
    [self enqueueOperation:op];
}

- (void)getAccountMessage:(SuccessBlockAccount)successBlock onError:(ErrorBlock)errorBlock
{
    [self.paramDic setObject:self.uid forKey:@"uid"];
    MKNetworkOperation *op = (MKNetworkOperation*)[self operationWithPath:showURL params:self.paramDic httpMethod:@"GET" ssl:YES];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSMutableArray *userArray = [[NSMutableArray alloc] init];
        UserModel *aUser = [completedOperation responseJSON];
        NSMutableArray *dic = [NSMutableArray arrayWithObject:aUser];
        [dic enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UserModel *user = [[UserModel alloc] init];
            [user setValuesForKeysWithDictionary:obj];
            [userArray addObject:user];
        }];
        NSLog(@"My description: %@",[userArray objectAtIndex:0]);
        [self.paramDic removeObjectForKey:@"uid"];
        successBlock([userArray objectAtIndex:0]);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
            errorBlock(error);
    }];
    [self enqueueOperation:op];
}

- (void)getFriends:(SuccessBlock)successBlock onError:(ErrorBlock)errorBlock
{
    [self.paramDic setObject:self.uid forKey:@"uid"];
    [self.paramDic setObject:@"0" forKey:@"trim_status"];
    MKNetworkOperation *op = (MKNetworkOperation*)[self operationWithPath:friendsURL params:self.paramDic httpMethod:@"GET" ssl:YES];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSMutableDictionary *dic = [completedOperation responseJSON];
        NSMutableArray *friendsArray = [dic objectForKey:@"users"];
        NSMutableArray *friendArray = [[NSMutableArray alloc] init];
        
        [friendsArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UserModel *friend = [[UserModel alloc] init];
            [friend setValuesForKeysWithDictionary:obj];
            [friendArray addObject:friend];
        }];
        [self.paramDic removeObjectForKey:@"uid"];
        [self.paramDic removeObjectForKey:@"trim_status"];
        successBlock(friendArray);

    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        errorBlock(error);
    }];
    [self enqueueOperation:op];

}

- (void)findUsers:(NSString*)key onSuccess:(SuccessBlock)successBlock onError:(ErrorBlock)errorBlock
{
    [self.paramDic setObject:key forKey:@"q"];
    MKNetworkOperation *op = (MKNetworkOperation*)[self operationWithPath:suggestion_usersURL params:self.paramDic httpMethod:@"GET" ssl:YES];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSMutableDictionary *dic = [completedOperation responseJSON];
        NSMutableArray *userArray = [[NSMutableArray alloc] init];
        for (iWeiBoFriendModel*user in dic) {
            [userArray addObject:user];
        }
        NSMutableArray *users = [[NSMutableArray alloc] init];
        [userArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            iWeiBoFindUserModel *user = [[iWeiBoFindUserModel alloc] init];
            [user setValuesForKeysWithDictionary:obj];
            [users addObject:user];
        }];
        [self.paramDic removeObjectForKey:@"q"];
        successBlock(users);
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        errorBlock(error);
    }];
    [self enqueueOperation:op];
    
}

- (void)findUser:(NSString*)uid onSuccess:(SuccessBlockAccount)successBlock onError:(ErrorBlock)errorBlock
{
    [self.paramDic setObject:uid forKey:@"uid"];
    MKNetworkOperation *op = (MKNetworkOperation*)[self operationWithPath:showURL params:self.paramDic httpMethod:@"GET" ssl:YES];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSMutableArray *userArray = [[NSMutableArray alloc] init];
        UserModel *aUser = [completedOperation responseJSON];
        NSMutableArray *dic = [NSMutableArray arrayWithObject:aUser];
        [dic enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UserModel *user = [[UserModel alloc] init];
            [user setValuesForKeysWithDictionary:obj];
            [userArray addObject:user];
        }];
        [self.paramDic removeObjectForKey:@"uid"];
        successBlock([userArray objectAtIndex:0]);
    
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        errorBlock(error);
    }];
    [self enqueueOperation:op];
}

@end
