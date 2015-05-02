//
// Created by il.ya sald.in on 5/2/15.
// Copyright (c) 2015 sald.in. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface InstagramAPI : NSObject

+ (NSString *)buildSearchUsersURLStringForUsername:(NSString *)searchString;

+ (NSString *)buildRecentImagesURLStringForUsernameWithId:(NSString *)usernameId;

@end