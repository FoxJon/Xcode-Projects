//
//  ImageViewController.m
//  Ribbit
//
//  Created by Jonathan Fox on 4/27/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()

@end

@implementation ImageViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    PFFile *imageFile = [self.message objectForKey:@"file"];
    NSURL *imageFileURL = [[NSURL alloc]initWithString:imageFile.url];
    NSData *imageData = [NSData dataWithContentsOfURL:imageFileURL];
    self.imageView.image = [UIImage imageWithData:imageData];
    
    NSString *senderName = [self.message objectForKey:@"senderName"];
    NSString *title = [NSString stringWithFormat:@"Sent from %@", senderName];
    self.navigationItem.title = title;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if ([self respondsToSelector:@selector(timeOut)]){
    [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(timeOut) userInfo:nil repeats:NO];
     }else{
         NSLog(@"Error: selector missing");
     }
}

-(void)timeOut{
    [self.navigationController popToRootViewControllerAnimated:YES];
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

@end
