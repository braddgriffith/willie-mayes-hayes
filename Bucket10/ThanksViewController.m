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

@synthesize backgroundImageView;
@synthesize logoImageView;

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header-logo.png"]];
    [self.navigationItem setHidesBackButton:YES animated:NO];
    UIImage *logoImage = [UIImage imageNamed: @"logo-white.png"];
    [self.logoImageView setImage:logoImage];
    [self.logoImageView sendSubviewToBack:backgroundImageView];
    
    [self.navigationItem setRightBarButtonItem:[ThanksViewController greySquareButtonWithTitle:@" Next " target:self andAction:@selector(nextPage)]];
    
    [self.navigationItem setLeftBarButtonItem:[ThanksViewController blackArrowButtonWithTarget:self andAction:@selector(backButtonPressed)]];
}

//-(void)viewWillAppear:(BOOL)animated //ADDED
//
//{
//    int screenWidth = self.view.frame.size.width;
//    int screenHeight = self.view.frame.size.height;
//    int width = 20;
//    int height = 24;
//    
//    
//    CGRect startFrame = CGRectMake(1.1*screenWidth, 0.5*screenHeight+0.5*height, width, height);
//    UIImageView *beeView = [[UIImageView alloc] initWithFrame:startFrame];
//    [self.backgroundImageView addSubview:beeView];
//    beeView.image = [UIImage imageNamed:@"rsz_1logo-dark2x.png"];
//    
//    CGRect endFrame = CGRectMake(0.5*screenWidth, 0.5*screenHeight+0.5*height, width, height);
//    [UIView animateWithDuration:2.5     
//                          delay:0.0
//                        options:UIViewAnimationOptionBeginFromCurrentState
//                     animations:^{
//                         [beeView setFrame:endFrame];
//                     }
//                     completion:^(BOOL finished){
//                         beeView.frame = CGRectMake(0.5*screenWidth, 0.5*screenHeight+0.5*height, 1, 1);
//                     }];
//    
//}

-(void)backButtonPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)nextPage
{
    [self performSegueWithIdentifier:@"Thanks2Page" sender:self];
}

+ (UIBarButtonItem *)blackArrowButtonWithTarget:(id)actionTarget andAction:(SEL)buttonAction{
    UIBarButtonItem *thisButton = [[UIBarButtonItem alloc]init];
    [thisButton setBackgroundImage:[[UIImage imageNamed:@"btn_back_dark"]resizableImageWithCapInsets:UIEdgeInsetsMake(14,14,14,4)] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [thisButton setImage:[UIImage imageNamed:@"icon_back_arrow"]];
    [thisButton setTarget:actionTarget];
    [thisButton setAction:buttonAction];
    
    return thisButton;
}

+ (UIBarButtonItem *)greySquareButtonWithTitle:(NSString *)buttonTitle target:(id)actionTarget andAction:(SEL)buttonAction{
    UIBarButtonItem *thisButton = [[UIBarButtonItem alloc]init];
    [thisButton setBackgroundImage:[[UIImage imageNamed:@"header-button.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(12,9,12,9)] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [thisButton setWidth:thisButton.width +6];
    [thisButton setTitle:buttonTitle];
    [thisButton setTarget:actionTarget];
    [thisButton setAction:buttonAction];
    
    return thisButton;
}

@end