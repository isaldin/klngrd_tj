//
//  UserNameCell.m
//  klngrd_tj
//
//  Created by il.ya sald.in on 5/2/15.
//  Copyright (c) 2015 sald.in. All rights reserved.
//

#import "UserNameCell.h"

@implementation UserNameCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configWithUserRecord:(NSDictionary *)userRecord
{
    self.lblFullname.text = userRecord[@"full_name"];
    self.lblUsername.text = userRecord[@"username"];
    self.lblId.text = userRecord[@"id"];

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSData *avatarData = [NSData dataWithContentsOfURL:[NSURL URLWithString:userRecord[@"avatar"]]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.imgViewUserAvatar setImage:[UIImage imageWithData:avatarData]];
        });
    });
}

@end
