//
//  ACInstagramWebViewController.m
//  ACInsagramFeed
//
//  Created by Chemersky on 5/14/17.
//  Copyright © 2017 Chemer. All rights reserved.
//

#import "ACInstagramWebViewController.h"

NSString * const kACInstagramRedirectUri = @"http://cdn4.iconfinder.com/data/icons/defaulticon/icons/png/256x256/check.png";
NSString * const kACInstagramScope = @"basic+public_content+follower_list+comments+relationships+likes";
NSString * const kACInstagramClientId = @"87d09c45596946c3b19c76fab70be046";


@interface ACInstagramWebViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, copy) void (^accessTokenCompletionHandler)(BOOL accessToken);
@property (nonatomic, copy) void (^logoutCompletionHandler)();

- (void)applyCompletionHandlers;
@end

@implementation ACInstagramWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loginViewRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"URL = %@", webView.request.URL);
    NSString *url = webView.request.URL.absoluteString;
    NSArray *urlComponents = [url componentsSeparatedByString:@"#access_token="];
    if (urlComponents.count > 1) {
        self.accessToken = urlComponents[1];
    } else {
        self.accessToken = nil;
    }
    
    [self applyCompletionHandlers];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    //@TODO handle error
//    [self applyCompletionHandlers];
}

#pragma mark - Public

- (void)requestAccessToken:(void(^)(BOOL accessToken))completion {
    self.accessTokenCompletionHandler = completion;
    if (self.accessToken) {
        self.accessTokenCompletionHandler(YES);
        self.accessTokenCompletionHandler = nil;
    } else {
        [self view]; /*load view if not loaded*/
        [self loginViewRequest];
    }
}

- (void)loginViewRequest {
    NSString *url = [NSString stringWithFormat:@"https://instagram.com/oauth/authorize?response_type=token&redirect_uri=%@&scope=%@&client_id=%@", kACInstagramRedirectUri, kACInstagramScope, kACInstagramClientId];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

- (void)logout:(void(^)())completion {
    self.logoutCompletionHandler = completion;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://instagram.com/accounts/logout/"]]];
}

#pragma mark - Private

- (void)applyCompletionHandlers {
    if (self.accessTokenCompletionHandler) {
        self.accessTokenCompletionHandler((self.accessToken?YES:NO));
        self.accessTokenCompletionHandler = nil;
    }
    if (self.logoutCompletionHandler) {
        [self loginViewRequest];
        self.logoutCompletionHandler();
        self.logoutCompletionHandler = nil;
    }
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
