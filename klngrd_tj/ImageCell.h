//
//  ImageCell.h
//  klngrd_tj
//
//  Created by il.ya sald.in on 5/2/15.
//  Copyright (c) 2015 sald.in. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UIImageView *imgViewPhoto;
@property (nonatomic, weak) IBOutlet UIImageView *imgViewSelectionIndicator;

- (void)configWithImageURLString:(NSString *)urlString;

- (void)picked:(BOOL)isPicked;

@end
