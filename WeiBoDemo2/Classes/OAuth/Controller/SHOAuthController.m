//
//  SHOAuthController.m
//  WeiBoDemo2
//  授权登录界面
//  Created by HuangSenhui on 2019/5/5.
//  Copyright © 2019 HuangSenhui. All rights reserved.
//

#import "SHOAuthController.h"

#import "SHUserAccount.h"
#import "SHLaunchTools.h"
#import "SHHttpTools.h"
#import "SHAccountTools.h"

#import <MBProgressHUD.h>

#define SHbaseURL          @"https://api.weibo.com/oauth2/authorize"
#define SHClient_id        @"3399930463"
#define SHRedirect_uri     @"https://www.baidu.com"

@interface SHOAuthController () <UIWebViewDelegate>

@end

@implementation SHOAuthController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 新浪登录界面
    [self loadLoginView];
}

- (void)loadLoginView {
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.delegate = self;
    [self.view addSubview:webView];
    
    // 设置请求，加载数据
    NSString *urlStr = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@",SHbaseURL,SHClient_id,SHRedirect_uri];
    NSURL *requestURL = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:requestURL];

    [webView loadRequest:request];
}

#pragma mark - webView delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSString *urlStr = request.URL.absoluteString;
    NSRange range = [urlStr rangeOfString:@"code="];
    
    if (range.length) {
        NSString *code = [urlStr substringFromIndex:(range.location+range.length)];
        [self getAccessToken:code];
        return NO;
    }
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)getAccessToken:(NSString *)code {
    
    [SHAccountTools getTokenWithCode:code success:^{
        // 进入主界面
        [SHLaunchTools launchFirstControllerWithWindow:[UIApplication sharedApplication].keyWindow];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

@end
