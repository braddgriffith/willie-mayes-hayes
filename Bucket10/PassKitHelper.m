//
//  PassKitHelper.m
//  Bucket10
//
//  Created by Brad Grifffith on 12/2/12.
//  Copyright (c) 2012 Brad Grifffith. All rights reserved.
//

#import "PassKitHelper.h"

@interface PassKitHelper ()
{
    NSMutableData *fileData;
	NSURLConnection *connectionInProgress;
}

@end

@implementation PassKitHelper

-(void)openPassFile:(NSString*)urlStr
{
    NSURL *url = [NSURL URLWithString:urlStr];
	NSURLRequest *request = [NSURLRequest requestWithURL:url
											 cachePolicy:NSURLRequestReloadIgnoringCacheData
										 timeoutInterval:30];
    
	//Clear any existing connection if there is one
	if (connectionInProgress)
	{
		[connectionInProgress cancel];
	}
    
	fileData = [[NSMutableData alloc] init];
    
	connectionInProgress = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [fileData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"Got file from URL");
    
    //4
    NSError* error = nil;
    PKPass *newPass = [[PKPass alloc] initWithData:fileData
                                             error:&error];
    //5
    if (error!=nil) {
        [[[UIAlertView alloc] initWithTitle:@"Passes error"
                                    message:[error
                                             localizedDescription]
                                   delegate:nil
                          cancelButtonTitle:@"Ooops"
                          otherButtonTitles: nil] show];
        return;
    }
    
    //6
    PKAddPassesViewController *addController =
    [[PKAddPassesViewController alloc] initWithPass:newPass];
    
    addController.delegate = self;
    [self.viewController presentViewController:addController
                       animated:YES
                     completion:nil];
    
    //RELEASE CONECTION
    if (connectionInProgress)
    {
        connectionInProgress = nil;
    } 
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    connectionInProgress = nil;
    fileData = nil;
    
    NSLog(@"Get file from URL failed");
}

@end
