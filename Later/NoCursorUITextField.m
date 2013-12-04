//
//  NoCursorUITextField.m
//  Later
//
//  Created by Taylor Seale on 12/2/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import "NoCursorUITextField.h"

@implementation NoCursorUITextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (CGRect)caretRectForPosition:(UITextPosition *)position
{
    return CGRectZero;
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
