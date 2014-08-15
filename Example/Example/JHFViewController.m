//
//  JHFViewController.m
//  Example
//
//  Created by Jonathan Fox on 8/14/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "JHFViewController.h"
#import <SAMGradientView/SAMGradientView.h>

@interface JHFViewController ()

@end

@implementation JHFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    SAMGradientView * gradient = [[SAMGradientView alloc]initWithFrame:self.view.bounds];
    gradient.gradientColors = @[[UIColor blueColor], [UIColor darkGrayColor]];
    [self.view addSubview:gradient];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
