//
//  ImageCell.m
//  klngrd_tj
//
//  Created by il.ya sald.in on 5/2/15.
//  Copyright (c) 2015 sald.in. All rights reserved.
//

#import "ImageCell.h"

@implementation ImageCell

- (void)configWithImageURLString:(NSString *)urlString
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.imgViewPhoto setImage:[UIImage imageWithData:imageData]];
        });
    });
}

- (void)picked:(BOOL)isPicked;
{
    self.imgViewSelectionIndicator.hidden = !isPicked;
}

@end
