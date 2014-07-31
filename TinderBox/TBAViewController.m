//
//  TBAViewController.m
//  TinderBox
//
//  Created by Jonathan Fox on 7/30/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "TBAViewController.h"

@interface TBAViewController ()

@property UIPanGestureRecognizer * gestureRecognizer;
@property UISnapBehavior * snap;
@property UIDynamicAnimator * animator;

@end

@implementation TBAViewController
{
    UIView * grayBox;
    UIButton * reset;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        [self makeGrayBox];
        
        reset = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, SCREEN_HEIGHT-50, 100, 30)];
        [reset setTitle:@"RESET" forState:UIControlStateNormal];
        [reset addTarget:self action:@selector(makeGrayBox) forControlEvents:UIControlEventTouchUpInside];
        reset.alpha = 0;
        [self.view addSubview:reset];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)makeGrayBox {
    grayBox = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, SCREEN_HEIGHT/2-100, 200, 200)];
    grayBox.backgroundColor = [UIColor darkGrayColor];
    grayBox.layer.cornerRadius = 15;
    grayBox.alpha = 0;
    [self.view addSubview:grayBox];
    
    self.animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    self.snap = [[UISnapBehavior alloc]initWithItem:grayBox snapToPoint:self.view.center];
    self.gestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    [grayBox addGestureRecognizer:self.gestureRecognizer];
    
    UILabel * grayBoxLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, grayBox.frame.size.height/2-15, grayBox.frame.size.width, 30)];
    grayBoxLabel.text = @"DRAG ME";
    grayBoxLabel.textAlignment = 1;
    grayBoxLabel.textColor = [UIColor whiteColor];
    grayBoxLabel.alpha = 0;
    [grayBox addSubview:grayBoxLabel];
    
    [UIView animateWithDuration:0.4 animations:^{
        grayBox.alpha = 1;
        grayBoxLabel.alpha = 1;
        reset.alpha = 0;
    }completion:^(BOOL finished) {
    }];
    
}

- (void)handlePan:(UIPanGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        [self.animator removeBehavior:self.snap];
    }
    else if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint newCenter = grayBox.center;
        newCenter.x += [gestureRecognizer translationInView:self.view].x;
        newCenter.y += [gestureRecognizer translationInView:self.view].y;
        
        grayBox.center = newCenter;
        
        [gestureRecognizer setTranslation:CGPointZero inView:self.view];
        
    }
    else if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        
        NSLog(@"%f", grayBox.center.y);
        if (grayBox.center.x < 0) {
            [UIView animateWithDuration:0.1 animations:^{
                grayBox.frame = CGRectMake(-200, grayBox.center.y-100, 200, 200);
            }completion:^(BOOL finished) {
                [grayBox removeFromSuperview];
                [UIView animateWithDuration:0.4 animations:^{
                    reset.alpha = 1;
                }completion:^(BOOL finished) {
                }];
            }];
        } else if (grayBox.center.x > SCREEN_WIDTH) {
            [UIView animateWithDuration:0.1 animations:^{
                grayBox.frame = CGRectMake(SCREEN_WIDTH+200, grayBox.center.y-100, 200, 200);
            }completion:^(BOOL finished) {
                [grayBox removeFromSuperview];
                [UIView animateWithDuration:0.4 animations:^{
                    reset.alpha = 1;
                }completion:^(BOOL finished) {
                }];
            }];
        } else {
            [self.animator addBehavior:self.snap];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {return YES;}

@end
