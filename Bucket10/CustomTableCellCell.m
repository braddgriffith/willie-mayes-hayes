//
//  CustomTableCellCell.m
//  Bucket10
//
//  Created by Kevin Gibbon on 12/2/12.
//  Copyright (c) 2012 Brad Grifffith. All rights reserved.
//

#import "CustomTableCellCell.h"

@implementation CustomTableCellCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
