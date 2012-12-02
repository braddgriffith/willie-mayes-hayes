//
//  TableListingViewController.m
//  Bucket10
//
//  Created by Kevin Gibbon on 12/2/12.
//  Copyright (c) 2012 Brad Grifffith. All rights reserved.
//

#import "TableListingViewController.h"
#import "CustomTableCellCell.h"
#import "PassKitHelper.h"


@interface TableListingViewController ()
{
    NSMutableArray *passes;
    PassKitHelper *passKitHelper;
}

@end

@implementation TableListingViewController

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
    passKitHelper = [[PassKitHelper alloc] init];
    passKitHelper.viewController = self;
    [self.navigationItem setHidesBackButton:YES animated:NO];
    passes = [NSMutableArray array];
    [passes addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"I AM A TITLE", @"title", @"http://173.255.243.60:4567/2949d770-1eac-0130-2698-7efdadfff33c/bucket.pkpass", @"pk_url", nil]];
    [passes addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"I AM A TITLE", @"title", @"http://173.255.243.60:4567/0ba59d90-1eaa-0130-2693-7efdadfff33c/bucket.pkpass", @"pk_url", nil]];
    [passes addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"I AM A TITLE", @"title", @"http://173.255.243.60:4567/0ba59d90-1eaa-0130-2693-7efdadfff33c/bucket.pkpass", @"pk_url", nil]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header-logo.png"]];
    
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"CustomTableCellCell";
    CustomTableCellCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSDictionary *dictonary = [passes objectAtIndex:[indexPath row]];
    cell.titleLabel.text = [dictonary objectForKey:@"title"];
    NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
    cell.addButton.tag = indexPath.row;
    [cell.addButton addTarget:self action:@selector(addButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    BOOL inPassbook = [currentDefaults boolForKey:[dictonary objectForKey:@"pk_url"]];
    if (!inPassbook)
    {
        cell.addButton.hidden = NO;
    }
    else
    {
        cell.addButton.hidden = YES;
    }
    return cell;
}



- (void) addButtonPressed:(id)obj
{
    UIButton *button = obj;
    NSInteger index = button.tag;
    
    NSString *url = [[passes objectAtIndex:index] objectForKey:@"pk_url"];
    [passKitHelper openPassFile:url];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 63.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [passes count];
}

@end
