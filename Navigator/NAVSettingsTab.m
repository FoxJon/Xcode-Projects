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
    
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, 15, 5);
    CGContextMoveToPoint(context, 0, 14);
    CGContextAddLineToPoint(context, 11, 14);
    
    CGContextMoveToPoint(context,15, 5);
    CGContextAddLineToPoint(context, 15, 35);
    CGContextMoveToPoint(context, 0, 20);
    CGContextAddLineToPoint(context, 11, 20);
    
    CGContextMoveToPoint(context, 15, 35);
    CGContextAddLineToPoint(context, 0, 40);
    CGContextMoveToPoint(context, 0, 26);
    CGContextAddLineToPoint(context, 11, 26);
    
    CGContextStrokePath(context);
}

@end
