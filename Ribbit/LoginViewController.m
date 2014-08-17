//
//  LoginViewController.m
//  Ribbit
//
//  Created by Jonathan Fox on 4/26/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

@end

@implementation LoginViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;
    
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        self.backgroundImageView.image = [UIImage imageNamed:@"loginBackground-568h"];
        
//        self.userNameField.delegate = self;
//        self.passwordField.delegate = self;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBar.hidden = YES;
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


- (IBAction)Button:(id)sender {
    NSString * username = [self.userNameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString * password = [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([username length] == 0 || [password length] == 0){
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"Oops!" message:@"Make sure you use a username and password!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alertView show];
    }
    else{
       [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error) {
           if (error) {
               UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"Sorry!" message:[error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
               [alertView show];
           }else{
               [self.navigationController popToRootViewControllerAnimated:YES];
           }
       }];
    }
}

#pragma mark - UITextField delegate methods

//-(BOOL)textFieldShouldReturn:(UITextField *)textField {
//    [textField resignFirstResponder];
//    return YES;
//}
@end
