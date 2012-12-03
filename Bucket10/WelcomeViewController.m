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
    //[self drawBeeAnimation];
    UIImage *logoImage = [UIImage imageNamed: @"logo-white.png"];
    [self.logoImageView setImage:logoImage];
    [self.logoImageView sendSubviewToBack:backgroundImageView];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header.png"] forBarMetrics:UIBarMetricsDefault];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self drawBeeAnimation];
}

-(void)drawBeeAnimation
{
    int screenWidth = self.view.frame.size.width;
    int screenHeight = self.view.frame.size.height;
    int width = 20;
    int height = 24;
    
    CGRect startFrame = CGRectMake(1.1*screenWidth, 0.5*screenHeight+0.5*height, width, height);
    UIImageView *beeView = [[UIImageView alloc] initWithFrame:startFrame];
    [self.backgroundImageView addSubview:beeView];
    beeView.image = [UIImage imageNamed:@"rsz_1logo-dark2x.png"];
    
    CGRect endFrame = CGRectMake(-0.1*screenWidth, 0.5*screenHeight+0.5*height, width, height);
    [UIView animateWithDuration:2.
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [beeView setFrame:endFrame];
                         
                     }
                     completion:^(BOOL finished){
                         [beeView removeFromSuperview];
                     }];
}


@end
