//
//  LaterGlobalData.m
//  Later
//
//  Created by Taylor Seale on 11/7/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import "LaterGlobalData.h"

@implementation LaterGlobalData

+(LaterGlobalData*)sharedInstance
{
	static LaterGlobalData* sharedInstance = nil;
	@synchronized (self)
	{
		if (sharedInstance == nil)
		{
			sharedInstance = [[LaterGlobalData alloc] init];
			
			sharedInstance.trashSMS = [[NSMutableArray alloc] init];
			sharedInstance.trashFacebook = [[NSMutableArray alloc] init];
			sharedInstance.trashTwitter = [[NSMutableArray alloc] init];
			sharedInstance.pendingSMS = [[NSMutableArray alloc] init];
			sharedInstance.pendingFacebook = [[NSMutableArray alloc] init];
			sharedInstance.pendingTwitter = [[NSMutableArray alloc] init];
			sharedInstance.sentSMS = [[NSMutableArray alloc] init];
			sharedInstance.sentFacebook = [[NSMutableArray alloc] init];
			sharedInstance.sentTwitter = [[NSMutableArray alloc] init];
			
			sharedInstance.globalData = [[NSMutableDictionary alloc] initWithObjects:@[
																					 @[sharedInstance.trashSMS,sharedInstance.trashFacebook,sharedInstance.trashTwitter],
																					 @[sharedInstance.pendingSMS,sharedInstance.pendingFacebook,sharedInstance.pendingTwitter],
																					 @[sharedInstance.sentSMS,sharedInstance.sentFacebook,sharedInstance.sentTwitter]
																					 ]
																		   forKeys:@[
																					 @"trash",
																					 @"pending",
																					 @"sent"
																					 ]];
		}
	}
	return sharedInstance;
}
@end
