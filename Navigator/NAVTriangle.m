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
    CGContextBeginPath(context);
    CGContextMoveToPoint   (context, CGRectGetMinX(rect), CGRectGetMaxY(rect));  // bottom left
    CGContextAddLineToPoint(context, CGRectGetMidX(rect), CGRectGetMinY(rect));  // mid top
    CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect));  // bottom left
    CGContextClosePath(context);
    CGContextClosePath(context);
    
    [[UIColor colorWithWhite:0.2 alpha:0.3]set];
    
    CGContextFillPath(context);
}

//- (void) drawRect:(CGRect)rect
//{
//    // Create a gradient from white to red
//    CGFloat colors [] = {
//        0.000, 0.271, 0.608, 1.0,
//        0.063, 0.004, 0.408, 1.0
//    };
//    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextBeginPath(context);
//    CGContextMoveToPoint   (context, CGRectGetMinX(rect), CGRectGetMaxY(rect));  // bottom left
//    CGContextAddLineToPoint(context, CGRectGetMidX(rect), CGRectGetMinY(rect));  // mid top
//    CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect));  // bottom left
//    CGContextClosePath(context);
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
