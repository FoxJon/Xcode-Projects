//
//  ViewController.m
//  Buttons
//
//  Created by Jonathan Fox on 4/8/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    [self addDifferentTypesOfButton];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addDifferentTypesOfButton
{
    // A rounded Rect button created by using class method
    UIButton *roundRectButton = [UIButton buttonWithType:
                                 UIButtonTypeRoundedRect];
    [roundRectButton setFrame:CGRectMake(60, 50, 200, 40)];
    // sets title for the button
    [roundRectButton setTitle:@"Rounded Rect Button" forState:
     UIControlStateNormal];
    [self.view addSubview:roundRectButton];
    
//    UIButton *customButton = [UIButton buttonWithType: UIButtonTypeCustom];
//    [customButton setBackgroundColor: [UIColor lightGrayColor]];
//    [customButton setTitleColor:[UIColor blackColor] forState:
//     UIControlStateHighlighted];
//    //sets background image for normal state
//    [customButton setBackgroundImage:[UIImage imageNamed:
//                                      @"Button_Default.png"]
//                            forState:UIControlStateNormal];
//    //sets background image for highlighted state
//    [customButton setBackgroundImage:[UIImage imageNamed:
//                                      @"Button_Highlighted.png"]
//                            forState:UIControlStateHighlighted];
//    [customButton setFrame:CGRectMake(60, 100, 200, 40)];
//    [customButton setTitle:@"Custom Button" forState:UIControlStateNormal];
//    [self.view addSubview:customButton];
    
    UIButton *detailDisclosureButton = [UIButton buttonWithType:
                                        UIButtonTypeDetailDisclosure];
    [detailDisclosureButton setFrame:CGRectMake(60, 150, 200, 40)];
    [detailDisclosureButton setTitle:@"Detail disclosure" forState:
     UIControlStateNormal];
    [self.view addSubview:detailDisclosureButton];
    
    UIButton *contactButton = [UIButton buttonWithType:
                               UIButtonTypeContactAdd];
    [contactButton setFrame:CGRectMake(60, 200, 200, 40)];
    [self.view addSubview:contactButton];
    
    UIButton *infoDarkButton = [UIButton buttonWithType:
                                UIButtonTypeInfoDark];
    [infoDarkButton setFrame:CGRectMake(60, 250, 200, 40)];
    [self.view addSubview:infoDarkButton];
    
    UIButton *infoLightButton = [UIButton buttonWithType:
                                 UIButtonTypeInfoLight];
    [infoLightButton setFrame:CGRectMake(60, 300, 200, 40)];
    [self.view addSubview:infoLightButton];
}

@end
