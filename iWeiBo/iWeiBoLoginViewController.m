//
//  iWeiBoLoginViewController.m
//  iWeiBo
//
//  Created by Alaysh on 11/16/13.
//  Copyright (c) 2013 Alaysh. All rights reserved.
//

#import "iWeiBoLoginViewController.h"
#import "iWeiBoEngine.h"
#import "iWeiBoAppDelegate.h"

@interface iWeiBoLoginViewController ()

@end

@implementation iWeiBoLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"Login");
    self.iweiBoEngine = [iWeiBoAppDelegate sharedDelegate].iweiBoEngine;
    //self.iweiBoEngine.accessToken = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    if (self.iweiBoEngine.accessToken == nil) {
        NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=3063462897&redirect_uri=https://api.weibo.com/oauth2/default.html&response_type=code&display=mobile"];
        NSURL *url = [NSURL URLWithString:urlStr];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        self.webView.delegate = self;
        [self.webView loadRequest:request];
    }
    else
        [self performSegueWithIdentifier:@"Show" sender:nil];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *url = webView.request.URL.absoluteString;
    url = [url stringByReplacingOccurrencesOfString:@"https://api.weibo.com/oauth2/default.html?" withString:@""];
    if ([[url substringToIndex:4] isEqualToString: @"code"]) {
        [self.iweiBoEngine loginWithCode:[url substringFromIndex:5] sender:self];
        if (self.iweiBoEngine.accessToken) {
            [self performSegueWithIdentifier:@"Show" sender:nil];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
