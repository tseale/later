//
//  LaterCell.h
//  Later
//
//  Created by Taylor Seale on 11/4/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LaterMessageData.h"

@interface LaterCell : UITableViewCell

@property (nonatomic,strong) UIView* background;
@property (nonatomic,strong) UIView* cellOverlay;
@property (nonatomic,strong) UIImageView* networkImage;
@property (nonatomic,strong) UILabel* smsRecipient;
@property (nonatomic,strong) UILabel* messagePreview;
@property (nonatomic,strong) UILabel* messageStatus;

@property (nonatomic,strong) UILongPressGestureRecognizer* slideCell;
@property (nonatomic,strong) UITapGestureRecognizer* tapCell;

@property (nonatomic,strong) UIView* cellLine;

@property (nonatomic,strong) UIView* selectedOptions;

@property (nonatomic,strong) UIImageView* actionImage;
@property (nonatomic,strong) UIImageView* trashImage;
@property (nonatomic,strong) UIImageView* editImage;
@property (nonatomic,strong) UIImageView* sendImage;

@property (nonatomic,assign) CGPoint initial,current;
@property (nonatomic,assign) CGRect restingCellFrame, restingActionFrame;

@property (nonatomic,assign) bool quick_delete, quick_pend, quick_send;
@property (nonatomic,assign) bool isSelected;

@property (nonatomic,assign) int table, section, row, network;

-(id)initWithData:(LaterMessageData*)data;
@end
