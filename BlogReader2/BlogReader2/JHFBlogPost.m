//
//  JHFBlogPost.m
//  BlogReader2
//
//  Created by Jonathan Fox on 4/5/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "JHFBlogPost.h"

@implementation JHFBlogPost

//- (void) setTitle:(NSString *)_title {
//    title = _title;
//}
//
//- (NSString *) title{
//    return title;
//}

//@synthesize title = title;

- (id)initWithTitle:(NSString *)title{
    self = [super init];
    
    if (self) {
        self.title = title;
        self.author = nil;
        self.thumbnail = nil;
    }
    return self;
}

+ (id)blogPostWithTitle:(NSString *)title{
    return [[self alloc] initWithTitle:title];
}
- (NSURL *) thumbnailURL{
    return [NSURL URLWithString:self.thumbnail];
}

- (NSString *)formattedDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *tempDate = [dateFormatter dateFromString:self.date];
    
    [dateFormatter setDateFormat:@"EE MMM, dd"];
    return [dateFormatter stringFromDate:tempDate];
}


@end
