//
//  NAVCircle.m
//  Navigator
//
//  Created by Jonathan Fox on 5/18/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "NAVCircle.h"

@implementation NAVCircle

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
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [[UIColor cyanColor] set];
    CGContextFillEllipseInRect(context, CGRectMake(2, 2, 55, 55));

    CGContextStrokePath(context);
}

@end
