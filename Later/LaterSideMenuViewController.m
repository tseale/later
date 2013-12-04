//
//  LaterSideMenuViewController.m
//  Later
//
//  Created by Taylor Seale on 12/2/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import "LaterSideMenuViewController.h"

@interface LaterSideMenuViewController ()

@end

@implementation LaterSideMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.view setBackgroundColor:[UIColor colorWithRed:0.27f green:0.27f blue:0.27f alpha:1.00f]];
	_messageInfo = [[UIView alloc] initWithFrame:CGRectMake(20, TOP_BAR_HEIGHT+20, 250, 100)];
	UILabel* messageTitle = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 250, 25)];
	[messageTitle setText:@"SMS Messaging"];
	[messageTitle setTextColor:[UIColor whiteColor]];
	[messageTitle setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:20]];
	[_messageInfo addSubview:messageTitle];
	UIImageView* messageImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 50, 50)];
	[messageImage setImage:[UIImage imageNamed:@"message-circle-logo@2x.png"]];
	messageImage.contentMode = UIViewContentModeScaleAspectFit;
	[_messageInfo addSubview:messageImage];
	UILabel* messageDetail = [[UILabel alloc] initWithFrame:CGRectMake(70, 30, 250, 25)];
	[messageDetail setText:@"(801) 388-2538"];
	[messageDetail setTextColor:[UIColor whiteColor]];
	[messageDetail setFont:[UIFont fontWithName:@"HelveticaNeue-LightItalic" size:16]];
	[_messageInfo addSubview:messageDetail];
	[self.view addSubview:_messageInfo];
	
	_facebookInfo = [[UIView alloc] initWithFrame:CGRectMake(20, self.view.frame.size.height/2-50, 250, 100)];
	UILabel* facebookTitle = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 250, 25)];
	[facebookTitle setText:@"Facebook"];
	[facebookTitle setTextColor:[UIColor whiteColor]];
	[facebookTitle setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:20]];
	[_facebookInfo addSubview:facebookTitle];
	UIImageView* facebookImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 50, 50)];
	[facebookImage setImage:[UIImage imageNamed:@"facebook-circle-logo@2x.png"]];
	facebookImage.contentMode = UIViewContentModeScaleAspectFit;
	[_facebookInfo addSubview:facebookImage];
	UILabel* facebookDetail = [[UILabel alloc] initWithFrame:CGRectMake(70, 30, 250, 25)];
	[facebookDetail setText:@"Taylor Seale"];
	[facebookDetail setTextColor:[UIColor whiteColor]];
	[facebookDetail setFont:[UIFont fontWithName:@"HelveticaNeue-LightItalic" size:16]];
	[_facebookInfo addSubview:facebookDetail];
	[self.view addSubview:_facebookInfo];
	
	_twitterInfo = [[UIView alloc] initWithFrame:CGRectMake(20, self.view.frame.size.height-BOTTOM_BAR_HEIGHT-120, 250, 100)];
	UILabel* twitterTitle = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 250, 25)];
	[twitterTitle setText:@"Twitter"];
	[twitterTitle setTextColor:[UIColor whiteColor]];
	[twitterTitle setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:20]];
	[_twitterInfo addSubview:twitterTitle];
	UIImageView* twitterImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 50, 50)];
	[twitterImage setImage:[UIImage imageNamed:@"twitter-circle-logo@2x.png"]];
	messageImage.contentMode = UIViewContentModeScaleAspectFit;
	[_twitterInfo addSubview:twitterImage];
	UILabel* twitterDetail = [[UILabel alloc] initWithFrame:CGRectMake(70, 30, 250, 25)];
	[twitterDetail setText:@"@therealseale"];
	[twitterDetail setTextColor:[UIColor whiteColor]];
	[twitterDetail setFont:[UIFont fontWithName:@"HelveticaNeue-LightItalic" size:16]];
	[_twitterInfo addSubview:twitterDetail];
	[self.view addSubview:_twitterInfo];
}

- (BOOL)prefersStatusBarHidden
{
    return _hideStatusBar;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
