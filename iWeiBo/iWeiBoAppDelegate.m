//
//  iWeiBoAppDelegate.m
//  iWeiBo
//
//  Created by Alaysh on 11/16/13.
//  Copyright (c) 2013 Alaysh. All rights reserved.
//

#import "iWeiBoAppDelegate.h"
#import "iWeiBoEngine.h"

@implementation iWeiBoAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    NSString *accessToken = [accountDefaults objectForKey:@"accessToken"];
    NSString *uid = [accountDefaults objectForKey:@"uid"];
    self.iweiBoEngine = [[iWeiBoEngine alloc] initWithAccessToken:accessToken];
    [self.iweiBoEngine setUid:uid];
    return YES;
}

+ (instancetype)sharedDelegate
{
    return (iWeiBoAppDelegate*)[UIApplication sharedApplication].delegate;
}

@end
