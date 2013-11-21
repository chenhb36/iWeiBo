//
//  iWeiBoFindUserModel.m
//  iWeiBo
//
//  Created by Alaysh on 11/17/13.
//  Copyright (c) 2013 Alaysh. All rights reserved.
//

#import "iWeiBoFindUserModel.h"

@implementation iWeiBoFindUserModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"screen_name"]) {
        self.name = value;
    }
    else if([key isEqualToString:@"followers_count"])
    {
        self.followersCount = value;
    }
    else if ([key isEqualToString:@"uid"])
        self.uid = value;
    else
    {
        //NSLog(@"Undefined key:%@",key);
    }
}

@end
