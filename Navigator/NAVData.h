//
//  NAVData.h
//  Navigator
//
//  Created by Jonathan Fox on 5/17/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NAVData : NSObject

+(NAVData *)mainData;

@property (nonatomic) NSString * color;
@property (nonatomic) NSString * number;

@end
