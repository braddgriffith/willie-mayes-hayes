//
//  PassKitHelper.h
//  Bucket10
//
//  Created by Brad Grifffith on 12/2/12.
//  Copyright (c) 2012 Brad Grifffith. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PassKit/PassKit.h>

@interface PassKitHelper : NSObject <PKAddPassesViewControllerDelegate>

@property (weak, nonatomic) UIViewController *viewController;

-(void)openPassFile:(NSString*)urlStr;

@end
