//
//  PSSSettingsView.m
//  Piano Simon Says
//
//  Created by Jonathan Fox on 5/30/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "PSSSettingsView.h"

@implementation PSSSettingsView

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
    [[UIColor colorWithWhite:1.0 alpha:0.6] set];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0);
    
    CGContextClearRect(context, rect);
    
    //[self.tintColor set];
    
    
    CGContextMoveToPoint(context, 4, 13);
    CGContextAddLineToPoint(context, 25, 13);
    
    CGContextMoveToPoint(context, 4, 20);
    CGContextAddLineToPoint(context, 25, 20);
    
    CGContextMoveToPoint(context, 4, 27);
    CGContextAddLineToPoint(context, 25, 27);
    
    CGContextStrokePath(context);
    
//    CGContextBeginPath(context);
//    CGContextMoveToPoint(context, 20, 0);
//    CGContextAddLineToPoint(context, 0, 5);
//    CGContextAddLineToPoint(context, 0, 40);
//    CGContextAddLineToPoint(context, 20, 45);
//    CGContextClosePath(context);
//    
//    [[UIColor colorWithWhite:0.6 alpha:0.3] set];
//    
//    CGContextFillPath(context);
    
}


@end
