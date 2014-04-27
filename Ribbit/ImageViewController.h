//
//  ImageViewController.h
//  Ribbit
//
//  Created by Jonathan Fox on 4/27/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ImageViewController : UIViewController

@property (nonatomic, strong) PFObject *message;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@end
