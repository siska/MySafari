//
//  ViewController.m
//  MySafari
//
//  Created by S on 10/1/14.
//  Copyright (c) 2014 Ryan Siska. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;
@property (weak, nonatomic) IBOutlet UILabel *webPageTitleLabel;
@property CGFloat lastContentOffset;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.webView.scrollView.delegate = self;

    [self loadWebPageWithString:@"http://www.google.com"];
}

#pragma mark - UITextFieldDelegate

//the below method just hides the keyboard once the user hits enter. we're coopting it to perform other actions because it's convenient for us
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self loadWebPageWithString:textField.text];

    return YES;
}

#pragma mark - UIWebViewDelegate

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

    self.webPageTitleLabel.text = @"";

}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.urlTextField.text = [self.webView.request.URL absoluteString];

    NSString *webPageTitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.webPageTitleLabel.text = webPageTitle;

}

// review after - refactor with method to add http
- (void)loadWebPageWithString:(NSString *)urlString {
    if (![urlString hasPrefix:@"http://"]) {
        NSString *newURLString = [NSString stringWithFormat:@"http://%@", urlString];
        NSURL *url = [NSURL URLWithString:newURLString];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url]; //instance methods - used to refer to the actual instances, e.g. an instance method would refer to *urlRequest - to the right (starting with NSURLRequest) is a class with a class method affecting it. Aove with self.urlTextField.text = [self.webview.etc. we have an instance method affecting an instance, which is our url string.
        [self.webView loadRequest:urlRequest];
    } else {
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:urlRequest];
    }

}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.lastContentOffset > scrollView.contentOffset.y) {
        //NSLog(@"Scrolling up");
        self.urlTextField.hidden = NO;
    } else if (self.lastContentOffset < scrollView.contentOffset.y) {
        //NSLog(@"Scrolling down");
        self.urlTextField.hidden = YES;
    }

    self.lastContentOffset = scrollView.contentOffset.y;
}

#pragma mark - Button Actions

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

- (IBAction)onPlusButtonPressed:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Coming Soon" message:@"New Features Are On The Way" delegate: nil cancelButtonTitle:@"OK" otherButtonTitles: nil];

    [alertView show];
}

@end
