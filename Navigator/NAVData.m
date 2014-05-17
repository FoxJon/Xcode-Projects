//
//  NAVData.m
//  Navigator
//
//  Created by Jonathan Fox on 5/17/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "NAVData.h"

@implementation NAVData

+(NAVData *)mainData
{
    static dispatch_once_t create;
    static NAVData * singleton = nil;
    
    dispatch_once(&create, ^{
        singleton = [[NAVData alloc]init];
    });
    
    return singleton;
}

-(void)setColor:(NSString *)color
{
    _color = color;
  //  NSLog(@"color is %@", _color);
}

-(void)setNumber:(NSString *)number
{
    _number = number;
    NSLog(@"red score is %ld", (long)_number);
}

@end
