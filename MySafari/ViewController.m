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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

//the below method just hides the keyboard once the user hits enter. we're coopting it to perform other actions because it's convenient for us
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSURL *url = [NSURL URLWithString:self.urlTextField.text];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    
    return YES;
}

@end
