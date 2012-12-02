//
//  ViewController.m
//  Bucket10
//
//  Created by Brad Grifffith on 12/1/12.
//  Copyright (c) 2012 Brad Grifffith. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

@synthesize startButton;
@synthesize backgroundImageView;
@synthesize logoImageView;

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *backgroundImage = [UIImage imageNamed: @"background-586h.png"];
    [self.backgroundImageView setImage:backgroundImage];
    [self.backgroundImageView sendSubviewToBack:backgroundImageView];
    
    UIImage *logoImage = [UIImage imageNamed: @"logo-white.png"];
    [self.logoImageView setImage:logoImage];
    [self.logoImageView sendSubviewToBack:backgroundImageView];
    
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    if (![self.navigationController isNavigationBarHidden]) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
}

@end
