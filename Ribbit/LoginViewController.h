//
//  LoginViewController.h
//  Ribbit
//
//  Created by Jonathan Fox on 4/26/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController 

@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

- (IBAction)Button:(id)sender;

@end
