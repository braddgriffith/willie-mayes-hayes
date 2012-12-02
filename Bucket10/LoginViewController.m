//
//  LoginViewController.m
//  Bucket10
//
//  Created by Brad Grifffith on 12/1/12.
//  Copyright (c) 2012 Brad Grifffith. All rights reserved.
//

#import "LoginViewController.h"
#import "ThanksViewController.h"
#import "UAPush.h"
#import <QuartzCore/QuartzCore.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize webView;
@synthesize indicator;
@synthesize backgroundImageView;

bool webFinishedLoading = NO;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header-logo.png"]];
    
    self.webView.delegate = self;
    webView.backgroundColor = [UIColor clearColor];
    
    NSURL *url = [NSURL URLWithString:@"http://mighty-cove-2042.herokuapp.com/auth/google_oauth2"];
    NSURLRequest *requestURL = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestURL];
    
    // Register for notifications
    [[UAPush shared]
     registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                         UIRemoteNotificationTypeSound |
                                         UIRemoteNotificationTypeAlert)];
}


- (void)viewDidUnload
{
    [self setWebView:nil];
    [super viewDidUnload];
}


-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    
#pragma mark - Optional UIWebViewDelegate delegate methods

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    int screenWidth = self.view.frame.size.width;
    int screenHeight = self.view.frame.size.height;
    
    NSLog(@"webViewDidStartLoad");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [indicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [indicator setColor:[UIColor grayColor]];
    [indicator startAnimating];
    
    int width = 20;
    int height = 24;
    CGRect frame = CGRectMake(1.5*screenWidth, 0.5*screenHeight, width, height);
    UIImageView *endView = [[UIImageView alloc] initWithFrame:frame];
    endView.image = [UIImage imageNamed:@"rsz_1logo-dark2x.png"];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    webFinishedLoading = YES;
    NSLog(@"webViewDidFinishLoad");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [indicator stopAnimating];
    [indicator removeFromSuperview];
    
    NSString *currentURL = self.webView.request.URL.absoluteString;
    NSString *userEmail = self.webView.request.URL.absoluteString;
    
    [[NSUserDefaults standardUserDefaults] setObject:userEmail forKey:@"email"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSLog(@"defaults updated URL to %@", userEmail);
    
    NSLog(@"webViewDidFinishLoad URL %@", currentURL);
    if (currentURL)
    {
        NSString *url = [[currentURL componentsSeparatedByString:@"?"] objectAtIndex:0];
        if ([url isEqualToString:@"http://mighty-cove-2042.herokuapp.com/auth/google_oauth2/callback"]) {
            [self performSegueWithIdentifier:@"LoggedInSegue" sender:nil];
            NSLog(@"transition!");
        }
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"didFailLoadWithError");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
