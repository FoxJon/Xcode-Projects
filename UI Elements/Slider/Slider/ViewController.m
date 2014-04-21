//
//  ViewController.m
//  Slider
//
//  Created by Jonathan Fox on 4/20/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    UISlider * mySlider;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addSlider];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)sliderChanged:(id)sender{
    NSLog(@"SliderValue %f",mySlider.value);
}

-(void)addSlider{
    mySlider = [[UISlider alloc] initWithFrame:CGRectMake(50, 200, 200, 23)];
    [self.view addSubview:mySlider];
    mySlider.minimumValue = 10.0;
    mySlider.maximumValue = 99.0;
    mySlider.continuous = NO;
    [mySlider addTarget:self action:@selector(sliderChanged:)
       forControlEvents:UIControlEventValueChanged];
}
@end
