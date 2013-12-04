//
//  LaterTopBar.h
//  Later
//
//  Created by Taylor Seale on 11/4/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ILTranslucentView.h"

@interface LaterTopBar : UIView

@property (nonatomic,strong) ILTranslucentView* background;
@property (nonatomic,strong) UISegmentedControl* pageSelector;
@property (nonatomic,strong) UIImageView* sideMenuToggle;
@property (nonatomic,strong) UIImageView* composeButton;

@property (nonatomic,strong) UILabel* cancelButton;
@property (nonatomic,strong) UILabel* composeLable;
@property (nonatomic,strong) UILabel* doneButton;

@property (nonatomic,assign) BOOL isEdit;

@end
