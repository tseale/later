//
//  LaterCell.m
//  Later
//
//  Created by Taylor Seale on 11/4/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import "LaterCell.h"

@implementation LaterCell

-(id)initWithData:(LaterMessageData*)data
{
	self = [super init];
    if (self) {
		_table=data.status;
		_section=data.section;
		_row=data.row;
		_network=data.network;
		_quick_delete=NO;
		_quick_pend=NO;
		_quick_send=NO;
		
		[self setSelectionStyle:UITableViewCellSelectionStyleNone];
		[self setUserInteractionEnabled:YES];
		
		_background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, CELL_HEIGHT+50)];
		[_background setBackgroundColor:[UIColor colorWithRed:0.78f green:0.78f blue:0.80f alpha:1.00f]];
		[self addSubview:_background];
		
		[self setBackgroundColor:[UIColor colorWithRed:0.78f green:0.78f blue:0.80f alpha:1.00f]];
		
		_actionImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 25, 30,30)];
		if (_table==0)
		{
			[_actionImage setImage:[UIImage imageNamed:@"728-clock@2x.png"]];
		}
		else
		{
			[_actionImage setImage:[UIImage imageNamed:@"757-paper-airplane@2x.png"]];
		}
		_actionImage.contentMode = UIViewContentModeScaleAspectFit;
		[self addSubview:_actionImage];
		
		_cellOverlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, CELL_HEIGHT)];
		[_cellOverlay setBackgroundColor:[UIColor whiteColor]];
		[_cellOverlay setUserInteractionEnabled:YES];
		
		_slideCell = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(slideCell:)];
		[_slideCell setMinimumPressDuration:0.1];
		[_slideCell setNumberOfTouchesRequired:1];
		if (_table!=2){
			[_cellOverlay addGestureRecognizer:_slideCell];
		}
		_tapCell = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCell:)];
		[_tapCell setNumberOfTouchesRequired:1];
		[_tapCell setNumberOfTapsRequired:1];
		if (_table==1)
		{
			[_cellOverlay addGestureRecognizer:_tapCell];
		}
		
		_networkImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
		BOOL grayedOut=FALSE;
		if (_table==0 || _table==2)
		{
			grayedOut=TRUE;
		}
		switch (_network) {
			case  0:
				if (grayedOut){
					[_networkImage setImage:[UIImage imageNamed:@"message-circle-logo-gray@2x.png"]];
				}else{
					[_networkImage setImage:[UIImage imageNamed:@"message-circle-logo@2x.png"]];
				}
				_smsRecipient = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, self.frame.size.width-70, 20)];
				[_smsRecipient setText:data.smsRecipient];
				[_smsRecipient setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:14]];
				[_cellOverlay addSubview:_smsRecipient];
				break;
			case  1:
				if (grayedOut){
					[_networkImage setImage:[UIImage imageNamed:@"facebook-circle-logo-gray@2x.png"]];
				}else{
					[_networkImage setImage:[UIImage imageNamed:@"facebook-circle-logo@2x.png"]];
				}
				break;
			case  2:
				if (grayedOut){
					[_networkImage setImage:[UIImage imageNamed:@"twitter-circle-logo-gray@2x.png"]];
				}else{
					[_networkImage setImage:[UIImage imageNamed:@"twitter-circle-logo@2x.png"]];
				}
				break;
			default:
				break;
		}
		[_cellOverlay addSubview:_networkImage];
		
		_messagePreview = [[UILabel alloc] initWithFrame:CGRectMake(60, 30, self.frame.size.width-70, 49)];
		[_messagePreview setText:data.message];
		[_messagePreview setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
		[_messagePreview setTextColor:[UIColor colorWithRed:0.58f green:0.57f blue:0.59f alpha:1.00f]];
		_messagePreview.numberOfLines = 2;
		[_messagePreview sizeToFit];
		[_cellOverlay addSubview:_messagePreview];
		
		_messageStatus = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, self.frame.size.width-70, 20)];
		switch (data.status) {
			case 0:
				[_messageStatus setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12]];
				[_messageStatus setTextColor:RED_COLOR];
				break;
			case 1:
				[_messageStatus setFont:[UIFont fontWithName:@"HelveticaNeue-LightItalic" size:12]];
				[_messageStatus setTextColor:[UIColor colorWithRed:0.58f green:0.57f blue:0.59f alpha:1.00f]];
				break;
			case 2:
				[_messageStatus setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12]];
				[_messageStatus setTextColor:GREEN_COLOR];
				break;
			default:
				break;
		}
		[_messageStatus setText:data.statusText];
		[_messageStatus setTextAlignment:NSTextAlignmentRight];
		[_cellOverlay addSubview:_messageStatus];
		
		[self addSubview:_cellOverlay];
		
		_cellLine = [[UIView alloc] initWithFrame:CGRectMake(0, CELL_HEIGHT-1, self.frame.size.width, 1)];
		[_cellLine setBackgroundColor:[UIColor colorWithRed:0.76f green:0.76f blue:0.76f alpha:1.00f]];
		[self addSubview:_cellLine];
		
		_selectedOptions = [[UIView alloc] initWithFrame:CGRectMake(0, CELL_HEIGHT, self.frame.size.width, 50)];
		[_selectedOptions setUserInteractionEnabled:YES];
		[_selectedOptions setBackgroundColor:[UIColor colorWithRed:0.97f green:0.97f blue:0.97f alpha:1.00f]];
		_trashImage = [[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 30, 30)];
		[_trashImage setUserInteractionEnabled:YES];
		[_trashImage setImage:[UIImage imageNamed:@"711-trash-gray@2x.png"]];
		_trashImage.contentMode = UIViewContentModeScaleAspectFit;
		UILongPressGestureRecognizer* trashCell = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(trashCell:)];
		[trashCell setMinimumPressDuration:0.0];
		[_trashImage addGestureRecognizer:trashCell];
		[_selectedOptions addSubview:_trashImage];
		_editImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width/2-15, 10, 30, 30)];
		[_editImage setUserInteractionEnabled:YES];
		[_editImage setImage:[UIImage imageNamed:@"704-compose-gray@2x.png"]];
		_editImage.contentMode = UIViewContentModeScaleAspectFit;
		[_selectedOptions addSubview:_editImage];
		_sendImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-60, 10, 30, 30)];
		[_sendImage setUserInteractionEnabled:YES];
		[_sendImage setImage:[UIImage imageNamed:@"757-paper-airplane-gray@2x.png"]];
		_sendImage.contentMode = UIViewContentModeScaleAspectFit;
		UILongPressGestureRecognizer* sendCell = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(sendCell:)];
		[sendCell setMinimumPressDuration:0.0];
		[_sendImage addGestureRecognizer:sendCell];
		[_selectedOptions addSubview:_sendImage];
		[self addSubview:_selectedOptions];
		
		UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(0, 49, self.frame.size.width, 1)];
		[line3 setBackgroundColor:[UIColor colorWithRed:0.76f green:0.76f blue:0.76f alpha:1.00f]];
		[_selectedOptions addSubview:line3];
		
	}
	return self;
}

-(void)trashCell:(UILongPressGestureRecognizer*)recognizer
{
	if (recognizer.state == UIGestureRecognizerStateEnded){
		_quick_delete=YES;
		[_background setBackgroundColor:RED_COLOR];
		[_actionImage setImage:[UIImage imageNamed:@"711-trash@2x.png"]];
		[_actionImage setFrame:CGRectMake(self.frame.size.width-45, 40, 30,30)];
		[self slideCell:recognizer];
	}
}

-(void)sendCell:(UILongPressGestureRecognizer*)recognizer
{
	if (recognizer.state == UIGestureRecognizerStateEnded){
		_quick_send=YES;
		[_background setBackgroundColor:GREEN_COLOR];
		[_actionImage setImage:[UIImage imageNamed:@"757-paper-airplane@2x.png"]];
		[_actionImage setFrame:CGRectMake(15, 40, 30,30)];
		[self slideCell:recognizer];
	}
}

/*
-(void)selected
{
	[_cellLine setHidden:YES];
	[_cellOverlay removeGestureRecognizer:_slideCell];
}
*/

-(void)tapCell:(UITapGestureRecognizer*)recognizer
{
	if (recognizer.state==UIGestureRecognizerStateEnded)
	{
		NSMutableDictionary* cell_info = [[NSMutableDictionary alloc] init];
		NSIndexPath *cell_index = [NSIndexPath indexPathForRow:_row inSection:_section];
		[cell_info setObject:[_messageStatus text] forKey:@"date"];
		if (_network==0){[cell_info setObject:[_smsRecipient text] forKey:@"recipient"];}
		[cell_info setObject:[_messagePreview text] forKey:@"message"];
		[cell_info setObject:cell_index forKey:@"index"];
		[cell_info setObject:[NSNumber numberWithInt:_network] forKey:@"type"];
		if (recognizer.state == UIGestureRecognizerStateEnded){
			[[NSNotificationCenter defaultCenter]
			 postNotificationName:@"editCell"
			 object:self
			 userInfo:cell_info];
		}
	}
}


-(void)slideCell:(UILongPressGestureRecognizer*)recognizer
{
	switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
		{
			_initial = [recognizer locationInView:self];
		}
            break;
        case UIGestureRecognizerStateChanged:
		{
			float slide_diff=_current.x-_initial.x;
			bool positive=NO;
			if (slide_diff>=0)
			{
				positive=YES;
			}
			else
			{
				positive=NO;
			}
			_current = [recognizer locationInView:self];
			if (positive)
			{
				if (_table==0)
				{
					[_actionImage setImage:[UIImage imageNamed:@"728-clock@2x.png"]];
				}
				else if (_table==1)
				{
					[_actionImage setImage:[UIImage imageNamed:@"757-paper-airplane@2x.png"]];
				}
				[_actionImage setFrame:CGRectMake(15, 25, 30,30)];
				if (_table!=2)
				{
					[_cellOverlay setFrame:CGRectMake(slide_diff, 0, self.frame.size.width, CELL_HEIGHT)];
					_quick_delete=NO;
					if (slide_diff>=60)
					{
						if (_table==0)
						{
							if (slide_diff>=160)
							{
								_quick_pend=NO;
								_quick_send=YES;
								[_actionImage setFrame:CGRectMake(-45+slide_diff, 25, 30,30)];
								[_actionImage setImage:[UIImage imageNamed:@"757-paper-airplane@2x.png"]];
								[_background setBackgroundColor:GREEN_COLOR];
							}
							else
							{
								_quick_pend=YES;
								_quick_send=NO;
								[_actionImage setFrame:CGRectMake(-45+slide_diff, 25, 30,30)];
								[_actionImage setImage:[UIImage imageNamed:@"728-clock@2x.png"]];
								[_background setBackgroundColor:BLUE_COLOR];
							}
						}
						else
						{
							_quick_send=YES;
							[_actionImage setFrame:CGRectMake(-45+slide_diff, 25, 30,30)];
							[_background setBackgroundColor:GREEN_COLOR];
						}
					}
					else
					{
						_quick_send=NO;
						_quick_pend=NO;
						[_background setBackgroundColor:[UIColor colorWithRed:0.78f green:0.78f blue:0.80f alpha:1.00f]];
						[_actionImage setAlpha:(slide_diff/60)];
					}
				}
			}
			else
			{
				[_actionImage setImage:[UIImage imageNamed:@"711-trash@2x.png"]];
				[_actionImage setFrame:CGRectMake(self.frame.size.width-45, 25, 30,30)];
				if (_table==1)
				{
					[_cellOverlay setFrame:CGRectMake(slide_diff, 0, self.frame.size.width, CELL_HEIGHT)];
					_quick_send=NO;
					if ((slide_diff<=-60))
					{
						_quick_delete=YES;
						[_actionImage setFrame:CGRectMake((self.frame.size.width+15)+slide_diff, 25, 30,30)];
						[_background setBackgroundColor:RED_COLOR];
					}
					else
					{
						_quick_delete=NO;
						[_background setBackgroundColor:[UIColor colorWithRed:0.78f green:0.78f blue:0.80f alpha:1.00f]];
						[_actionImage setAlpha:(slide_diff/-60)];
					}
				}
			}
		}
            break;
        case UIGestureRecognizerStateEnded:
		{
			if (!_quick_send && !_quick_pend && !_quick_delete)
			{
				_restingCellFrame=_cellOverlay.frame;
				_restingCellFrame.origin.x=0;
				[UIView animateWithDuration:0.3f
									  delay:0.0
									options:UIViewAnimationOptionCurveEaseIn
								 animations:^{
									 _cellOverlay.frame=_restingCellFrame;
								 }
								 completion:^(BOOL finished){
									[_background setBackgroundColor:[UIColor colorWithRed:0.78f green:0.78f blue:0.80f alpha:1.00f]];
									 _actionImage.frame = CGRectMake(15, 25, 30,30);
								 }
				 ];
			}
			else if (_quick_send)
			{
				if (_table==0){
					UIAlertView *trashSendAlert = [[UIAlertView alloc] initWithTitle:@"WARNING!"
																			 message:@"You put this in the trash... are you sure you want to send it?"
																			delegate:self
																   cancelButtonTitle:@"Nope, Thanks!"
																   otherButtonTitles:@"Bro... I got this", nil];
					[trashSendAlert show];
				}
				CGRect optionsFrame=_selectedOptions.frame;
				_restingCellFrame=_cellOverlay.frame;
				_restingActionFrame=_actionImage.frame;
				_restingCellFrame.origin.x=self.frame.size.width;
				_restingActionFrame.origin.x=self.frame.size.width-45;
				optionsFrame.origin.x=self.frame.size.width;
				[UIView animateWithDuration:0.3f
									  delay:0.0
									options:UIViewAnimationOptionCurveEaseIn
								 animations:^{
									 _actionImage.frame=_restingActionFrame;
									 _cellOverlay.frame=_restingCellFrame;
									 _selectedOptions.frame=optionsFrame;
								 }
								 completion:^(BOOL finished){
									[self fadeOut];
									 NSMutableDictionary* cellInfo = [[NSMutableDictionary alloc] init];
									 NSIndexPath *cell_index = [NSIndexPath indexPathForRow:_row inSection:_section];
									 [cellInfo setObject:@[[NSNumber numberWithInt:_table],[NSNumber numberWithInt:2],cell_index] forKey:@"cell_info"];
									[self performSelector:@selector(moveCell:) withObject:cellInfo afterDelay:0.25];
								 }
				 ];
			}
			else if (_quick_delete)
			{
				CGRect optionsFrame=_selectedOptions.frame;
				_restingCellFrame=_cellOverlay.frame;
				_restingActionFrame=_actionImage.frame;
				_restingCellFrame.origin.x=-self.frame.size.width;
				_restingActionFrame.origin.x=15;
				optionsFrame.origin.x=-self.frame.size.width;
				[UIView animateWithDuration:0.3f
									  delay:0.0
									options:UIViewAnimationOptionCurveEaseIn
								 animations:^{
									 _actionImage.frame=_restingActionFrame;
									 _cellOverlay.frame=_restingCellFrame;
									 _selectedOptions.frame=optionsFrame;
								 }
								 completion:^(BOOL finished){
									[self fadeOut];
									 NSMutableDictionary* cellInfo = [[NSMutableDictionary alloc] init];
									 NSIndexPath *cell_index = [NSIndexPath indexPathForRow:_row inSection:_section];
									 [cellInfo setObject:@[[NSNumber numberWithInt:_table],[NSNumber numberWithInt:0],cell_index] forKey:@"cell_info"];
									 [self performSelector:@selector(moveCell:) withObject:cellInfo afterDelay:0.25];
								 }
				 ];
			}
			else if (_quick_pend)
			{
				_restingCellFrame=_cellOverlay.frame;
				_restingActionFrame=_actionImage.frame;
				_restingCellFrame.origin.x=self.frame.size.width;
				_restingActionFrame.origin.x=self.frame.size.width-45;
				[UIView animateWithDuration:0.25f
									  delay:0.0
									options:UIViewAnimationOptionCurveEaseIn
								 animations:^{
									 _actionImage.frame=_restingActionFrame;
									 _cellOverlay.frame=_restingCellFrame;
								 }
								 completion:^(BOOL finished){
									 [self fadeOut];
									 NSMutableDictionary* cellInfo = [[NSMutableDictionary alloc] init];
									 NSIndexPath *cell_index = [NSIndexPath indexPathForRow:_row inSection:_section];
									 [cellInfo setObject:@[[NSNumber numberWithInt:_table],[NSNumber numberWithInt:1],cell_index] forKey:@"cell_info"];
									 [self performSelector:@selector(moveCell:) withObject:cellInfo afterDelay:0.25];
								 }
				 ];
			}
		}
            break;
        default:
            break;
    }
}

-(void)moveCell:(NSMutableDictionary*)cellInfo
{
	[[NSNotificationCenter defaultCenter]
	 postNotificationName:@"moveCell"
	 object:self
	 userInfo:cellInfo];
}

-(void)fadeOut
{
	float newAlpha = 0.0;
	[UIView animateWithDuration:0.25f
						  delay:0.0
						options:UIViewAnimationOptionCurveEaseIn
					 animations:^{
						 _actionImage.alpha=newAlpha;
						 _background.alpha=newAlpha;
					 }
					 completion:^(BOOL finished){
						 [self setBackgroundColor:[UIColor colorWithRed:0.78f green:0.78f blue:0.80f alpha:1.00f]];
					 }
	 ];
}

@end
