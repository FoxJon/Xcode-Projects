//
//  SignUpViewController.m
//  Ribbit
//
//  Created by Jonathan Fox on 4/26/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "SignUpViewController.h"
#import <Parse/Parse.h>

@interface SignUpViewController ()

@end

@implementation SignUpViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        self.backgroundImageView.image = [UIImage imageNamed:@"loginBackground-568h"];
    }
    
//    self.userNameField.delegate = self;
//    self.passwordField.delegate = self;
//    self.emailField.delegate = self;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)signUp:(id)sender {
    NSString * username = [self.userNameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString * password = [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString * email = [self.emailField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    if ([username length] == 0 || [password length] == 0 || [email length] == 0){
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"Oops!" message:@"Make sure you use a username, password and email address!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alertView show];
    }
    else{
        PFUser *newUser = [PFUser user];
        newUser.username = username;
        newUser.password = password;
        newUser.email = email;
        
       [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
           if (error) {
               UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"Sorry!" message:[error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
               [alertView show];
           }else{
               [self.navigationController popToRootViewControllerAnimated:YES];
           }
       }];
    }
}

- (IBAction)dismiss:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITextField delegate methods

//-(BOOL)textFieldShouldReturn:(UITextField *)textField {
//    [textField resignFirstResponder];
//    return YES;
//}
@end
