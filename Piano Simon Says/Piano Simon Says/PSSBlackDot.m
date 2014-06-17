//
//  PSSSettingsView.m
//  Piano Says
//
//  Created by Jonathan Fox on 5/30/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "PSSBlackDot.h"

@implementation PSSBlackDot

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    [[UIColor blackColor] set];
    
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextFillEllipseInRect(context, CGRectMake(0, 0, 10.5, 10.5));
    
    CGContextStrokePath(context);
}

@end
