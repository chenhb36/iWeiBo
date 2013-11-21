//
//  iWeiBoFriendModel.m
//  iWeiBo
//
//  Created by Alaysh on 11/17/13.
//  Copyright (c) 2013 Alaysh. All rights reserved.
//

#import "iWeiBoFriendModel.h"

@implementation iWeiBoFriendModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"screen_name"]) {
        self.name = value;
    }
    else if([key isEqualToString:@"location"])
    {
        self.location = value;
    }
    else if ([key isEqualToString:@"description"])
        self.description = value;
    else if([key isEqualToString:@"profile_image_url"])
        self.imageUrl = value;
    else
    {
        //NSLog(@"Undefined key:%@",key);
    }
}
@end
