//
//  ThanksViewController.m
//  Bucket10
//
//  Created by Brad Grifffith on 12/1/12.
//  Copyright (c) 2012 Brad Grifffith. All rights reserved.
//

#import "ThanksViewController.h"
#import "UAPush.h"

@interface ThanksViewController ()

@end

@implementation ThanksViewController

@synthesize startButton;
@synthesize backgroundImageView;
@synthesize logoImageView;

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *backgroundImage = [UIImage imageNamed: @"background-586h.png"];
    [self.backgroundImageView setImage:backgroundImage];
    [self.backgroundImageView sendSubviewToBack:backgroundImageView];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header-logo.png"]];
    
    UIImage *logoImage = [UIImage imageNamed: @"logo-white.png"];
    [self.logoImageView setImage:logoImage];
    [self.logoImageView sendSubviewToBack:backgroundImageView];
    
    self.navigationController.navigationBarHidden = NO;
    
}

@end