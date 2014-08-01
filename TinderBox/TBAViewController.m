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
    UIButton * resetButton;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        [self makeGrayBox];
        
        resetButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, SCREEN_HEIGHT-70, 100, 60)];
        [resetButton setTitle:@"RESET" forState:UIControlStateNormal];
        [resetButton addTarget:self action:@selector(makeGrayBox) forControlEvents:UIControlEventTouchUpInside];
        resetButton.alpha = 0;
        [self.view addSubview:resetButton];
    }
    return self;
}


- (void)makeGrayBox {
    grayBox = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, SCREEN_HEIGHT/2-100, 200, 200)];
    grayBox.backgroundColor = [UIColor darkGrayColor];
    grayBox.layer.cornerRadius = 15;
    grayBox.layer.shadowColor = [UIColor blackColor].CGColor;
    grayBox.layer.shadowOpacity = 0.75;
    grayBox.layer.shadowRadius = 15.0;
    grayBox.layer.shadowOffset = (CGSize){0.0,20.0};
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
        resetButton.alpha = 0;
    }];
}

- (void)handlePan:(UIPanGestureRecognizer *)gestureRecognizer {
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        [self.animator removeBehavior:self.snap];
    }
    
    else if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        
        CGPoint newCenter = grayBox.center;
        newCenter.x += [gestureRecognizer translationInView:self.view].x;
        newCenter.y += [gestureRecognizer translationInView:self.view].y;
        
        grayBox.center = newCenter;
        
        NSLog(@"%f", gestureRecognizer.view.frame.origin.y);
        
        // rotation
        if ([gestureRecognizer translationInView:self.view].y < 100) {
            grayBox.transform = CGAffineTransformMakeRotation((grayBox.center.x/SCREEN_WIDTH-.5)/3);
        }
        else if ([gestureRecognizer translationInView:self.view].y > 100) {
            grayBox.transform = CGAffineTransformMakeRotation(((SCREEN_WIDTH-grayBox.center.x)/SCREEN_WIDTH-.5)/3);
        }
        
        // alpha
        if (grayBox.center.x > self.view.frame.origin.x+SCREEN_WIDTH/2) {
            grayBox.alpha = (SCREEN_WIDTH-grayBox.center.x)/SCREEN_WIDTH+.5;
        }else if (grayBox.center.x < self.view.frame.origin.x+SCREEN_WIDTH/2) {
            grayBox.alpha = (grayBox.center.x)/SCREEN_WIDTH+.5;
        }
        
        // velocity
        if ([gestureRecognizer velocityInView:self.view].x > -500 && [gestureRecognizer velocityInView:self.view].x < 500) {
            [gestureRecognizer setTranslation:CGPointZero inView:self.view];
        }
    }
    else if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        
        //animate off screen or snap back to center
        if (grayBox.center.x < 0) {
            [UIView animateWithDuration:0.1 animations:^{
                grayBox.frame = CGRectMake(-200, grayBox.center.y-100, 200, 200);
            }completion:^(BOOL finished) {
                [self removeGrayBoxAndShowResetButton];
            }];
        } else if (grayBox.center.x > SCREEN_WIDTH) {
            [UIView animateWithDuration:0.1 animations:^{
                grayBox.frame = CGRectMake(SCREEN_WIDTH+200, grayBox.center.y-100, 200, 200);
            }completion:^(BOOL finished) {
                [self removeGrayBoxAndShowResetButton];
            }];
        } else {
            [self.animator addBehavior:self.snap];
            [UIView animateWithDuration:0.4 animations:^{
                grayBox.alpha = 1;
            }];
        }
    }
}

-(void)removeGrayBoxAndShowResetButton {
    [grayBox removeFromSuperview];
    [UIView animateWithDuration:0.4 animations:^{
        resetButton.alpha = 1;
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {return YES;}

@end
