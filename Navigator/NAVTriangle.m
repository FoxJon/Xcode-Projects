//
//  NAVTriangle.m
//  Navigator
//
//  Created by Jonathan Fox on 5/18/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "NAVTriangle.h"

@implementation NAVTriangle

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
    CGContextMoveToPoint   (context, CGRectGetMinX(rect), CGRectGetMaxY(rect));  // bottom left
    CGContextAddLineToPoint(context, CGRectGetMidX(rect), CGRectGetMinY(rect));  // mid top
    CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect));  // bottom left
    CGContextClosePath(context);

    [[UIColor purpleColor]set];

    CGContextFillPath(context);
}

@end
