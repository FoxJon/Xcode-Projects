//
//  PSSxView.m
//  Piano Simon Says
//
//  Created by Jonathan Fox on 5/30/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "PSSxView.h"

@implementation PSSxView

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
    //[[UIColor whiteColor] set];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    
    CGContextClearRect(context, rect);
    
    //[self.tintColor set];
    
    
    CGContextMoveToPoint(context, 4, 13);
    CGContextAddLineToPoint(context, 25, 30);
    
    CGContextMoveToPoint(context, 4, 30);
    CGContextAddLineToPoint(context, 25, 13);
    
    CGContextStrokePath(context);
    
}


@end
