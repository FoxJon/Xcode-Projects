//
//  NAVDraw.m
//  Navigator
//
//  Created by Jonathan Fox on 5/18/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "NAVSettingsTab.h"

@implementation NAVSettingsTab

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
    [[UIColor colorWithWhite:0.0 alpha:0.2] set];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.6);
    
    CGContextClearRect(context, rect);
    
    //[self.tintColor set];
    
    
    CGContextMoveToPoint(context, 4, 13.75);
    CGContextAddLineToPoint(context, 16, 13.75);
    
    CGContextMoveToPoint(context, 4, 22.5);
    CGContextAddLineToPoint(context, 16, 22.5);
    
    CGContextMoveToPoint(context, 4, 31.25);
    CGContextAddLineToPoint(context, 16, 31.25);
    
    CGContextStrokePath(context);
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 20, 0);
    CGContextAddLineToPoint(context, 0, 5);
    CGContextAddLineToPoint(context, 0, 40);
    CGContextAddLineToPoint(context, 20, 45);
    CGContextClosePath(context);
    
    [[UIColor colorWithWhite:0.6 alpha:0.3] set];
    
    CGContextFillPath(context);
    
}


@end
