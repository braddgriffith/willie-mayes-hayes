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

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize webView;
@synthesize indicator;
@synthesize backgroundImageView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header-logo.png"]];
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header.jpg"]]];
    self.navigationItem.rightBarButtonItem = item;
    
    UIImage *backgroundImage = [UIImage imageNamed: @"background-586h.png"];
    [self.backgroundImageView setImage:backgroundImage];
    [self.backgroundImageView sendSubviewToBack:backgroundImageView];
    
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
    NSLog(@"webViewDidStartLoad");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [indicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [indicator setColor:[UIColor grayColor]];
    [indicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidFinishLoad");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [indicator stopAnimating];
    [indicator removeFromSuperview];
    
    NSString *currentURL = self.webView.request.URL.absoluteString;
    NSLog(@"webViewDidFinishLoad URL %@", currentURL);
    if ([currentURL isEqualToString:@"http://mighty-cove-2042.herokuapp.com/"]) {
        [self performSegueWithIdentifier:@"LoggedInSegue" sender:nil];
        NSLog(@"transition!");
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"didFailLoadWithError");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    // Make sure your segue name in storyboard is the same as this line
//    if ([[segue identifier] isEqualToString:@"LoggedInSegue"])
//    {
//        ThanksViewController *destinationVC = [segue destinationViewController];
//    }
//}

@end
