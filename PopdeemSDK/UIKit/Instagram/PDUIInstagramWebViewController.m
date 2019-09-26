//
//  PDUIInstagramWebViewController.m
//  PopdeemSDK
//
//  Created by Niall Quinn on 17/06/2016.
//  Copyright © 2016 Popdeem. All rights reserved.
//

#import "PopdeemSDK.h"
#import "PDUIInstagramWebViewController.h"
#import "PDTheme.h"
#import "PDUtils.h"
#import "PDConstants.h"

@interface PDUIInstagramWebViewController ()

@end

//NSString *client_id;
//NSString *secret;
//NSString *callback;

@implementation PDUIInstagramWebViewController

- (instancetype) initFromNib {
    
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[PDUIInstagramWebViewController class]]] setTintColor:[UIColor blackColor]];
    
	NSBundle *podBundle = [NSBundle bundleForClass:[PopdeemSDK class]];
	if (self = [self initWithNibName:@"PDUIInstagramWebViewController" bundle:podBundle]) {
		self.navigationController.navigationBar.translucent = YES;
		[self.navigationController.navigationBar setBarTintColor:PopdeemColor(PDThemeColorPrimaryApp)];
		[self.navigationController.navigationBar setTintColor:PopdeemColor(PDThemeColorPrimaryInverse)];
		[self.navigationController.navigationBar setTitleTextAttributes:@{
																																			NSForegroundColorAttributeName : PopdeemColor(PDThemeColorPrimaryInverse),
																																			NSFontAttributeName : PopdeemFont(PDThemeFontPrimary, 16.0f)
																																			}];
		
		[self.navigationController.navigationItem.rightBarButtonItem setTitleTextAttributes:@{
																																													NSForegroundColorAttributeName : PopdeemColor(PDThemeColorPrimaryInverse),
																																													NSFontAttributeName : PopdeemFont(PDThemeFontPrimary, 16.0f)}
																																							 forState:UIControlStateNormal];
		if (PopdeemThemeHasValueForKey(@"popdeem.images.navigationBar")){
			[self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
		}
		[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
		self.title = translationForKey(@"popdeem.instagram.webview.title",@"Connect Instagram Account");
		return self;
	}
	return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _wkWebView.navigationDelegate = self;
    _wkWebView.UIDelegate = self;
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void) viewDidAppear:(BOOL)animated {
    
    /*
    _loadingView = [[PDUIModalLoadingView alloc] initForView:self.view titleText:@"Please Wait" descriptionText:@"Preparing Instagram Login"];
    [_loadingView showAnimated:YES];
    */
    
    /*
    client_id = [PopdeemSDK instagramClientId];
    secret = [PopdeemSDK instagramClientSecret];
    callback = [PopdeemSDK instagramCallback];
    
    NSString *url = [NSString stringWithFormat:@"https://api.instagram.com/oauth/authorize/?client_id=%@&redirect_uri=%@&response_type=code&scope=basic",client_id,callback];
    [_loadingView hideAnimated:YES];
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [_wkWebView loadRequest:req];
    */
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)closeButtonTapped:(id)sender {
  [[NSNotificationCenter defaultCenter] postNotificationName:InstagramLoginCancelPressed object:nil];
  __weak typeof(self) weakSelf = self;
	[self dismissViewControllerAnimated:YES completion:^(void){
		if (weakSelf.wkWebView && [weakSelf.wkWebView isLoading]) {
				[weakSelf.wkWebView stopLoading];
		}
	}];
}

- (void) viewWillDisappear:(BOOL)animated {
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}


- (void) wkWebView:(WKWebView *)wkWebView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow);
    
    NSLog(@"Testing WKWebView");
    //NSURLRequest *request = navigationAction.request;
    //NSLog(@"request", request);
}




    
    /*
    if ([[[request URL] URLStringWithoutQuery] rangeOfString:@"accounts/login"].location != NSNotFound) {
        //Show login view
        [_loadingView hideAnimated:YES];
    }
    
 
    PDLog(@"URL: %@", [[request URL] URLStringWithoutQuery]);
    if ([[[request URL] URLStringWithoutQuery] rangeOfString:callback].location != NSNotFound) {
        [_loadingView hideAnimated:YES];
        // Extract oauth_verifier from URL query
        //        _webViewController.loadingView = [[PDUIModalLoadingView alloc] initForView:_webViewController.view titleText:@"Please Wait" descriptionText:@"We are connecting your Instagram Account"];
        //        [_webViewController.loadingView showAnimated:YES];
        NSString* verifier = nil;
        NSArray* urlParams = [[[request URL] query] componentsSeparatedByString:@"&"];
        for (NSString* param in urlParams) {
            NSArray* keyValue = [param componentsSeparatedByString:@"="];
            NSString* key = [keyValue objectAtIndex:0];
            if ([key isEqualToString:@"code"]) {
                verifier = [keyValue objectAtIndex:1];
                break;
            }
        }
        
        if (verifier) {
            
            NSString *data = [NSString stringWithFormat:@"client_id=%@&client_secret=%@&grant_type=authorization_code&redirect_uri=%@&code=%@",client_id,secret,callback,verifier];
            
            NSString *url = [NSString stringWithFormat:@"https://api.instagram.com/oauth/access_token"];
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
            [request setHTTPMethod:@"POST"];
            [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
            NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
            PDLog(@"Instagram connection started: %@", theConnection);
            receivedData = [[NSMutableData alloc] init];
        } else {
            // ERROR!
        }
        
        [wkWebView removeFromSuperview];
    }
     
     */



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
