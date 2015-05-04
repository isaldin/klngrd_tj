//
//  PreviewAndPrintWebViewController.h
//  klngrd_tj
//
//  Created by ILYA SALDIN on 5/4/15.
//  Copyright (c) 2015 sald.in. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PreviewAndPrintWebViewController : UIViewController<UIWebViewDelegate>

@property (nonatomic, weak) IBOutlet UIWebView *previewAndPrintWebView;

@property (nonatomic, weak) IBOutlet UIBarButtonItem *barBtnCancel;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *barBtnPrint;

- (IBAction)cancelTapped:(id)sender;
- (IBAction)printTapped:(id)sender;

@property (nonatomic, copy) NSString *htmlString;

@end
