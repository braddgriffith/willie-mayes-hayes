//
//  ThanksViewController.h
//  Bucket10
//
//  Created by Brad Grifffith on 12/1/12.
//  Copyright (c) 2012 Brad Grifffith. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThanksViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIButton *startButton;
@property (nonatomic, strong) IBOutlet UIImageView *backgroundImageView;
@property (nonatomic, strong) IBOutlet UIImageView *logoImageView;

+ (UIBarButtonItem *)blackArrowButtonWithTarget:(id)actionTarget andAction:(SEL)buttonAction;
+ (UIBarButtonItem *)greySquareButtonWithTitle:(NSString *)buttonTitle target:(id)actionTarget andAction:(SEL)buttonAction;

@end

