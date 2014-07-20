//
//  JHFDiaryEntry.m
//  Diary
//
//  Created by Jonathan Fox on 7/19/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "JHFDiaryEntry.h"


@implementation JHFDiaryEntry

@dynamic date;
@dynamic body;
@dynamic image;
@dynamic mood;
@dynamic location;

- (NSString *)sectionName{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MMM yyyy"];
    
    return [dateFormatter stringFromDate:date];
}

@end
