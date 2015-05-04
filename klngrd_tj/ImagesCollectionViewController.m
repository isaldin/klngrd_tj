//
//  ImagesCollectionViewController.m
//  klngrd_tj
//
//  Created by il.ya sald.in on 5/2/15.
//  Copyright (c) 2015 sald.in. All rights reserved.
//

#import "ImagesCollectionViewController.h"
#import "ImageCell.h"
#import "InstagramAPI.h"

@interface ImagesCollectionViewController ()

@end

@implementation ImagesCollectionViewController
{
    NSURLSession *_session;
    NSMutableArray *_selectedImages;
    NSMutableArray *_deselectedImages;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _selectedImages = [NSMutableArray array];
    _deselectedImages = [NSMutableArray array];

    _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];

    UIBarButtonItem *generatePDFAndPrintBtn = [[UIBarButtonItem alloc] initWithTitle:@"Print" style:UIBarButtonItemStylePlain target:self action:@selector(generatePDFAndSendToPrint)];
    self.navigationItem.rightBarButtonItem = generatePDFAndPrintBtn;
    
    [self fetchBestPhotosForCurrentUser];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchBestPhotosForCurrentUser
{
    NSString *fetchingURL = [InstagramAPI buildRecentImagesURLStringForUsernameWithId:self.user[@"id"]];
    NSLog(@"%@", fetchingURL);

    NSURLSessionDataTask *dataTask = [_session dataTaskWithURL:[NSURL URLWithString:fetchingURL] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        _selectedImages = [NSMutableArray arrayWithArray:[self parseResponse:json]];

        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }];

    [dataTask resume];
}

- (NSArray *)parseResponse:(NSDictionary *)json
{
    if(!json[@"meta"] || ![json[@"meta"][@"code"] isEqual:@(200)]){
        return @[];
    }

    NSMutableArray *parsedResponse = [NSMutableArray array];
    [json[@"data"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [parsedResponse addObject:obj[@"images"][@"standard_resolution"][@"url"]];
    }];

    return parsedResponse;
}

- (void)generatePDFAndSendToPrint
{
    NSLog(@"%@", @"[generatePDFAndSendToPrint] invoked");
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return section == 0 ? _selectedImages.count : _deselectedImages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * const reuseIdentifier = @"ImageCellID";

    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if(indexPath.section == 0){
        NSString *imgURLString = _selectedImages[indexPath.row];
        [cell configWithImageURLString:imgURLString];
        [cell setIndicatorImageName:@"minus_icon"];
    }
    else{
        NSString *imgURLString = _deselectedImages[indexPath.row];
        [cell configWithImageURLString:imgURLString];
        [cell setIndicatorImageName:@"add_icon"];
    }

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        ImageCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
        [cell setIndicatorImageName:@"add_icon"];
        NSString *tappedImageURL = [_selectedImages objectAtIndex:indexPath.row];
        [_selectedImages removeObject:tappedImageURL];
        [_deselectedImages addObject:tappedImageURL];

        [collectionView moveItemAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForItem:_deselectedImages.count-1 inSection:1]];
    }
    else{
        ImageCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
        [cell setIndicatorImageName:@"minus_icon"];
        NSString *tappedImageURL = [_deselectedImages objectAtIndex:indexPath.row];
        [_deselectedImages removeObject:tappedImageURL];
        [_selectedImages addObject:tappedImageURL];

        [collectionView moveItemAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForItem:_selectedImages.count-1 inSection:0]];
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)sectionNumber
{
    return CGSizeMake(150.f, 30.f);
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
