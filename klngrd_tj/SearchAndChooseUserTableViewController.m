//
//  SearchAndChooseUserTableViewController.m
//  klngrd_tj
//
//  Created by il.ya sald.in on 5/2/15.
//  Copyright (c) 2015 sald.in. All rights reserved.
//

#define instagramClientID @"b9e8581bbbab4c7db875b9deb5d32a38"
#define instagramApiSearchUserStringFormat @"https://api.instagram.com/v1/users/search?q=%@&client_id=%@"

#import "SearchAndChooseUserTableViewController.h"
#import "UserNameCell.h"

@interface SearchAndChooseUserTableViewController ()

@end

@implementation SearchAndChooseUserTableViewController
{
    NSArray *_parsedResponse;
    NSURLSession *_session;
};

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.searchBar.delegate = self;
    
    _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    _parsedResponse = @[];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)startNewSearchUsersTaskWithUsernameString:(NSString *)usernameString
{
    NSString *urlString = [NSString stringWithFormat:instagramApiSearchUserStringFormat, usernameString, instagramClientID];
    NSURLSessionDataTask *dataTask = [_session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(!error){
            NSLog(@"datatask complete");
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            _parsedResponse = [self parseApiResponse:json];

            dispatch_sync(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    }];

    [dataTask resume];
}

- (NSArray *)parseApiResponse:(NSDictionary *)json
{
    if(!json[@"meta"] || ![json[@"meta"][@"code"] isEqual:@(200)]){
        return @[];
    }

    NSMutableArray *parsedResponse = [NSMutableArray array];

    [json[@"data"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [parsedResponse addObject:@{
                @"username": obj[@"username"] ? : @"",
                @"full_name": obj[@"full_name"] ? : @"",
                @"avatar": obj[@"profile_picture"] ? : @"",
                @"id": obj[@"id"] ? : @""
        }];
    }];

    return parsedResponse;
}

#pragma mark searchDisplayController delegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
//- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [_session getTasksWithCompletionHandler:^(NSArray *dataTasks, NSArray *uploadTasks, NSArray *downloadTasks) {
        NSLog(@"datatasks count: %d", dataTasks.count);
        [dataTasks enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSURLSessionDataTask *dataTask = obj;
            [dataTask cancel];
        }];
    }];

    NSLog(@"search string is [%@]", searchText);

    if([searchText isEqualToString:@""]){
        _parsedResponse = @[];
        [self.tableView reloadData];
    }
    else{
        [self startNewSearchUsersTaskWithUsernameString:searchText];
    }
}

#pragma mark - Table view datasource & delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _parsedResponse.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *userRecord = _parsedResponse[indexPath.row];

    static NSString *cellID = @"UserInfoCellID";
    UserNameCell *cell = (UserNameCell *)[self.tableView dequeueReusableCellWithIdentifier:cellID];
    [cell configWithUserRecord:userRecord];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 108.f;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.searchBar resignFirstResponder];
}

@end