//
//  ViewController.m
//  ImageView
//
//  Created by Jonathan Fox on 4/20/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addImageViewWithAnimation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addImageView{
    UIImageView *imgview = [[UIImageView alloc]
                            initWithFrame:CGRectMake(10, 10, 300, 400)];
    [imgview setImage:[UIImage imageNamed:@"AshbyThornwell.png"]];
    [imgview setContentMode:UIViewContentModeScaleAspectFit];
    [self.view addSubview:imgview];
}

-(void)addImageViewWithAnimation{
    UIImageView *imgview = [[UIImageView alloc]
                            initWithFrame:CGRectMake(10, 10, 300, 400)];
    // set an animation
    imgview.animationImages = [NSArray arrayWithObjects:
                               [UIImage imageNamed:@"AliHoushmand.png"],
                               [UIImage imageNamed:@"AshbyThornwell.png"], nil];
    imgview.animationDuration = 2.0;
    imgview.animationRepeatCount = 2;
    imgview.contentMode = UIViewContentModeCenter;
    [imgview startAnimating];
    [self.view addSubview:imgview];
}
@end
