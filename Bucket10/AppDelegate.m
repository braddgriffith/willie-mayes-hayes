
//
//  AppDelegate.m
//  Bucket10
//
//  Created by Brad Grifffith on 12/1/12.
//  Copyright (c) 2012 Brad Grifffith. All rights reserved.
//

#import "AppDelegate.h"
#import "UAirship.h"
#import "UAPush.h"
#import "WelcomeViewController.h"
#import "TableListingViewController.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //Init Airship launch options
    NSMutableDictionary *takeOffOptions = [[NSMutableDictionary alloc] init];
    [takeOffOptions setValue:launchOptions forKey:UAirshipTakeOffOptionsLaunchOptionsKey];
    
    [[UIBarButtonItem appearance] setTintColor:[UIColor blackColor]];
    NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
    NSString *defaultEmail = [currentDefaults objectForKey:@"email"];
 
    if (defaultEmail) {
        NSLog(@"defaultEmail exists and it's %@", defaultEmail);
        UIStoryboard *storybord = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
        TableListingViewController *vc =[storybord instantiateViewControllerWithIdentifier:@"TableListingViewController"];
        UINavigationController *rootController = [[UINavigationController alloc] initWithRootViewController:vc];
        [[self window] setRootViewController:rootController];
    } else {
        NSLog(@"defaultEmail No Existe");
    }

    self.networkEngine = [[MKNetworkEngine alloc] initWithHostName:@"mighty-cove-2042.herokuapp.com"];
    self.passKitHelper = [[PassKitHelper alloc] init];

    // Create Airship singleton that's used to talk to Urban Airship servers.
    // Please populate AirshipConfig.plist with your info from http://go.urbanairship.com
    [UAirship takeOff:takeOffOptions];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    // Override point for customization after application launch.
    return YES;
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [[UAPush shared] resetBadge];//zero badge
    [self notificationAlert:userInfo];
}

- (NSString*)notificationAlert:(NSDictionary*)userInfo
{
    if ([userInfo objectForKey:@"meta"])
    {
        NSDictionary *meta = [userInfo objectForKey:@"meta"];
        if (meta)
        {
            self.passKitHelper.viewController = self.window.rootViewController;
            NSString *title = [meta objectForKey:@"title"];
            NSString *url = [meta objectForKey:@"url"];
            [self.passKitHelper openPassFile:url];
        }
    }
    return nil;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    UINavigationController *viewController = self.window.rootViewController;
    if ([viewController isMemberOfClass:[UINavigationController class]])
    {
        WelcomeViewController *welcomeVc = viewController.topViewController;
        if ([welcomeVc isMemberOfClass:[WelcomeViewController class]])
        {
            [welcomeVc drawBeeAnimation];
        }
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    NSLog(@"sdfsadf");
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [UAirship land];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // Updates the device token and registers the token with UA
    [[UAPush shared] registerDeviceToken:deviceToken];
    NSString *token = [UAirship shared].deviceToken;
    [self pushTokenToServer];
    
    NSLog(@"device token:%@", token);
}

-(void)pushTokenToServer
{
    NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
    NSString *defaultEmail = [currentDefaults objectForKey:@"email"];
    if (!defaultEmail || ![UAirship shared].deviceToken) return;
    MKNetworkOperation *op = [ApplicationDelegate.networkEngine operationWithPath:[NSString stringWithFormat:@"pushtoken/%@?email=%@",[UAirship shared].deviceToken,defaultEmail]];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSLog(@"success");
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"we had an error");
    }];
    [ApplicationDelegate.networkEngine enqueueOperation:op];
    
}

@end
