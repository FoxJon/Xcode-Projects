//
//  PSSSettingsView.m
//  Piano Simon Says
//
//  Created by Jonathan Fox on 5/30/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "PSSSettingsView.h"

@implementation PSSSettingsView

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
    [[UIColor colorWithWhite:1.0 alpha:0.7] set];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0);
    
    CGContextClearRect(context, rect);
        
    
    CGContextMoveToPoint(context, 6.5, 13);
    CGContextAddLineToPoint(context, 22.5, 13);
    
    CGContextMoveToPoint(context, 6.5, 20);
    CGContextAddLineToPoint(context, 22.5, 20);
    
    CGContextMoveToPoint(context, 6.5, 27);
    CGContextAddLineToPoint(context, 22.5, 27);
    
    CGContextStrokePath(context);
    
    
    [[UIColor colorWithWhite:1.0 alpha:0.2] set];
    CGContextFillEllipseInRect(context, CGRectMake(2, 7.5, 25, 25));
    
    CGContextStrokePath(context);
}

@end