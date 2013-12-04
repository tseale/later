//
//  LaterComposeView.h
//  Later
//
//  Created by Taylor Seale on 11/7/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LaterMessageData.h"
#import "NoCursorUITextField.h"

@interface LaterComposeView : UIView <UITextFieldDelegate,UITextViewDelegate,UIPickerViewDelegate>

@property (nonatomic,strong) UIImageView* smsImage;
@property (nonatomic,strong) UIImageView* facebookImage;
@property (nonatomic,strong) UIImageView* twitterImage;

@property (nonatomic,strong) NSIndexPath* editCellPath;

@property (nonatomic,strong) NSDate* chosen;
@property (nonatomic,strong) UIDatePicker* sendTimePicker;
@property (nonatomic,strong) UIPickerView* sendTimePickerView;

@property (nonatomic,strong) UILabel* charCount;

@property (nonatomic,strong) UIView* recipientSeparator;

@property (nonatomic,strong) UITextField* recipient;
@property (nonatomic,strong) UITextView* messageContent;
@property (nonatomic,strong) NoCursorUITextField* timeToSend;

@property (nonatomic,assign) int type;
@property (nonatomic,assign) bool recipientShown;

-(void)checkFormCompletion;
-(void)setupViews;

@end
