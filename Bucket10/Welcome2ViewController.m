//
//  Welcome2ViewController.m
//  Bucket10
//
//  Created by Kevin Gibbon on 12/1/12.
//  Copyright (c) 2012 Brad Grifffith. All rights reserved.
//

#import "Welcome2ViewController.h"
#import "ThanksViewController.h"

@interface Welcome2ViewController ()

@end

@implementation Welcome2ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header-logo.png"]];
    [self.navigationItem setRightBarButtonItem:[ThanksViewController greySquareButtonWithTitle:@" Next " target:self andAction:@selector(nextPage)]];
	// Do any additional setup after loading the view.
}

-(void)nextPage
{
    [self performSegueWithIdentifier:@"GoToTable" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
