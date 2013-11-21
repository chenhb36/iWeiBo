//
//  iWeiBoAppDelegate.h
//  iWeiBo
//
//  Created by Alaysh on 11/16/13.
//  Copyright (c) 2013 Alaysh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class iWeiBoEngine;

@interface iWeiBoAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) iWeiBoEngine *iweiBoEngine;

+ (instancetype)sharedDelegate;

@end
