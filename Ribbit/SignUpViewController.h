//
//  SignUpViewController.h
//  Ribbit
//
//  Created by Jonathan Fox on 4/26/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController 

@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

- (IBAction)signUp:(id)sender;
- (IBAction)dismiss:(id)sender;

@end
