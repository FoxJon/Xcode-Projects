//
//  JHFViewController.m
//  Simple_Button_Label
//
//  Created by Jonathan Fox on 4/7/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "JHFViewController.h"

@interface JHFViewController ()

@end

@implementation JHFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(id)sender {
    
    self.myLabel.text = @"This is cool!";
}
@end
