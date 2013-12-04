//
//  LaterViewController.h
//  Later
//
//  Created by Taylor Seale on 11/4/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LaterTopBar.h"
#import "LaterTableView.h"
#import "LaterComposeView.h"
#import "LaterBottomBar.h"

@interface LaterViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView* tutorial;
@property (nonatomic,strong) UIToolbar* tutorialBackground;
@property (nonatomic,strong) UIPageControl* tutorialPager;

@property (nonatomic,strong) LaterTopBar* topBar;
@property (nonatomic,strong) UIScrollView* pageScroll;
@property (nonatomic,strong) LaterTableView* trashTable;
@property (nonatomic,strong) LaterTableView* pendingTable;
@property (nonatomic,strong) LaterTableView* sentTable;
@property (nonatomic,strong) LaterComposeView* composer;
@property (nonatomic,strong) LaterBottomBar* bottomBar;

@property (nonatomic,strong) UILabel* trashEmpty;
@property (nonatomic,strong) UILabel* pendingEmpty;
@property (nonatomic,strong) UILabel* sentEmpty;

@property (nonatomic,assign) NSIndexPath* selectedCell;

@property (nonatomic, assign) BOOL hideStatusBar;

@property (nonatomic,strong) NSMutableArray* messages;

-(void)emptyTrash;
-(void)clearSent;
@end
