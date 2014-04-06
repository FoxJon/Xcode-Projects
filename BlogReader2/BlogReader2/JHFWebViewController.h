//
//  JHFWebViewController.h
//  BlogReader2
//
//  Created by Jonathan Fox on 4/6/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHFWebViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) NSURL * blogPostURL;


@end
