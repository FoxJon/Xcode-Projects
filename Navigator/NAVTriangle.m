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

//- (void)drawRect:(CGRect)rect
//{
//    // Drawing code
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextBeginPath(context);
//    CGContextMoveToPoint   (context, CGRectGetMinX(rect), CGRectGetMaxY(rect));  // bottom left
//    CGContextAddLineToPoint(context, CGRectGetMidX(rect), CGRectGetMinY(rect));  // mid top
//    CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect));  // bottom left
//    CGContextClosePath(context);
//
//    [[UIColor purpleColor]set];
//
//    CGContextFillPath(context);
//}

//- (void) drawRect:(CGRect)rect
//{
//    // Create a gradient from white to red
//    CGFloat colors [] = {
//        0.867, 0.000, 0.855, 1.0,
//        0.639, 0.000, 0.635, 1.0
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
//   
//    CGContextBeginPath(context);
//    CGContextMoveToPoint   (context, CGRectGetMinX(rect), CGRectGetMaxY(rect));  // bottom left
//    CGContextAddLineToPoint(context, CGRectGetMidX(rect), CGRectGetMinY(rect));  // mid top
//    CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect));  // bottom left
//    CGContextClosePath(context);
//    
//    CGContextFillPath(context);
//    
//    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
//    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
//    
//    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
//    CGGradientRelease(gradient), gradient = NULL;
//    
//    CGContextRestoreGState(context);
//}

- (void)drawRect:(CGRect)rect
{
    CGFloat w = self.bounds.size.width / 4;
    CGFloat h = self.bounds.size.height / 4;
    CGFloat x = w * 2;
    CGFloat y = h;
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path,NULL, x, y);
    CGPathAddLineToPoint(path, NULL, x+w, y+2*h);
    CGPathAddLineToPoint(path, NULL, x-w, y+2*h);
    CGPathCloseSubpath(path);
    
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    [shapeLayer setPath:path];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    gradientLayer.startPoint = CGPointMake(0.25, 1.0);
    gradientLayer.endPoint = CGPointMake(0.75, 0.0);
    UIColor *startColour = [UIColor redColor];
    UIColor *endColour = [UIColor greenColor];
    gradientLayer.colors = [NSArray arrayWithObjects:(id)[startColour CGColor], (id)[endColour CGColor], nil];
    
    [gradientLayer setMask:shapeLayer];
    
    [self.layer addSublayer:gradientLayer];
    
    CGPathRelease(path);
}

@end
