//
//  JHFBlogPost.h
//  BlogReader2
//
//  Created by Jonathan Fox on 4/5/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHFBlogPost : NSObject

@property (nonatomic, strong)NSString * title;
@property (nonatomic, strong)NSString * author;
@property (nonatomic, strong)NSString * thumbnail;
@property (nonatomic, strong)NSString * date;
@property (nonatomic, strong)NSURL *url;

// Designated Initializer
- (id)initWithTitle:(NSString *)title;
+ (id)blogPostWithTitle:(NSString *)title;

- (NSURL *) thumbnailURL;
- (NSString *)formattedDate;


@end
