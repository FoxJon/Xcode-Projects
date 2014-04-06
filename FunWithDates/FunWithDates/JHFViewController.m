//
//  JHFViewController.m
//  FunWithDates
//
//  Created by Jonathan Fox on 4/5/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "JHFViewController.h"

@interface JHFViewController ()

@end

@implementation JHFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSDate *today = [NSDate date];
    NSLog(@"Today: %@", today);
    
    NSTimeInterval secondsPerDay = 60 * 60 * 24;
    NSDate * tomorrow = [NSDate dateWithTimeIntervalSinceNow:secondsPerDay];
    NSLog(@"Tomorrow: %@", tomorrow);
    
    NSDate * yesterday = [NSDate dateWithTimeIntervalSinceNow:-secondsPerDay];
    NSLog(@"Yesterday: %@", yesterday);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EE MMM, dd"];
    NSString *todayString = [dateFormatter stringFromDate:today];
    NSLog(@"Today: %@", todayString);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
