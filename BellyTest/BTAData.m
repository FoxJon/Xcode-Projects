//
//  BTAData.m
//  BellyTest
//
//  Created by Jonathan Fox on 6/17/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "BTAData.h"

@implementation BTAData

+(BTAData *)mainData
{
    static dispatch_once_t create;
    static BTAData * singleton = nil;
    
    dispatch_once(&create, ^{
        singleton = [[BTAData alloc]init];
    });
    
    return singleton;
}


@end
