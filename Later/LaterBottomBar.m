//
//  LaterBottomBar.m
//  Later
//
//  Created by Taylor Seale on 11/26/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import "LaterBottomBar.h"

@implementation LaterBottomBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		[self setBackgroundColor:[UIColor colorWithRed:0.97f green:0.97f blue:0.97f alpha:1.00f]];
		_selectButton = [[UILabel alloc] initWithFrame:CGRectMake(-90, 10, 80, 30)];
		[_selectButton setTextColor:RED_COLOR];
		[_selectButton setText:@"Empty"];
		[_selectButton setUserInteractionEnabled:YES];
		UITapGestureRecognizer* selectTapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectTapped:)];
		[selectTapped setNumberOfTapsRequired:1];
		[selectTapped setNumberOfTouchesRequired:1];
		[_selectButton addGestureRecognizer:selectTapped];
		[self addSubview:_selectButton];
		
		_actionButton = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width+90, 10, 80, 30)];
		[_actionButton setUserInteractionEnabled:YES];
		[_actionButton setTextAlignment:NSTextAlignmentRight];
		[_actionButton setTextColor:GREEN_COLOR];
		[_actionButton setText:@"Clear"];
		UITapGestureRecognizer* actionTapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTapped:)];
		[actionTapped setNumberOfTapsRequired:1];
		[actionTapped setNumberOfTouchesRequired:1];
		[_actionButton addGestureRecognizer:actionTapped];
		[self addSubview:_actionButton];
		
		_titleScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(self.frame.size.width/2-50, 10, 100, 30)];
		[_titleScroll setBackgroundColor:[UIColor clearColor]];
		
		UILabel* trashLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
		[trashLabel setBackgroundColor:[UIColor clearColor]];
		[trashLabel setText:@"Trash"];
		[trashLabel setTextAlignment:NSTextAlignmentCenter];
		[trashLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
		[_titleScroll addSubview:trashLabel];
		
		UILabel* pendingLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 0, 100, 30)];
		[pendingLabel setBackgroundColor:[UIColor clearColor]];
		[pendingLabel setText:@"Pending"];
		[pendingLabel setTextAlignment:NSTextAlignmentCenter];
		[pendingLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
		[_titleScroll addSubview:pendingLabel];
		
		UILabel* sentLabel = [[UILabel alloc] initWithFrame:CGRectMake(400, 0, 100, 30)];
		[sentLabel setBackgroundColor:[UIColor clearColor]];
		[sentLabel setText:@"Sent"];
		[sentLabel setTextAlignment:NSTextAlignmentCenter];
		[sentLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
		[_titleScroll addSubview:sentLabel];
		
		[_titleScroll setContentOffset:CGPointMake(200, 0)];
		[self addSubview:_titleScroll];
		
		UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
		[line1 setBackgroundColor:[UIColor colorWithRed:0.76f green:0.76f blue:0.76f alpha:1.00f]];
		[self addSubview:line1];
		
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(adjustTitle:)
													 name:@"adjustTitle"
												   object:nil];

    }
    return self;
}

-(void)selectTapped:(UITapGestureRecognizer*)recognizer
{
	if (recognizer.state==UIGestureRecognizerStateEnded)
	{
		[[NSNotificationCenter defaultCenter]
		 postNotificationName:@"emptyTrash"
		 object:self
		 userInfo:nil];
	}
}

-(void)actionTapped:(UITapGestureRecognizer*)recognizer
{
	if (recognizer.state==UIGestureRecognizerStateEnded)
	{
		[[NSNotificationCenter defaultCenter]
		 postNotificationName:@"clearSent"
		 object:self
		 userInfo:nil];
	}
}

-(void)adjustTitle:(NSNotification*)notification
{
	switch ([[notification.userInfo objectForKey:@"page"] integerValue]) {
		case 0:
		{
			[_titleScroll setContentOffset:CGPointMake(0, 0) animated:YES];
			CGRect selectFrame = _selectButton.frame;
			CGRect actionFrame = _actionButton.frame;
			selectFrame.origin.x = 10;
			actionFrame.origin.x = 320+10;
			[UIView animateWithDuration:0.3
								  delay:0.0
								options:UIViewAnimationOptionCurveEaseInOut
							 animations:^{
								 _selectButton.frame = selectFrame;
								 _actionButton.frame = actionFrame;
							 }
							 completion:^(BOOL finished){}];
		}
			break;
		case 1:
		{
			[_titleScroll setContentOffset:CGPointMake(200, 0) animated:YES];
			CGRect selectFrame = _selectButton.frame;
			CGRect actionFrame = _actionButton.frame;
			selectFrame.origin.x = -90;
			actionFrame.origin.x = 320+10;
			[UIView animateWithDuration:0.3
								  delay:0.0
								options:UIViewAnimationOptionCurveEaseInOut
							 animations:^{
								 _selectButton.frame = selectFrame;
								 _actionButton.frame = actionFrame;
							 }
							 completion:^(BOOL finished){}];
		}
			break;
		case 2:
		{
			[_titleScroll setContentOffset:CGPointMake(400, 0) animated:YES];
			CGRect selectFrame = _selectButton.frame;
			CGRect actionFrame = _actionButton.frame;
			selectFrame.origin.x = -90;
			actionFrame.origin.x = 320-90;
			[UIView animateWithDuration:0.3
								  delay:0.0
								options:UIViewAnimationOptionCurveEaseInOut
							 animations:^{
								 _selectButton.frame = selectFrame;
								 _actionButton.frame = actionFrame;
							 }
							 completion:^(BOOL finished){}];
		}
			break;
		default:
			break;
	}
}

@end
