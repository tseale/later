//
//  LaterViewController.m
//  Later
//
//  Created by Taylor Seale on 11/4/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import "LaterViewController.h"
#import "LaterCell.h"
#import "LaterMessageData.h"

@interface LaterViewController ()

@end

@implementation LaterViewController

- (void)viewDidLoad
{
	 _hideStatusBar = NO;
	[self.view setUserInteractionEnabled:YES];
	//[self.view setBackgroundColor:[UIColor colorWithRed:0.78f green:0.78f blue:0.80f alpha:1.00f]];
    [super viewDidLoad];
	
	_composer = [[LaterComposeView alloc] initWithFrame:CGRectMake(0, TOP_BAR_HEIGHT, self.view.frame.size.width, 288)];
	[_composer setUserInteractionEnabled:YES];
	[self.view addSubview:_composer];
	
	_pageScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, TOP_BAR_HEIGHT, self.view.frame.size.width, self.view.frame.size.height-TOP_BAR_HEIGHT-BOTTOM_BAR_HEIGHT)];
	[_pageScroll setBackgroundColor:[UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f]];
	[_pageScroll setScrollEnabled:NO];
	[_pageScroll setUserInteractionEnabled:YES];
	
	_trashTable = [[LaterTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-TOP_BAR_HEIGHT-BOTTOM_BAR_HEIGHT)];
	[_trashTable setDelegate:self];
	[_trashTable setDataSource:self];
	[_trashTable setDirectionalLockEnabled:YES];
	[_trashTable setBackgroundColor:[UIColor clearColor]];
	[_pageScroll addSubview:_trashTable];
	
	_pendingTable = [[LaterTableView alloc] initWithFrame:CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height-TOP_BAR_HEIGHT-BOTTOM_BAR_HEIGHT)];
	[_pendingTable setDelegate:self];
	[_pendingTable setDataSource:self];
	[_pendingTable setDirectionalLockEnabled:YES];
	[_pendingTable setBackgroundColor:[UIColor clearColor]];
	[_pageScroll addSubview:_pendingTable];
	
	_sentTable = [[LaterTableView alloc] initWithFrame:CGRectMake(2*self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height-TOP_BAR_HEIGHT-BOTTOM_BAR_HEIGHT)];
	[_sentTable setDelegate:self];
	[_sentTable setDataSource:self];
	[_sentTable setDirectionalLockEnabled:YES];
	[_sentTable setBackgroundColor:[UIColor clearColor]];
	[_pageScroll addSubview:_sentTable];
	
	[_pageScroll setContentSize:CGSizeMake(3*self.view.frame.size.width, self.view.frame.size.height)];
	[_pageScroll setContentOffset:CGPointMake(self.view.frame.size.width, 0)];
	[self.view addSubview:_pageScroll];
	
	_topBar = [[LaterTopBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, TOP_BAR_HEIGHT)];
	[self.view addSubview:_topBar];
	
	_bottomBar = [[LaterBottomBar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-BOTTOM_BAR_HEIGHT, self.view.frame.size.width, BOTTOM_BAR_HEIGHT)];
	[self.view addSubview:_bottomBar];
	
	_tutorialBackground = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
	[_tutorialBackground setBarStyle:UIBarStyleBlackTranslucent];
	[self.view addSubview:_tutorialBackground];
	
	_tutorial = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
	[_tutorial setBackgroundColor:[UIColor clearColor]];
	[_tutorial setDelegate:self];
	[_tutorial setUserInteractionEnabled:YES];
	[_tutorial setPagingEnabled:YES];
	[_tutorial setShowsHorizontalScrollIndicator:NO];
	[_tutorial setShowsVerticalScrollIndicator:NO];
	
	_tutorialPager = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-100, self.view.frame.size.width, 100)];
	[_tutorialPager setTintColor:[UIColor whiteColor]];
	_tutorialPager.numberOfPages = 4;
    _tutorialPager.currentPage = 0;
	[self.view addSubview:_tutorialPager];
	
	UIView* slide1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
	UILabel* welcome = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-140, self.view.frame.size.height/2-100,280,100)];
	[welcome setText:@"Welcome to Later"];
	[welcome setTextAlignment:NSTextAlignmentCenter];
	[welcome setTextColor:[UIColor whiteColor]];
	[welcome setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:28]];
	[slide1 addSubview:welcome];
	UILabel* slogan = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-140, self.view.frame.size.height/2-200,280,400)];
	[slogan setText:@"Because you don't always want to send it now..."];
	[slogan setTextAlignment:NSTextAlignmentCenter];
	[slogan setLineBreakMode:NSLineBreakByWordWrapping];
	[slogan setNumberOfLines:5];
	[slogan setTextColor:[UIColor whiteColor]];
	[slogan setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18]];
	[slide1 addSubview:slogan];
	[_tutorial addSubview:slide1];
	
	UIView* slide2 = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height)];
	UILabel* slide2Message = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-140, self.view.frame.size.height/2-110,280,100)];
	[slide2Message setText:@"Later has three sections"];
	[slide2Message setTextAlignment:NSTextAlignmentCenter];
	[slide2Message setTextColor:[UIColor whiteColor]];
	[slide2Message setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:20]];
	[slide2 addSubview:slide2Message];
	
	UIImageView* trashImage = [[UIImageView alloc] initWithFrame:CGRectMake(50, self.view.frame.size.height/2-15, 30, 30)];
	[trashImage setImage:[UIImage imageNamed:@"711-trash-red@2x.png"]];
	trashImage.contentMode = UIViewContentModeScaleAspectFit;
	[slide2 addSubview:trashImage];
	
	UIImageView* pendingImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-15, self.view.frame.size.height/2-15, 30, 30)];
	[pendingImage setImage:[UIImage imageNamed:@"728-clock-blue@2x.png"]];
	pendingImage.contentMode = UIViewContentModeScaleAspectFit;
	[slide2 addSubview:pendingImage];
	
	UIImageView* sentImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-80, self.view.frame.size.height/2-15, 30, 30)];
	[sentImage setImage:[UIImage imageNamed:@"757-paper-airplane-green@2x.png"]];
	sentImage.contentMode = UIViewContentModeScaleAspectFit;
	[slide2 addSubview:sentImage];
	
	UILabel* slide2Message2 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-140, self.view.frame.size.height/2,280,100)];
	[slide2Message2 setText:@"Trash       Pending       Sent"];
	[slide2Message2 setTextAlignment:NSTextAlignmentCenter];
	[slide2Message2 setTextColor:[UIColor whiteColor]];
	[slide2Message2 setFont:[UIFont fontWithName:@"HelveticaNeue" size:20]];
	[slide2 addSubview:slide2Message2];
	[_tutorial addSubview:slide2];
	
	UIView* slide3 = [[UIView alloc] initWithFrame:CGRectMake(2*self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height)];
	UILabel* slide3Message = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-140, self.view.frame.size.height/2-400,280,400)];
	[slide3Message setText:@"Swipe messages left or right to move them between sections"];
	[slide3Message setTextAlignment:NSTextAlignmentCenter];
	[slide3Message setLineBreakMode:NSLineBreakByWordWrapping];
	[slide3Message setNumberOfLines:5];
	[slide3Message setTextColor:[UIColor whiteColor]];
	[slide3Message setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:20]];
	[slide3 addSubview:slide3Message];
	
	UIImageView* swipeScreenshot = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-80, self.view.frame.size.height/2-142, 160, 284)];
	[swipeScreenshot setImage:[UIImage imageNamed:@"tutorial_screenshot.png"]];
	swipeScreenshot.contentMode = UIViewContentModeScaleAspectFit;
	[slide3 addSubview:swipeScreenshot];
	[_tutorial addSubview:slide3];
	
	UIView* slide4 = [[UIView alloc] initWithFrame:CGRectMake(3*self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height)];
	UILabel* slide4Message = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-140, self.view.frame.size.height/2-300,280,400)];
	[slide4Message setText:@"Start setting up some messages!"];
	[slide4Message setTextAlignment:NSTextAlignmentCenter];
	[slide4Message setLineBreakMode:NSLineBreakByWordWrapping];
	[slide4Message setNumberOfLines:5];
	[slide4Message setTextColor:[UIColor whiteColor]];
	[slide4Message setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:20]];
	[slide4 addSubview:slide4Message];
	UILabel* getStarted = [[UILabel alloc] initWithFrame:CGRectMake(60, self.view.frame.size.height/2, 200, 75)];
	[getStarted setText:@"Get Started"];
	[getStarted setTextColor:[UIColor whiteColor]];
	[getStarted setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:24]];
	[getStarted setTextAlignment:NSTextAlignmentCenter];
	[getStarted setBackgroundColor:BLUE_COLOR];
	[getStarted setUserInteractionEnabled:YES];
	getStarted.layer.cornerRadius=3;
	UITapGestureRecognizer* exitTutorial = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(exitTutorial:)];
	[getStarted addGestureRecognizer:exitTutorial];
	[slide4 addSubview:getStarted];
	[_tutorial addSubview:slide4];
	
	[_tutorial setContentSize:CGSizeMake(4*self.view.frame.size.width, self.view.frame.size.height)];
	[self.view addSubview:_tutorial];
	
	_trashEmpty = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-100, self.view.frame.size.height/2-200, 200, 200)];
	[_trashEmpty setText:@"no messages in trash"];
	[_trashEmpty setTextAlignment:NSTextAlignmentCenter];
	[_trashEmpty setTextColor:[UIColor colorWithRed:0.76f green:0.76f blue:0.76f alpha:1.00f]];
	[_trashTable addSubview:_trashEmpty];
	
	_pendingEmpty = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-100, self.view.frame.size.height/2-200, 200, 200)];
	[_pendingEmpty setText:@"no pending messages"];
	[_pendingEmpty setTextAlignment:NSTextAlignmentCenter];
	[_pendingEmpty setTextColor:[UIColor colorWithRed:0.76f green:0.76f blue:0.76f alpha:1.00f]];
	[_pendingTable addSubview:_pendingEmpty];
	
	_sentEmpty = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-100, self.view.frame.size.height/2-200, 200, 200)];
	[_sentEmpty setText:@"no sent messages"];
	[_sentEmpty setTextAlignment:NSTextAlignmentCenter];
	[_sentEmpty setTextColor:[UIColor colorWithRed:0.76f green:0.76f blue:0.76f alpha:1.00f]];
	[_sentTable addSubview:_sentEmpty];
	
	[self checkEmptyTables];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(composeNew)
												 name:@"composeNew"
											   object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(composeCancel)
												 name:@"composeCancel"
											   object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(editDone)
												 name:@"editDoneConfirm"
											   object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(composeDone)
												 name:@"composeDoneConfirm"
											   object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(swapPage:)
												 name:@"swapPage"
											   object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(moveCell:)
												 name:@"moveCell"
											   object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(toggleSideMenu)
												 name:@"toggleSideMenu"
											   object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(editCell:)
												 name:@"editCell"
											   object:nil];

	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(emptyTrash)
												 name:@"emptyTrash"
											   object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(clearSent)
												 name:@"clearSent"
											   object:nil];

}

-(void)checkEmptyTables
{
	[_trashEmpty setHidden:NO];
	for (NSMutableArray* messages in TRASH_MESSAGES){
		if (messages.count!=0){
			[_trashEmpty setHidden:YES];
		}
	}
	
	[_pendingEmpty setHidden:NO];
	for (NSMutableArray* messages in PENDING_MESSAGES){
		if (messages.count!=0){
			[_pendingEmpty setHidden:YES];
		}
	}
	
	[_sentEmpty setHidden:NO];
	for (NSMutableArray* messages in SENT_MESSAGES){
		if (messages.count!=0){
			[_sentEmpty setHidden:YES];
		}
	}

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = _tutorial.frame.size.width;
    float fractionalPage = _tutorial.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    _tutorialPager.currentPage = page;
}

-(void)exitTutorial:(UITapGestureRecognizer*)recognizer
{
	[_tutorial removeFromSuperview];
	[_tutorialBackground removeFromSuperview];
	[_tutorialPager removeFromSuperview];
}

-(void)editCell:(NSNotification*)notification
{
	[_composer.recipient setText:[notification.userInfo objectForKey:@"recipient"]];
	[_composer.timeToSend setText:[notification.userInfo objectForKey:@"date"]];
	[_composer.messageContent setText:[notification.userInfo objectForKey:@"message"]];
	[_composer setType:[[notification.userInfo objectForKey:@"type"] intValue]];
	[_composer setEditCellPath:[notification.userInfo objectForKey:@"index"]];
	[self composeEdit];
}

- (UIView *)getSnapShot
{
    return [[UIScreen mainScreen] snapshotViewAfterScreenUpdates:NO];
}

-(void)toggleSideMenu
{
	[self.viewDeckController toggleLeftViewAnimated:YES];
}

- (BOOL)prefersStatusBarHidden
{
    return _hideStatusBar;
}

-(void)emptyTrash
{
	NSArray* trashCells = [_trashTable visibleCells];
	float delay=0.0;
	UIView* lastView = [trashCells lastObject];
	[[[MESSAGE_DATA objectForKey:@"trash"]  objectAtIndex:0] removeAllObjects];
	[[[MESSAGE_DATA objectForKey:@"trash"]  objectAtIndex:1] removeAllObjects];
	[[[MESSAGE_DATA objectForKey:@"trash"]  objectAtIndex:2] removeAllObjects];
	for (LaterCell* cell in trashCells){
				[UIView animateWithDuration:0.3
									  delay:delay
									options:UIViewAnimationOptionCurveEaseInOut
								 animations:^{
									 cell.frame = CGRectOffset(cell.frame, -320, 0);
								 }
								 completion:^(BOOL finished){
									 if ([cell isEqual:lastView]){
										 [_trashTable reloadData];
										 [self checkEmptyTables];
									 }
								 }];
				delay+=0.03;
	}
}

-(void)clearSent
{
	NSArray* sentCells = [_sentTable visibleCells];
	float delay=0.0;
	UIView* lastView = [sentCells lastObject];
	[[[MESSAGE_DATA objectForKey:@"sent"]  objectAtIndex:0] removeAllObjects];
	[[[MESSAGE_DATA objectForKey:@"sent"]  objectAtIndex:1] removeAllObjects];
	[[[MESSAGE_DATA objectForKey:@"sent"]  objectAtIndex:2] removeAllObjects];
	for (LaterCell* cell in sentCells){
		[UIView animateWithDuration:0.3
							  delay:delay
							options:UIViewAnimationOptionCurveEaseInOut
						 animations:^{
							 cell.frame = CGRectOffset(cell.frame, 320, 0);
						 }
						 completion:^(BOOL finished){
							 if ([cell isEqual:lastView]){
								 [_sentTable reloadData];
								 [self checkEmptyTables];
							 }
						 }];
		delay+=0.03;
	}
}

-(void)composeNew
{
	[_topBar.pageSelector setHidden:YES];
	[_topBar.sideMenuToggle setHidden:YES];
	[_topBar.composeButton setHidden:YES];
	[_topBar.cancelButton setHidden:NO];
	[_topBar.composeLable setHidden:NO];
	[_topBar.doneButton setHidden:NO];
	[_topBar.composeLable setText:@"Compose New"];
	[_topBar setIsEdit:NO];
	
	[_composer.messageContent becomeFirstResponder];
	[_pendingTable setUserInteractionEnabled:NO];
	[_composer setupViews];
	CGRect tableFrame = _pageScroll.frame;
	tableFrame.origin.y=288+TOP_BAR_HEIGHT;
	[UIView animateWithDuration:0.25f
						  delay:0.0f
						options:UIViewAnimationOptionCurveEaseIn
					 animations:^{
						 _pageScroll.frame=tableFrame;
					 }
					 completion:^(BOOL finished){
						 [_composer checkFormCompletion];
					 }
	 ];
}

-(void)composeEdit
{
	[_topBar.pageSelector setSelectedSegmentIndex:1];
	[_topBar.pageSelector setTintColor:BLUE_COLOR];
	[_topBar.composeButton setImage:[UIImage imageNamed:@"compose-blue@2x.png"]];
	[_topBar.sideMenuToggle setImage:[UIImage imageNamed:@"menu-blue@2x.png"]];
	[_topBar.pageSelector setHidden:YES];
	[_topBar.sideMenuToggle setHidden:YES];
	[_topBar.composeButton setHidden:YES];
	[_topBar.cancelButton setHidden:NO];
	[_topBar.composeLable setHidden:NO];
	[_topBar.doneButton setHidden:NO];
	[_topBar.composeLable setText:@"Edit"];
	[_topBar setIsEdit:YES];
	
	[_composer.messageContent becomeFirstResponder];
	[_composer setupViews];
	[_pendingTable setUserInteractionEnabled:NO];
	CGRect tableFrame = _pageScroll.frame;
	tableFrame.origin.y=288+TOP_BAR_HEIGHT;
	[UIView animateWithDuration:0.25f
						  delay:0.0f
						options:UIViewAnimationOptionCurveEaseIn
					 animations:^{
						 _pageScroll.frame=tableFrame;
					 }
					 completion:^(BOOL finished){
						 [_composer checkFormCompletion];
					 }
	 ];
}

-(void)composeCancel
{
	CGRect tableFrame = _pageScroll.frame;
	tableFrame.origin.y=TOP_BAR_HEIGHT;
	[UIView animateWithDuration:0.25f
						  delay:0.0
						options:UIViewAnimationOptionCurveEaseIn
					 animations:^{
						 _pageScroll.frame=tableFrame;
					 }
					 completion:^(BOOL finished){
						 [_pendingTable setUserInteractionEnabled:YES];
						 [_topBar.pageSelector setHidden:NO];
						 [_topBar.sideMenuToggle setHidden:NO];
						 [_topBar.composeButton setHidden:NO];
						 [_topBar.cancelButton setHidden:YES];
						 [_topBar.composeLable setHidden:YES];
						 [_topBar.doneButton setHidden:YES];
					 }
	 ];
	[_composer.recipient setFrame:CGRectMake(10, 10, 300, 36)];
	[_composer.messageContent setFrame:CGRectMake(10, 56, 300, 160)];
}

-(void)editDone
{
	[self composeCancel];
	[self checkEmptyTables];
	[_pendingTable reloadData];
}

-(void)composeDone
{
	[_pageScroll setContentOffset:CGPointMake(self.view.frame.size.width, 0) animated:NO];
	[_topBar.pageSelector setSelectedSegmentIndex:1];
	[_topBar.pageSelector setTintColor:BLUE_COLOR];
	[_topBar.composeButton setImage:[UIImage imageNamed:@"compose-blue@2x.png"]];
	[_topBar.sideMenuToggle setImage:[UIImage imageNamed:@"menu-blue@2x.png"]];
	[self composeCancel];
	[self checkEmptyTables];
	[_pendingTable reloadData];
}

-(void)swapPage:(NSNotification*)notification
{
	[[NSNotificationCenter defaultCenter]
	 postNotificationName:@"adjustTitle"
	 object:self
	 userInfo:notification.userInfo];
	switch ([[notification.userInfo objectForKey:@"page"] integerValue]) {
		case 0:
			[_pageScroll setContentOffset:CGPointMake(0, 0) animated:YES];
			break;
		case 1:
			[_pageScroll setContentOffset:CGPointMake(self.view.frame.size.width, 0) animated:YES];
			break;
		case 2:
			[_pageScroll setContentOffset:CGPointMake(2*self.view.frame.size.width, 0) animated:YES];
			break;
		default:
			break;
	}
	[_trashTable reloadData];
	[_pendingTable reloadData];
	[_sentTable reloadData];
	[self checkEmptyTables];
}

-(void)moveCell:(NSNotification*)notification
{
	NSArray* cell_info = [notification.userInfo objectForKey:@"cell_info"];
	NSInteger current_table = [[cell_info objectAtIndex:0] integerValue];
	NSInteger new_table = [[cell_info objectAtIndex:1] integerValue];
	NSIndexPath* cell_path = [cell_info objectAtIndex:2];
	
	LaterMessageData* cell_data = [[[MESSAGE_DATA objectForKey:[self returnKey:current_table]] objectAtIndex:cell_path.section] objectAtIndex:cell_path.row];
	[cell_data setStatus:(int)new_table];
	NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
	switch (new_table) {
		case 0:
			[cell_data setStatusText:@"Deleted"];
			break;
		case 1:
			// this code sucks ass
			[DateFormatter setDateFormat:@"EEEE, MMM d @ h:mm a"];
			[cell_data setStatusText:[DateFormatter stringFromDate:cell_data.sendTime]];
			break;
		case 2:
		{
			[DateFormatter setDateFormat:@"EEE h:mm a"];
			NSString* current_time = [NSString stringWithFormat:@"Sent: %@",[DateFormatter stringFromDate:[NSDate date]]];
			[cell_data setStatusText:current_time];
		}
			break;
		default:
			break;
	}
	[cell_data setStatus:(int)new_table];
	[[[MESSAGE_DATA objectForKey:[self returnKey:current_table]] objectAtIndex:cell_path.section] removeObjectAtIndex:cell_path.row];
	[[[MESSAGE_DATA objectForKey:[self returnKey:new_table]] objectAtIndex:cell_path.section] addObject:cell_data];
	
	switch (current_table) {
		case 0:
			[self adjustTable:_trashTable atCell:[cell_info objectAtIndex:2] withMovement:-CELL_HEIGHT hideCell:YES];
			break;
		case 1:
			[self adjustTable:_pendingTable atCell:[cell_info objectAtIndex:2] withMovement:-CELL_HEIGHT hideCell:YES];
			break;
		case 2:
			[self adjustTable:_sentTable atCell:[cell_info objectAtIndex:2] withMovement:-CELL_HEIGHT hideCell:YES];
			break;
		default:
			break;
	}
}

-(void)adjustTable:(LaterTableView*)tableView
			atCell:(NSIndexPath*)cell_path
	  withMovement:(CGFloat)movement
		  hideCell:(BOOL)hide;
{
	[tableView setUserInteractionEnabled:NO];
	float delay = 0.0;

	// find the visible cells
    NSArray* visibleCells = [tableView visibleCells];
	
    UIView* lastView = [visibleCells lastObject];
    bool startAnimating = false;
	
	LaterCell* selectedCell = (LaterCell*)[tableView cellForRowAtIndexPath:cell_path];
    // iterate over all of the cells
    for(LaterCell* cell in visibleCells) {
        if (startAnimating) {
            [UIView animateWithDuration:0.3
                                  delay:delay
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 cell.frame = CGRectOffset(cell.frame, 0.0f, movement);
                             }
                             completion:^(BOOL finished){
                                 if (cell == lastView) {
                                     [tableView reloadData];
                                 }
                             }];
            delay+=0.03;
        }
		
        // if you have reached the item that was deleted, start animating
        if ([cell isEqual:selectedCell]) {
            startAnimating = true;
            cell.hidden = hide;
        }
    }
	[self checkEmptyTables];
	[tableView setUserInteractionEnabled:YES];
}

/*
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if ([_selectedCell isEqual:indexPath]){
		[[NSNotificationCenter defaultCenter]
		 postNotificationName:@"cellTap"
		 object:self];
	}else{
		_selectedCell = indexPath;
	}
	[tableView reloadData];
	LaterCell *cell = (LaterCell *)[tableView cellForRowAtIndexPath:indexPath];
	[cell selected];
}
*/

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	CGFloat cell_height = CELL_HEIGHT;
	if ([indexPath isEqual:_selectedCell]){
		cell_height = CELL_HEIGHT+50;
	}
    return cell_height;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSString*)returnKey:(NSInteger)section
{
	NSString *key;
	switch (section) {
		case 0:
			key=@"trash";
			break;
		case 1:
			key=@"pending";
			break;
		case 2:
			key=@"sent";
			break;
		default:
			break;
	}
	return key;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSInteger count = 0;
	if ([tableView isEqual:_trashTable])
	{
		count=[[TRASH_MESSAGES objectAtIndex:section] count];
	}
	else if ([tableView isEqual:_pendingTable])
	{
		count=[[PENDING_MESSAGES objectAtIndex:section] count];
	}
	else if ([tableView isEqual:_sentTable])
	{
		count=[[SENT_MESSAGES objectAtIndex:section] count];
	}
    return count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	LaterMessageData* data = [[LaterMessageData alloc] init];
	if ([tableView isEqual:_trashTable])
	{
		[[[TRASH_MESSAGES objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] setRow:(int)indexPath.row];
		[[[TRASH_MESSAGES objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] setSection:(int)indexPath.section];
		data = [[TRASH_MESSAGES objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	}
	else if ([tableView isEqual:_pendingTable])
	{
		[[[PENDING_MESSAGES objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] setRow:(int)indexPath.row];
		[[[PENDING_MESSAGES objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] setSection:(int)indexPath.section];
		data = [[PENDING_MESSAGES objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	}
	else if ([tableView isEqual:_sentTable])
	{
		[[[SENT_MESSAGES objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] setRow:(int)indexPath.row];
		[[[SENT_MESSAGES objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] setSection:(int)indexPath.section];
		data = [[SENT_MESSAGES objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	}
	
	LaterCell* cell = [[LaterCell alloc] init];
	cell = nil;
	if (cell == nil)
	{
		cell = [[LaterCell alloc] initWithData:data];
	}
	return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
