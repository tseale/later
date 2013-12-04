//
//  LaterTableView.m
//  Later
//
//  Created by Taylor Seale on 11/4/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import "LaterTableView.h"

@implementation LaterTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //[self setBackgroundColor:[UIColor colorWithRed:0.94f green:0.94f blue:0.96f alpha:1.00f]];
		[self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
