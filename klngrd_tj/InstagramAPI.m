//
// Created by il.ya sald.in on 5/2/15.
// Copyright (c) 2015 sald.in. All rights reserved.
//

#import "InstagramAPI.h"

static NSString *clientID = @"b9e8581bbbab4c7db875b9deb5d32a38";

@implementation InstagramAPI

+ (NSString *)buildSearchUsersURLStringForUsername:(NSString *)searchString
{
    return [NSString stringWithFormat:@"https://api.instagram.com/v1/users/search?q=%@&client_id=%@", searchString, clientID];
}

+ (NSString *)buildRecentImagesURLStringForUsernameWithId:(NSString *)usernameId
{
    return [NSString stringWithFormat:@"https://api.instagram.com/v1/users/%@/media/recent/?client_id=%@", usernameId, clientID];
}

@end