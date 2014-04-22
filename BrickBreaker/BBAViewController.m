//
//  BBAViewController.m
//  BrickBreaker
//
//  Created by Jonathan Fox on 4/17/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "BBAViewController.h"
#import "BBALevelController.h"

@interface BBAViewController () <BBALevelDelegate>

@end

@implementation BBAViewController
{
    BBALevelController * level;
    UIButton * startButton;
    UIButton * endButton;
    UILabel * buttonRing;
    UILabel * scoreLabel;
    UILabel * livesLabel;
    UILabel * totalScoreLabel;
    UILabel * highScoreLabel;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
   
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
//    topScore = [[userDefaults objectForKey:@“topScore”] intValue];
    
    buttonRing = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/2 - 125), (SCREEN_HEIGHT/2 - 75), 250, 150)];
    buttonRing.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.8];
    buttonRing.layer.cornerRadius = 6;
    buttonRing.alpha = 0.1;
    buttonRing.layer.masksToBounds = YES;
    
    [self.view addSubview:buttonRing];

    
    startButton = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/2 - 100), (SCREEN_HEIGHT/2 - 50), 200, 100)];
    [startButton setTitle:@"START" forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(resetNewGame) forControlEvents:UIControlEventTouchUpInside];
    startButton.backgroundColor = [UIColor redColor];
    startButton.layer.cornerRadius = 6;
    
    [self.view addSubview:startButton];
}

- (void)resetNewGame
{
    scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(260, 0, 60, 20)];
    scoreLabel.backgroundColor = [UIColor clearColor];
    scoreLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    scoreLabel.text = [NSString stringWithFormat:@"0"];
    [self.view addSubview:scoreLabel];
    
    livesLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 20)];
    livesLabel.backgroundColor = [UIColor clearColor];
    livesLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    livesLabel.text = [NSString stringWithFormat:@"LIVES: 3"];
    [self.view addSubview:livesLabel];
    
    level = [[BBALevelController alloc] initWithNibName:nil bundle:nil];
    level.delegate = self;
    
    level.view.frame = CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT - 40);
    [self.view addSubview:level.view];
    
    [startButton removeFromSuperview];
    [buttonRing removeFromSuperview];
    [totalScoreLabel removeFromSuperview];
    [highScoreLabel removeFromSuperview];

    
    [level resetLevel];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) gameDone:(int)points
{
    
    NSLog(@"Game Done");
    
    [level.view removeFromSuperview];

    [scoreLabel removeFromSuperview];
    [livesLabel removeFromSuperview];
    
    buttonRing = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/2 - 125), (SCREEN_HEIGHT/2 - 75), 250, 150)];
    buttonRing.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.8];
    buttonRing.layer.cornerRadius = 6;
    buttonRing.alpha = 0.1;
    buttonRing.layer.masksToBounds = YES;
    
    [self.view addSubview:buttonRing];
    
    
    endButton = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/2 - 100), (SCREEN_HEIGHT/2 - 50), 200, 100)];
    
    [endButton setTitle:@"GAME OVER" forState:UIControlStateNormal];
    [endButton addTarget:self action:@selector(resetNewGame) forControlEvents:UIControlEventTouchUpInside];
    endButton.backgroundColor = [UIColor redColor];
    endButton.layer.cornerRadius = 6;
    
    [self.view addSubview:endButton];
    
    totalScoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 87, 320, 175, 20)];
    totalScoreLabel.backgroundColor = [UIColor clearColor];
    totalScoreLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    totalScoreLabel.text = [NSString stringWithFormat:@"  TOTAL SCORE: %d", points];
    [self.view addSubview:totalScoreLabel];

    highScoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 95, 340, 220, 20)];
    highScoreLabel.backgroundColor = [UIColor clearColor];
    highScoreLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    
    
   static int highScore = 0;

    if (points > highScore)
    {
        highScore = points;
        highScoreLabel.text = [NSString stringWithFormat:@"NEW HIGH SCORE!! %d", highScore];
        [self.view addSubview:highScoreLabel];
    }
    else
    {
    highScoreLabel.text = [NSString stringWithFormat:@"  HIGH SCORE: %d", highScore];
    [self.view addSubview:highScoreLabel];
    }
//    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
//    
//    [userDefaults setObject:@(topScore) forkey:@“topScore”];
//    
//    [userDefaults synchronize]; -  // Saves to local device.
}

-(void)addPoints:(int)points
{
    scoreLabel.text = [NSString stringWithFormat:@"%d", points];
}

-(void)addLives:(int)totalLives
{
    NSLog(@"LIVES");
    livesLabel.text = [NSString stringWithFormat:@"LIVES: %d", totalLives];
}


-(BOOL)prefersStatusBarHidden {return YES;}


@end
