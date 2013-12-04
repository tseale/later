//
//  LaterMessageData.h
//  Later
//
//  Created by Taylor Seale on 11/4/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LaterMessageData : NSObject

@property (nonatomic,strong) NSString *smsRecipient;
@property (nonatomic,strong) NSString *message;
@property (nonatomic,strong) NSString *statusText;

@property (nonatomic,strong) NSDate* sendTime;

@property (nonatomic,assign) int network, status, row, section;

@end
