//
//  ViewController.m
//  MySafari
//
//  Created by S on 10/1/14.
//  Copyright (c) 2014 Ryan Siska. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadWebPageWithString:@"http://www.google.com"];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    if (self.webView.canGoBack) {
        self.backButton.hidden = NO;
    } else {
        self.backButton.hidden = YES;
    }

    if (self.webView.canGoForward) {
        self.forwardButton.hidden = NO;
    } else {
        self.forwardButton.hidden = YES;
    }

}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

//the below method just hides the keyboard once the user hits enter. we're coopting it to perform other actions because it's convenient for us
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self loadWebPageWithString:textField.text];

    return YES;
}

- (void)loadWebPageWithString:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];
}

- (IBAction)onBackButtonPressed:(id)sender {
    [self.webView goBack];
}

- (IBAction)onForwardButtonPressed:(id)sender {
    [self.webView goForward];
}

- (IBAction)onStopLoadingButtonPressed:(id)sender {
    [self.webView stopLoading];
}

- (IBAction)onReloadButtonPressed:(id)sender {
    [self.webView reload];
}







@end
