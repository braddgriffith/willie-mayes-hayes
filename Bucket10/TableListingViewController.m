//
//  TableListingViewController.m
//  Bucket10
//
//  Created by Kevin Gibbon on 12/2/12.
//  Copyright (c) 2012 Brad Grifffith. All rights reserved.
//

#import "TableListingViewController.h"
#import "CustomTableCellCell.h"

@interface TableListingViewController ()
{
    NSMutableArray *passes;
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
    passes = [NSMutableArray array];
    
    
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
    cell.label = [dictonary objectForKey:@"title"];
    NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
    cell.addButton.tag = indexPath.row;
    [cell.addButton addTarget:self action:@selector(addButtonPressed) forControlEvents:UIControlEventTouchUpInside];
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

- (void) addButtonPressed
{
    
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
