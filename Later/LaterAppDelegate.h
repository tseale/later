//
//  LaterAppDelegate.h
//  Later
//
//  Created by Taylor Seale on 11/4/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LaterViewController.h"
#import "LaterSideMenuViewController.h"

@interface LaterAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) IIViewDeckController* viewDeckController;

@property (strong, nonatomic) LaterViewController* centerViewController;
@property (strong, nonatomic) LaterSideMenuViewController* sideMenuController;

@end
