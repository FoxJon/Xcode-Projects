//
//  JHFViewController.h
//  Simple_Button_Label
//
//  Created by Jonathan Fox on 4/7/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHFViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *myLabel;
- (IBAction)buttonPressed:(id)sender;

@end
