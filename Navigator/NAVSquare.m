//
//  NAVSquare.m
//  Navigator
//
//  Created by Jonathan Fox on 5/18/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "NAVSquare.h"

@implementation NAVSquare

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
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(context);
    CGContextMoveToPoint   (context, CGRectGetMinX(rect), CGRectGetMinY(rect));  // top left
    CGContextAddLineToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect));  // bottom left
    CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect));  // bottom right
    CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMinY(rect));  // top right
    CGContextClosePath(context);
    
    [[UIColor orangeColor]set];
    
    CGContextFillPath(context);
}

@end
