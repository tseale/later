//
//  LaterTopBar.m
//  Later
//
//  Created by Taylor Seale on 11/4/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import "LaterTopBar.h"

@interface LaterTopBar ()

@end

@implementation LaterTopBar

-(id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		
		_isEdit=NO;
		[self setBackgroundColor:[UIColor colorWithRed:0.97f green:0.97f blue:0.97f alpha:1.00f]];
		[self setUserInteractionEnabled:YES];
		
		_cancelButton = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 100, 24)];
		[_cancelButton setBackgroundColor:[UIColor clearColor]];
		[_cancelButton setText:@"cancel"];
		[_cancelButton setTextColor:RED_COLOR];
		[_cancelButton setUserInteractionEnabled:YES];
		UITapGestureRecognizer* composeCancel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelPress:)];
		[composeCancel setNumberOfTapsRequired:1];
		[_cancelButton addGestureRecognizer:composeCancel];
		[self addSubview:_cancelButton];
		
		_composeLable = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2-100, 28, 200, 30)];
		[_composeLable setText:@"Compose New"];
		[_composeLable setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16]];
		[_composeLable setTextAlignment:NSTextAlignmentCenter];
		[self addSubview:_composeLable];
		
		_doneButton = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-110, 30, 100, 24)];
		[_doneButton setText:@"done"];
		[_doneButton setTextColor:[UIColor colorWithRed:0.58f green:0.57f blue:0.59f alpha:1.00f]];
		[_doneButton setTextAlignment:NSTextAlignmentRight];
		[_doneButton setUserInteractionEnabled:NO];
		UITapGestureRecognizer* composeDone = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(donePress:)];
		[composeDone setNumberOfTapsRequired:1];
		[_doneButton addGestureRecognizer:composeDone];
		[self addSubview:_doneButton];
		
		[_cancelButton setHidden:YES];
		[_composeLable setHidden:YES];
		[_doneButton setHidden:YES];
		
		_sideMenuToggle = [[UIImageView alloc] initWithFrame:CGRectMake(15, 30, 24,24)];
		[_sideMenuToggle setBackgroundColor:[UIColor clearColor]];
		[_sideMenuToggle setImage:[UIImage imageNamed:@"menu-blue@2x.png"]];
		_sideMenuToggle.contentMode = UIViewContentModeScaleAspectFit;
		[_sideMenuToggle setUserInteractionEnabled:YES];
		UITapGestureRecognizer* sideMenu = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sideMenu:)];
		[sideMenu setNumberOfTapsRequired:1];
		[_sideMenuToggle addGestureRecognizer:sideMenu];
		[self addSubview:_sideMenuToggle];
		
		_composeButton = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-34, 30, 24,24)];
		[_composeButton setImage:[UIImage imageNamed:@"compose-blue@2x.png"]];
		_composeButton.contentMode = UIViewContentModeScaleAspectFit;
		[_composeButton setUserInteractionEnabled:YES];
		UITapGestureRecognizer* composePress = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(composePress:)];
		[composePress setNumberOfTapsRequired:1];
		[_composeButton addGestureRecognizer:composePress];
		[self addSubview:_composeButton];
		
		UIImage *trashImage =
		[UIImage imageWithCGImage:[[UIImage imageNamed:@"711-trash@2x.png"] CGImage]
							scale:([UIImage imageNamed:@"711-trash@2x.png"].scale * 3.0)
					  orientation:([UIImage imageNamed:@"711-trash@2x.png"].imageOrientation)];
		
		UIImage *pendingImage =
		[UIImage imageWithCGImage:[[UIImage imageNamed:@"728-clock@2x.png"] CGImage]
							scale:([UIImage imageNamed:@"728-clock@2x.png"].scale * 3.0)
					  orientation:([UIImage imageNamed:@"728-clock@2x.png"].imageOrientation)];
		
		UIImage *sentImage =
		[UIImage imageWithCGImage:[[UIImage imageNamed:@"757-paper-airplane@2x.png"] CGImage]
							scale:([UIImage imageNamed:@"757-paper-airplane@2x.png"].scale * 3.0)
					  orientation:([UIImage imageNamed:@"757-paper-airplane@2x.png"].imageOrientation)];
		
		_pageSelector = [[UISegmentedControl alloc] initWithItems:@[trashImage,pendingImage,sentImage]];
		_pageSelector.frame = CGRectMake(self.frame.size.width/2-100, 28, 200, 30);
		[_pageSelector setBackgroundColor:[UIColor clearColor]];
		[_pageSelector setTintColor:BLUE_COLOR];
		[_pageSelector setSelectedSegmentIndex:1];
		[_pageSelector addTarget:self
							 action:@selector(swapPage:)
				   forControlEvents:UIControlEventValueChanged];
		[self addSubview:_pageSelector];
		
		UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, TOP_BAR_HEIGHT-1, self.frame.size.width, 1)];
		[line1 setBackgroundColor:[UIColor colorWithRed:0.76f green:0.76f blue:0.76f alpha:1.00f]];
		[self addSubview:line1];
		
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(doneButtonActivate)
													 name:@"doneButtonActivate"
												   object:nil];

		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(doneButtonDeactivate)
													 name:@"doneButtonDeactivate"
												   object:nil];
	}
	return self;
}

-(void)sideMenu:(UITapGestureRecognizer*)recognizer
{
	if (recognizer.state == UIGestureRecognizerStateEnded)
	{
		[[NSNotificationCenter defaultCenter]
		 postNotificationName:@"toggleSideMenu"
		 object:self
		 userInfo:nil];
	}
}

-(void)doneButtonActivate
{
	[_doneButton setUserInteractionEnabled:YES];
	[_doneButton setTextColor:GREEN_COLOR];
}

-(void)doneButtonDeactivate
{
	[_doneButton setUserInteractionEnabled:NO];
	[_doneButton setTextColor:[UIColor colorWithRed:0.58f green:0.57f blue:0.59f alpha:1.00f]];
}

-(void)composePress:(UITapGestureRecognizer*)recognizer
{
	if (recognizer.state == UIGestureRecognizerStateEnded)
    {
		[[NSNotificationCenter defaultCenter]
		 postNotificationName:@"composeNew"
		 object:self
		 userInfo:nil];
    }
}

-(void)cancelPress:(UITapGestureRecognizer*)recognizer
{
	if (recognizer.state == UIGestureRecognizerStateEnded)
    {
		[[NSNotificationCenter defaultCenter]
		 postNotificationName:@"composeCancel"
		 object:self
		 userInfo:nil];
    }
}

-(void)donePress:(UITapGestureRecognizer*)recognizer
{
	if (recognizer.state == UIGestureRecognizerStateEnded)
    {
		if (!_isEdit){
			[[NSNotificationCenter defaultCenter]
			 postNotificationName:@"composeDone"
			 object:self
			 userInfo:nil];
		}else{
			[[NSNotificationCenter defaultCenter]
			 postNotificationName:@"editDone"
			 object:self
			 userInfo:nil];
		}
    }
}

-(void)swapPage:(UISegmentedControl*)control
{
	NSMutableDictionary* swapInfo = [[NSMutableDictionary alloc] init];
	switch (control.selectedSegmentIndex) {
		case 0:
			[_pageSelector setTintColor:RED_COLOR];
			[_composeButton setImage:[UIImage imageNamed:@"compose-red@2x.png"]];
			[_sideMenuToggle setImage:[UIImage imageNamed:@"menu-red@2x.png"]];
			[swapInfo setObject:[NSNumber numberWithInt:0] forKey:@"page"];
			break;
		case 1:
			[_pageSelector setTintColor:BLUE_COLOR];
			[_composeButton setImage:[UIImage imageNamed:@"compose-blue@2x.png"]];
			[_sideMenuToggle setImage:[UIImage imageNamed:@"menu-blue@2x.png"]];
			[swapInfo setObject:[NSNumber numberWithInt:1] forKey:@"page"];
			break;
		case 2:
			[_pageSelector setTintColor:GREEN_COLOR];
			[_composeButton setImage:[UIImage imageNamed:@"compose-green@2x.png"]];
			[_sideMenuToggle setImage:[UIImage imageNamed:@"menu-green@2x.png"]];
			[swapInfo setObject:[NSNumber numberWithInt:2] forKey:@"page"];
			break;
		default:
			break;
	}
	[[NSNotificationCenter defaultCenter]
	 postNotificationName:@"swapPage"
	 object:self
	 userInfo:swapInfo];
}

@end
