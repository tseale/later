//
//  LaterComposeView.m
//  Later
//
//  Created by Taylor Seale on 11/7/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import "LaterComposeView.h"

@implementation LaterComposeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		[self setBackgroundColor:[UIColor whiteColor]];
		[self setUserInteractionEnabled:YES];
		
		_editCellPath= nil;
		_recipientShown=NO;
		_type=-1;
		
		UIView* networksBox = [[UIView alloc] initWithFrame:CGRectMake(0, 228, self.frame.size.width, 60)];
		[networksBox setBackgroundColor:[UIColor colorWithRed:0.97f green:0.97f blue:0.97f alpha:1.00f]];
		[self addSubview:networksBox];
		
		UIView *networkSeparator = [[UIView alloc] initWithFrame:CGRectMake(0, 227, self.frame.size.width, 1)];
		[networkSeparator setBackgroundColor:[UIColor colorWithRed:0.84f green:0.84f blue:0.84f alpha:1.00f]];
		[self addSubview:networkSeparator];
		
        _smsImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width/8-20, 288-50, 40, 40)];
		[_smsImage setImage:[UIImage imageNamed:@"message-circle-logo-gray@2x.png"]];
		[_smsImage setUserInteractionEnabled:YES];
		UITapGestureRecognizer* smsTapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(smsTapped:)];
		[smsTapped setNumberOfTapsRequired:1];
		[smsTapped setNumberOfTouchesRequired:1];
		[_smsImage addGestureRecognizer:smsTapped];
		_facebookImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width/2-20, 288-50, 40, 40)];
		[_facebookImage setImage:[UIImage imageNamed:@"facebook-circle-logo-gray@2x.png"]];
		UITapGestureRecognizer* facebookTapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(facebookTapped:)];
		[facebookTapped setNumberOfTapsRequired:1];
		[_facebookImage addGestureRecognizer:facebookTapped];
		[_facebookImage setUserInteractionEnabled:YES];
		_twitterImage = [[UIImageView alloc] initWithFrame:CGRectMake(7*self.frame.size.width/8-20, 288-50, 40, 40)];
		[_twitterImage setImage:[UIImage imageNamed:@"twitter-circle-logo-gray@2x.png"]];
		UITapGestureRecognizer* twitterTapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(twitterTapped:)];
		[twitterTapped setNumberOfTapsRequired:1];
		[_twitterImage addGestureRecognizer:twitterTapped];
		[_twitterImage setUserInteractionEnabled:YES];
		[self addSubview:_smsImage];
		[self addSubview:_facebookImage];
		[self addSubview:_twitterImage];
		
		_sendTimePicker = [[UIDatePicker alloc] init];
		[_sendTimePicker setBackgroundColor:[UIColor colorWithRed:0.85f green:0.87f blue:0.88f alpha:1.00f]];
		[_sendTimePicker setTintColor:[UIColor whiteColor]];
		[_sendTimePicker addTarget:self action:@selector(dateChanged:)
		 forControlEvents:UIControlEventValueChanged];
		[_sendTimePicker setUserInteractionEnabled:YES];
		
		_recipient = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 300, 36)];
		_recipient.delegate=self;
		[_recipient setPlaceholder:@"Recipient"];
		[_recipient setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16]];
		[_recipient addTarget:self action:@selector(checkFormCompletion) forControlEvents:UIControlEventEditingChanged];
		[self addSubview:_recipient];
		
		_recipientSeparator = [[UIView alloc] initWithFrame:CGRectMake(10, 46, 300, 1)];
		[_recipientSeparator setBackgroundColor:[UIColor colorWithRed:0.87f green:0.87f blue:0.87f alpha:1.00f]];
		[self addSubview:_recipientSeparator];
		
		_timeToSend = [[NoCursorUITextField alloc] initWithFrame:CGRectMake(10, 10, 300, 36)];
		_timeToSend.delegate=self;
		[_timeToSend setFont:[UIFont fontWithName:@"HelveticaNeue-LightItalic" size:16]];
		[_timeToSend setBackgroundColor:[UIColor whiteColor]];
		[_timeToSend setPlaceholder:@"When do you want to send?"];
		[_timeToSend setText:@"When do you want to send?"];
		[_timeToSend setTextAlignment:NSTextAlignmentRight];
		[_timeToSend setInputView:_sendTimePicker];
		[_timeToSend addTarget:self action:@selector(checkFormCompletion) forControlEvents:UIControlEventEditingChanged];
		[self addSubview:_timeToSend];
		
		UIView *timeSeparator = [[UIView alloc] initWithFrame:CGRectMake(10, 46, 300, 1)];
		[timeSeparator setBackgroundColor:[UIColor colorWithRed:0.87f green:0.87f blue:0.87f alpha:1.00f]];
		[self addSubview:timeSeparator];
		
		_messageContent = [[UITextView alloc] initWithFrame:CGRectMake(10, 56, 300, 160)];
		[_messageContent setDelegate:self];
		[_messageContent setFont:[UIFont fontWithName:@"HelveticaNeue" size:16]];
		_messageContent.textContainer.lineFragmentPadding = 0;
		_messageContent.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
		[self addSubview:_messageContent];

		_charCount = [[UILabel alloc] initWithFrame:CGRectMake(280, 190, 30, 30)];
		[_charCount setHidden:YES];
		[_charCount setText:@"140"];
		[_charCount setTextAlignment:NSTextAlignmentRight];
		[_charCount setTextColor:[UIColor colorWithRed:0.58f green:0.57f blue:0.59f alpha:1.00f]];
		[_charCount setFont:[UIFont fontWithName:@"HelveticaNeue" size:16]];
		[self addSubview:_charCount];
		
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(composeNew)
													 name:@"composeNew"
												   object:nil];
		
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(composeCancel)
													 name:@"composeCancel"
												   object:nil];
		
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(composeDone)
													 name:@"composeDone"
												   object:nil];
		
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(editDone)
													 name:@"editDone"
												   object:nil];
    }
    return self;
}

- (void) dateChanged:(id)sender{
	_chosen = [_sendTimePicker date];
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"EEEE, MMM d @ h:mm a"];
	
	
	NSString *stringFromDate = [formatter stringFromDate:[_sendTimePicker date]];
	[_timeToSend setText:stringFromDate];
	[self checkFormCompletion];
}

-(void)composeNew
{
	[_timeToSend becomeFirstResponder];
}

-(void)composeCancel
{
	[_messageContent resignFirstResponder];
	[_recipient resignFirstResponder];
	[_timeToSend resignFirstResponder];
	[_messageContent setText:@""];
	[_timeToSend setText:@""];
	[_recipient setText:@""];
	[_charCount setText:@"140"];
	_type=-1;
}

-(void)editDone
{
	NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"EEEE, MMM d @ h:mm a"];
	NSString* dateString = [formatter stringFromDate:_chosen];
	[[[PENDING_MESSAGES objectAtIndex:_editCellPath.section] objectAtIndex:_editCellPath.row] setMessage:_messageContent.text];
	[[[PENDING_MESSAGES objectAtIndex:_editCellPath.section] objectAtIndex:_editCellPath.row] setSmsRecipient:_recipient.text];
	[[[PENDING_MESSAGES objectAtIndex:_editCellPath.section] objectAtIndex:_editCellPath.row] setStatusText:dateString];
	[[[PENDING_MESSAGES objectAtIndex:_editCellPath.section] objectAtIndex:_editCellPath.row] setNetwork:_type];
	[[[PENDING_MESSAGES objectAtIndex:_editCellPath.section] objectAtIndex:_editCellPath.row] setSendTime:_chosen];
	[self composeCancel];
	[[NSNotificationCenter defaultCenter]
	 postNotificationName:@"editDoneConfirm"
	 object:self
	 userInfo:nil];
}

-(void)composeDone
{
	LaterMessageData* newMessage = [[LaterMessageData alloc] init];
	[newMessage setMessage:_messageContent.text];
	[newMessage setSmsRecipient:_recipient.text];
	[newMessage setNetwork:_type];
	[newMessage setSendTime:_chosen];
	NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"EEEE, MMM d @ h:mm a"];
	NSString* dateString = [formatter stringFromDate:_chosen];
	[newMessage setStatusText:dateString];
	[newMessage setStatus:1];
	[[PENDING_MESSAGES objectAtIndex:_type] addObject:newMessage];
	[self composeCancel];
	[[NSNotificationCenter defaultCenter]
	 postNotificationName:@"composeDoneConfirm"
	 object:self
	 userInfo:nil];
}

-(void)checkFormCompletion
{
	bool activate_done=YES;
	
	if (_type==-1)
	{
		activate_done=NO;
	}
	else if (_type==0)
	{
		if ([[_recipient text] isEqualToString:@""])
		{
			activate_done=NO;
		}
	}
	
	if ([[_timeToSend text] isEqualToString:@""] || [[_messageContent text] isEqualToString:@""])
	{
		activate_done=NO;
	}
	
	if (activate_done)
	{
		[[NSNotificationCenter defaultCenter]
		 postNotificationName:@"doneButtonActivate"
		 object:self
		 userInfo:nil];
	}else{
		[[NSNotificationCenter defaultCenter]
		 postNotificationName:@"doneButtonDeactivate"
		 object:self
		 userInfo:nil];
	}
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
	[self checkFormCompletion];
	if ([textField isEqual:_timeToSend]){
		[_timeToSend setTextColor:BLUE_COLOR];
	}
	else if ([textField isEqual:_recipient]){
		[_recipient setTextColor:BLUE_COLOR];
	}
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
	[self checkFormCompletion];
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
	[self checkFormCompletion];
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
	[self checkFormCompletion];
}

-(void)textViewDidChange:(UITextView *)textView
{
	[self checkFormCompletion];
	int numChars = (int)_messageContent.text.length;
	_charCount.text=[NSString stringWithFormat:@"%d",140-numChars];
	if ((long)_messageContent.text.length>140)
	{
		[_charCount setTextColor:RED_COLOR];
	}
	else{
		[_charCount setTextColor:[UIColor colorWithRed:0.58f green:0.57f blue:0.59f alpha:1.00f]];
	}
}

-(void)smsTapped:(UITapGestureRecognizer*)recognizer
{
	if (recognizer.state == UIGestureRecognizerStateEnded)
    {
		[_smsImage setImage:[UIImage imageNamed:@"message-circle-logo@2x.png"]];
		[_facebookImage setImage:[UIImage imageNamed:@"facebook-circle-logo-gray@2x.png"]];
		[_twitterImage setImage:[UIImage imageNamed:@"twitter-circle-logo-gray@2x.png"]];
		[_recipient becomeFirstResponder];
		[_charCount setHidden:YES];
		_type=0;
		[self checkFormCompletion];
		if (!_recipientShown)
		{
			CGRect contentFrame = _messageContent.frame;
			CGRect recipientFrame = _recipient.frame;
			CGRect separatorFrame = _recipientSeparator.frame;
			separatorFrame.origin.y = 92;
			recipientFrame.origin.y = 56;
			contentFrame.origin.y = 102;
			contentFrame.size.height = 114;
			[UIView animateWithDuration:0.25f
								  delay:0.0
								options:UIViewAnimationOptionCurveEaseIn
							 animations:^{
								 _messageContent.frame = contentFrame;
								 _recipient.frame = recipientFrame;
								 _recipientSeparator.frame = separatorFrame;
							 }
							 completion:^(BOOL finished){
								 _recipientShown=YES;
							 }
			 ];
		}
	}
}

-(void)facebookTapped:(UITapGestureRecognizer*)recognizer
{
	if (recognizer.state == UIGestureRecognizerStateEnded)
    {
		[_smsImage setImage:[UIImage imageNamed:@"message-circle-logo-gray@2x.png"]];
		[_facebookImage setImage:[UIImage imageNamed:@"facebook-circle-logo@2x.png"]];
		[_twitterImage setImage:[UIImage imageNamed:@"twitter-circle-logo-gray@2x.png"]];
		[_charCount setHidden:YES];
		[_messageContent becomeFirstResponder];
		_type=1;
		[self checkFormCompletion];
		if (_recipientShown)
		{
			CGRect contentFrame = _messageContent.frame;
			CGRect recipientFrame = _recipient.frame;
			CGRect separatorFrame = _recipientSeparator.frame;
			separatorFrame.origin.y = 46;
			recipientFrame.origin.y	= 10;
			contentFrame.origin.y = 56;
			contentFrame.size.height = 160;
			[UIView animateWithDuration:0.25f
								  delay:0.0
								options:UIViewAnimationOptionCurveEaseIn
							 animations:^{
								_messageContent.frame = contentFrame;
								 _recipient.frame = recipientFrame;
								 _recipientSeparator.frame = separatorFrame;
							 }
							 completion:^(BOOL finished){
								 _recipientShown=NO;
							 }
			 ];
		}
	}
}

-(void)twitterTapped:(UITapGestureRecognizer*)recognizer
{
	if (recognizer.state == UIGestureRecognizerStateEnded)
    {
		[_smsImage setImage:[UIImage imageNamed:@"message-circle-logo-gray@2x.png"]];
		[_facebookImage setImage:[UIImage imageNamed:@"facebook-circle-logo-gray@2x.png"]];
		[_twitterImage setImage:[UIImage imageNamed:@"twitter-circle-logo@2x.png"]];
		[_messageContent becomeFirstResponder];
		_type=2;
		[self checkFormCompletion];
		if (_recipientShown)
		{
			CGRect contentFrame = _messageContent.frame;
			CGRect recipientFrame = _recipient.frame;
			CGRect separatorFrame = _recipientSeparator.frame;
			separatorFrame.origin.y = 46;
			recipientFrame.origin.y = 10;
			contentFrame.origin.y = 56;
			contentFrame.size.height = 160;
			[UIView animateWithDuration:0.25f
								  delay:0.0
								options:UIViewAnimationOptionCurveEaseIn
							 animations:^{
								 _messageContent.frame = contentFrame;
								 _recipient.frame = recipientFrame;
								 _recipientSeparator.frame = separatorFrame;
							 }
							 completion:^(BOOL finished){
								 _recipientShown=NO;
								 [_charCount setHidden:NO];
							 }
			 ];
		}
		else
		{
			[_charCount setHidden:NO];
		}
	}
}

-(void)setupViews
{
	[_smsImage setImage:[UIImage imageNamed:@"message-circle-logo-gray@2x.png"]];
	[_facebookImage setImage:[UIImage imageNamed:@"facebook-circle-logo-gray@2x.png"]];
	[_twitterImage setImage:[UIImage imageNamed:@"twitter-circle-logo-gray@2x.png"]];
	switch (_type) {
		case 0:
			[_smsImage setImage:[UIImage imageNamed:@"message-circle-logo@2x.png"]];
			[_recipient setFrame:CGRectMake(10, 56, 300, 36)];
			[_messageContent setFrame:CGRectMake(10, 102, 300, 114)];
			[_charCount setHidden:YES];
			break;
		case 1:
			[_facebookImage setImage:[UIImage imageNamed:@"facebook-circle-logo@2x.png"]];
			[_recipient setFrame:CGRectMake(10, 10, 300, 36)];
			[_messageContent setFrame:CGRectMake(10, 56, 300, 160)];
			[_charCount setHidden:YES];
			break;
		case 2:
			[_twitterImage setImage:[UIImage imageNamed:@"twitter-circle-logo@2x.png"]];
			[_recipient setFrame:CGRectMake(10, 10, 300, 36)];
			[_messageContent setFrame:CGRectMake(10, 56, 300, 160)];
			[_charCount setHidden:NO];
			break;
		default:
			break;
	}
}

@end
