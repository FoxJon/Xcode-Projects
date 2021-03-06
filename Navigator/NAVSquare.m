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
    
    [[UIColor colorWithWhite:0.2 alpha:0.3]set];
    
    CGContextFillPath(context);
}

//- (void) drawRect:(CGRect)rect
//{
//    // Create a gradient from white to red
//    CGFloat colors [] = {
//        0.000, 0.600, 0.812, 1.0,
//        0.000, 0.271, 0.608, 1.0
//    };
//    
//    CGColorSpaceRef baseSpace = CGColorSpaceCreateDeviceRGB();
//    CGGradientRef gradient = CGGradientCreateWithColorComponents(baseSpace, colors, NULL, 2);
//    CGColorSpaceRelease(baseSpace), baseSpace = NULL;
//    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextSaveGState(context);
//    CGContextClip(context);
//    
//    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
//    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
//    
//    CGContextBeginPath(context);
//    CGContextMoveToPoint   (context, CGRectGetMinX(rect), CGRectGetMinY(rect));  // top left
//    CGContextAddLineToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect));  // bottom left
//    CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect));  // bottom right
//    CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMinY(rect));  // top right
//    CGContextClosePath(context);
//    
//    CGContextFillPath(context);
//
//    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
//    CGGradientRelease(gradient), gradient = NULL;
//    
//    CGContextRestoreGState(context);
//}

@end
