//
//  PreviewAndPrintWebViewController.m
//  klngrd_tj
//
//  Created by ILYA SALDIN on 5/4/15.
//  Copyright (c) 2015 sald.in. All rights reserved.
//

#import "PreviewAndPrintWebViewController.h"

@interface PreviewAndPrintWebViewController ()

@end

@implementation PreviewAndPrintWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.previewAndPrintWebView.delegate = self;
    [self.previewAndPrintWebView loadHTMLString:self.htmlString baseURL:nil];

    self.barBtnPrint.enabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelTapped:(id)sender
{
    [self.previewAndPrintWebView stopLoading];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)printTapped:(id)sender
{
    UIPrintInfo *pi = [UIPrintInfo printInfo];
    pi.outputType = UIPrintInfoOutputGeneral;
    pi.jobName = self.previewAndPrintWebView.request.URL.absoluteString;
    pi.orientation = UIPrintInfoOrientationPortrait;
    pi.duplex = UIPrintInfoDuplexLongEdge;

    UIPrintInteractionController *pic = [UIPrintInteractionController sharedPrintController];
    pic.printInfo = pi;
    pic.showsPageRange = YES;
    pic.printFormatter = self.previewAndPrintWebView.viewPrintFormatter;
    [pic presentAnimated:YES completionHandler:^(UIPrintInteractionController *pic2, BOOL completed, NSError *error) {
        // indicate done or error
    }];
}

#pragma mark webView delegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    //
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.barBtnPrint.enabled = YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Something going wrong :(" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
