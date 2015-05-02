//
//  UserNameCell.h
//  klngrd_tj
//
//  Created by il.ya sald.in on 5/2/15.
//  Copyright (c) 2015 sald.in. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserNameCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *imgViewUserAvatar;
@property (nonatomic, weak) IBOutlet UILabel *lblUsername;
@property (nonatomic, weak) IBOutlet UILabel *lblFullname;
@property (nonatomic, weak) IBOutlet UILabel *lblId;

- (void)configWithUserRecord:(NSDictionary *)userRecord;

@end
