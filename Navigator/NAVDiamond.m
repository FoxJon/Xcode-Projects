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
    
    [[UIColor colorWithWhite:0.2 alpha:0.3]set];
    
    CGContextFillPath(context);
}

//- (void) drawRect:(CGRect)rect
//{
//    // Create a gradient from white to red
//    CGFloat colors [] = {
//        0.063, 0.004, 0.408, 1.0,
//        0.024, 0.000, 0.204, 1.0
//    };
//    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//        CGContextBeginPath(context);
//        CGContextMoveToPoint   (context, CGRectGetMidX(rect), CGRectGetMinY(rect));  // top mid
//        CGContextAddLineToPoint(context, CGRectGetMinX(rect), CGRectGetMidY(rect));  // mid left
//        CGContextAddLineToPoint(context, CGRectGetMidX(rect), CGRectGetMaxY(rect));  // bottom mid
//        CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMidY(rect));  // mid right
//        CGContextClosePath(context);
//    
//    CGColorSpaceRef baseSpace = CGColorSpaceCreateDeviceRGB();
//    CGGradientRef gradient = CGGradientCreateWithColorComponents(baseSpace, colors, NULL, 2);
//    
//    CGContextSaveGState(context);
//    CGContextClip(context);
//    
//    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
//    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
//    
//    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
//    CGGradientRelease(gradient), gradient = NULL;
//    
//    CGContextFillPath(context);
//}

@end
