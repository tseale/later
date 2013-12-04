//
//  LaterGlobalData.h
//  Later
//
//  Created by Taylor Seale on 11/7/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LaterMessageData.h"

@interface LaterGlobalData : NSObject

+(LaterGlobalData*)sharedInstance;

@property (nonatomic,strong) NSMutableDictionary* globalData;

@property (nonatomic,strong) NSMutableArray* trashSMS;
@property (nonatomic,strong) NSMutableArray* trashFacebook;
@property (nonatomic,strong) NSMutableArray* trashTwitter;

@property (nonatomic,strong) NSMutableArray* pendingSMS;
@property (nonatomic,strong) NSMutableArray* pendingFacebook;
@property (nonatomic,strong) NSMutableArray* pendingTwitter;

@property (nonatomic,strong) NSMutableArray* sentSMS;
@property (nonatomic,strong) NSMutableArray* sentFacebook;
@property (nonatomic,strong) NSMutableArray* sentTwitter;

@end
