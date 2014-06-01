//
//  PSSxView.m
//  Piano Simon Says
//
//  Created by Jonathan Fox on 5/30/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "PSSxView.h"

@implementation PSSxView

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
    // X
    [[UIColor colorWithWhite:1.0 alpha:0.4] set];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    
    CGContextClearRect(context, rect);
    
    
    CGContextMoveToPoint(context, 6.5, 13);
    CGContextAddLineToPoint(context, 22.5, 27);
    
    CGContextMoveToPoint(context, 6.5, 27);
    CGContextAddLineToPoint(context, 22.5, 13);
    
    CGContextStrokePath(context);
    
    
    // circle
    [[UIColor colorWithWhite:1.0 alpha:0.2] set];
    CGContextFillEllipseInRect(context, CGRectMake(2, 7.5, 25, 25));
    
    CGContextStrokePath(context);
    
}


@end
