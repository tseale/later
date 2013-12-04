//
//  LaterBottomBar.h
//  Later
//
//  Created by Taylor Seale on 11/26/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ILTranslucentView.h"

@interface LaterBottomBar : UIView

@property (nonatomic,strong) ILTranslucentView* background;
@property (nonatomic,strong) UIScrollView* titleScroll;

@property (nonatomic,strong) UILabel* selectButton;
@property (nonatomic,strong) UILabel* actionButton;

@end
