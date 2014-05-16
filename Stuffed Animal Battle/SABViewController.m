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
{
    UIButton * buttonA;
}

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
        
        buttonA = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-110, SCREEN_HEIGHT-110, 40, 40)];
        
        [buttonA addTarget:skScene action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        buttonA.backgroundColor = [UIColor lightGrayColor];
        buttonA.layer.cornerRadius = 20;
        
        [buttonA setTitle:@"A" forState:UIControlStateNormal];
        
        [self.view addSubview:buttonA];
        
        
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
