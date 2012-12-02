//
//  AppDelegate.h
//  Bucket10
//
//  Created by Brad Grifffith on 12/1/12.
//  Copyright (c) 2012 Brad Grifffith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKNetworkEngine.h"

#define ApplicationDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) NSString *userEmail;
@property (strong, nonatomic) MKNetworkEngine *networkEngine;

@end
