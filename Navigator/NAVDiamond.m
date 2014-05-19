//
//  NAVDiamond.m
//  Navigator
//
//  Created by Jonathan Fox on 5/18/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "NAVDiamond.h"

@implementation NAVDiamond

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
    CGContextMoveToPoint   (context, CGRectGetMidX(rect), CGRectGetMinY(rect));  // top mid
    CGContextAddLineToPoint(context, CGRectGetMinX(rect), CGRectGetMidY(rect));  // mid left
    CGContextAddLineToPoint(context, CGRectGetMidX(rect), CGRectGetMaxY(rect));  // bottom mid
    CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMidY(rect));  // mid right
    CGContextClosePath(context);
    
    [[UIColor magentaColor]set];
    
    CGContextFillPath(context);
}

@end
