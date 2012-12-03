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

UIImageView *beeView;
bool webFinishedLoading = NO;
int numAnimiations = 0;

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

- (void)webViewDidStartLoad:(UIWebView *)webView //UPDATED

{
    
    NSLog(@"webViewDidStartLoad");
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [indicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    [indicator setColor:[UIColor grayColor]];
    
    [indicator startAnimating];
    
    
    
    int screenWidth = self.view.frame.size.width;
    
    int screenHeight = self.view.frame.size.height;
    
    int width = 20;
    
    int height = 24;
    
    
    
    NSLog(@"webFinishedLoading %d", webFinishedLoading);
    
    while (!webFinishedLoading && numAnimiations < 4) {
        
        CGRect startFrame = CGRectMake(1.1*screenWidth+numAnimiations*screenWidth, 0.091*numAnimiations*screenHeight+0.5*height, width, height);
        
        beeView = [[UIImageView alloc] initWithFrame:startFrame];
        
        [self.webView addSubview:beeView];
        
        beeView.image = [UIImage imageNamed:@"rsz_1logo-dark2x.png"];
        
        NSLog(@"numAnimations %d", numAnimiations);
        
        beeView.clipsToBounds = YES;
        
        
        
        int endX = -0.1*screenWidth;
        
        if (numAnimiations == 3) {
            
            endX = 0.1*screenWidth;
            
        }
        
        CGRect endFrame = CGRectMake(endX, 0.091*numAnimiations*screenHeight+0.5*height, width, height);
        
        [UIView animateWithDuration:numAnimiations
         
                              delay:0.0
         
                            options:UIViewAnimationOptionBeginFromCurrentState
         
                         animations:^{
                             
                             [beeView setFrame:endFrame];
                             
                         }
         
                         completion:^(BOOL finished){
                             
                             [UIView animateWithDuration:1.5
                              
                                                   delay:2.1
                              
                                                 options:UIViewAnimationOptionBeginFromCurrentState
                              
                                              animations:^{
                                                  
                                                  [beeView setAlpha:0.0];
                                                  
                                              }
                              
                                              completion:^(BOOL finished){
                                                  
                                              }];
                             
                         }];
        
        numAnimiations++;
        
    }
    
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
    
    
    NSLog(@"defaults updated URL to %@", userEmail);
    
    NSLog(@"webViewDidFinishLoad URL %@", currentURL);
    if (currentURL && [[currentURL componentsSeparatedByString:@"/"] count] == 4)
    {
        NSString *middlePart = [[currentURL componentsSeparatedByString:@"/"] objectAtIndex:2];
        NSString *email = [[currentURL componentsSeparatedByString:@"/"] lastObject];
        if ([middlePart isEqualToString:@"mighty-cove-2042.herokuapp.com"]) {
            [[NSUserDefaults standardUserDefaults] setObject:email forKey:@"email"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [ApplicationDelegate pushTokenToServer];
            [self performSegueWithIdentifier:@"LoggedInSegue" sender:nil];
        }
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"didFailLoadWithError");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
