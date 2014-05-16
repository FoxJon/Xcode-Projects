//
//  SABViewController.m
//  Stuffed Animal Battle
//
//  Created by Jonathan Fox on 5/15/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "SABViewController.h"
#import <SpriteKit/SpriteKit.h>
#import "SABGameScene.h"

@interface SABViewController ()

@end

@implementation SABViewController

-(id)init
{
    self = [super init];
    if (self)
    {
        SKView * skView = [[SKView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
        [self.view addSubview:skView];
        
        SABGameScene * skScene = [[SABGameScene alloc]initWithSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
        
        skView.showsFPS = YES;
        skView.showsNodeCount = YES;
        
        skScene.backgroundColor = [SKColor cyanColor];

        [skView presentScene:skScene];
        
         UIButton * buttonA = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-50, SCREEN_HEIGHT-110, 40, 40)];
        
        [buttonA addTarget:skScene action:@selector(fire:) forControlEvents:UIControlEventTouchUpInside];
        
        buttonA.backgroundColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:0.5];
        buttonA.layer.cornerRadius = 20;
        
        [buttonA setTitle:@"A" forState:UIControlStateNormal];
        
        [self.view addSubview:buttonA];
        
         UIButton * buttonB = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-80, SCREEN_HEIGHT-70, 40, 40)];
        
        [buttonB addTarget:skScene action:@selector(power:) forControlEvents:UIControlEventTouchUpInside];
        
        buttonB.backgroundColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:0.5];
        buttonB.layer.cornerRadius = 20;
        
        [buttonB setTitle:@"B" forState:UIControlStateNormal];
        
        [self.view addSubview:buttonB];
        
        UIButton * dpadUp = [[UIButton alloc]initWithFrame:CGRectMake(40, 200, 30, 30)];
        
        [dpadUp addTarget:skScene action:@selector(up:) forControlEvents:UIControlEventTouchUpInside];
        
        dpadUp.backgroundColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:0.5];
        dpadUp.layer.cornerRadius = 15;
        
        [dpadUp setTitle:nil forState:UIControlStateNormal];
        
        [self.view addSubview:dpadUp];
        
        UIButton * dpadDown = [[UIButton alloc]initWithFrame:CGRectMake(40, 260, 30, 30)];
        [dpadDown addTarget:skScene action:@selector(down:) forControlEvents:UIControlEventTouchUpInside];
        
        dpadDown.backgroundColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:0.5];
        dpadDown.layer.cornerRadius = 15;
        
        [dpadDown setTitle:nil forState:UIControlStateNormal];
        
        [self.view addSubview:dpadDown];
        
        UIButton * dpadLeft = [[UIButton alloc]initWithFrame:CGRectMake(15, 230, 30, 30)];
        [dpadLeft addTarget:skScene action:@selector(left:) forControlEvents:UIControlEventTouchUpInside];
        
        dpadLeft.backgroundColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:0.5];
        dpadLeft.layer.cornerRadius = 15;
        
        [dpadLeft setTitle:nil forState:UIControlStateNormal];
        
        [self.view addSubview:dpadLeft];
        
        UIButton * dpadRight = [[UIButton alloc]initWithFrame:CGRectMake(65, 230, 30, 30)];
        [dpadRight addTarget:skScene action:@selector(right:) forControlEvents:UIControlEventTouchUpInside];
        
        dpadRight.backgroundColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:0.5];
        dpadRight.layer.cornerRadius = 15;
        
        [dpadRight setTitle:nil forState:UIControlStateNormal];
        
        [self.view addSubview:dpadRight];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(BOOL)prefersStatusBarHidden {return YES;}

@end
