//
//  privacyViewController.m
//  酒店管理
//
//  Created by 杨奇 on 2019/9/20.
//  Copyright © 2019 杨奇. All rights reserved.
//

#import "privacyViewController.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

@interface privacyViewController ()

@end

@implementation privacyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _urlString = [NSString stringWithFormat:@"https://honey.dating/xy.html"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_urlString]];
    [self.view addSubview:_webView];
    [self.webView loadRequest:request];
}
@end
