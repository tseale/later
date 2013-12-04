//
//  LaterSideMenuViewController.h
//  Later
//
//  Created by Taylor Seale on 12/2/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LaterSideMenuViewController : UIViewController

@property (nonatomic, assign) BOOL hideStatusBar;

@property (nonatomic,strong) UIView* messageInfo;
@property (nonatomic,strong) UIView* facebookInfo;
@property (nonatomic,strong) UIView* twitterInfo;

@end
