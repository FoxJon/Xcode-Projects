//
//  NAVColorViewController.m
//  Navigator
//
//  Created by Jonathan Fox on 5/14/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "NAVColorViewController.h"
#import "NAVTableViewController.h"
#import "NAVData.h"
#import "NAVSettingsTab.h"
#import "NAVCircle.h"
#import "NAVSquare.h"
#import "NAVTriangle.h"
#import "NAVDiamond.h"

@interface NAVColorViewController ()

@end

@implementation NAVColorViewController
{
    UIView * frame;
    UIView * drawer;
    UIView * tab;
    UIView * tapLocation1;
    UIView * tapLocation2;
    BOOL dragging;
    NAVSettingsTab * tabView;
    NAVCircle * circleDraw;
    NAVSquare * squareDraw;
    NAVTriangle * triangleDraw;
    NAVDiamond * diamondDraw;
    UIButton * circleButton;
    UIButton * squareButton;
    UIButton * triangleButton;
    UIButton * diamondButton;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        if ([[NAVData mainData].color isEqual: @"Red"]) {
            self.view.backgroundColor = [UIColor redColor];
        }else if ([[NAVData mainData].color isEqual: @"Yellow"]) {
            self.view.backgroundColor = [UIColor yellowColor];
        }else if ([[NAVData mainData].color isEqual: @"Green"]) {
            self.view.backgroundColor = [UIColor greenColor];
        }else if ([[NAVData mainData].color isEqual: @"Blue"]) {
            self.view.backgroundColor = [UIColor blueColor];
        }
        
        drawer = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width, 44, 75, self.view.frame.size.height-44)];
        drawer.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.3];
        
        tab = [[UIView alloc]initWithFrame:CGRectMake(-20, 15, 20, 45)];
        //tab.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.05];
        [drawer addSubview:tab];
        
        tabView = [[NAVSettingsTab alloc]initWithFrame:CGRectMake(0, 10, 20, 45)];
        tabView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.05];
        [tab addSubview:tabView];
        
        tapLocation1 = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 20, 67, 20, 45)];
        tapLocation1.backgroundColor = [UIColor clearColor];
        [self.view addSubview:tapLocation1];
        
        tapLocation2 = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-95, 67, 20, 45)];
        tapLocation2.backgroundColor = [UIColor clearColor];
        [self.view addSubview:tapLocation2];
        
        
        circleDraw = [[NAVCircle alloc]initWithFrame:CGRectMake(drawer.frame.size.width/2-30, 23.2, 60, 60)];
        circleDraw.backgroundColor = [UIColor clearColor];
        [drawer addSubview:circleDraw];
        
        circleButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
        circleButton.backgroundColor = [UIColor clearColor];
        [circleButton addTarget:self action:@selector(addCircle) forControlEvents:UIControlEventTouchUpInside];
        [circleDraw addSubview:circleButton];
        
        squareDraw = [[NAVSquare alloc]initWithFrame:CGRectMake(drawer.frame.size.width/2-30, 126.4, 60, 60)];
        squareDraw.backgroundColor = [UIColor clearColor];
        [drawer addSubview:squareDraw];
        
        squareButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
        squareButton.backgroundColor = [UIColor clearColor];
        [squareButton addTarget:self action:@selector(addSquare) forControlEvents:UIControlEventTouchUpInside];
        [squareDraw addSubview:squareButton];
        
        triangleDraw = [[NAVTriangle alloc]initWithFrame:CGRectMake(drawer.frame.size.width/2-30, 229.6, 60, 60)];
        triangleDraw.backgroundColor = [UIColor clearColor];
        [drawer addSubview:triangleDraw];
        
        triangleButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
        triangleButton.backgroundColor = [UIColor clearColor];
        [triangleButton addTarget:self action:@selector(addTriangle) forControlEvents:UIControlEventTouchUpInside];
        [triangleDraw addSubview:triangleButton];
        
        
        diamondDraw = [[NAVDiamond alloc]initWithFrame:CGRectMake(drawer.frame.size.width/2-30, 332.8, 60, 60)];
        diamondDraw.backgroundColor = [UIColor clearColor];
        [drawer addSubview:diamondDraw];
        
        diamondButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
        diamondButton.backgroundColor = [UIColor clearColor];
        [diamondButton addTarget:self action:@selector(addDiamond) forControlEvents:UIControlEventTouchUpInside];
        [diamondDraw addSubview:diamondButton];
        
        frame = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-75, self.view.frame.size.height/2-75, 150, 150)];
        //frame.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.05];
        
        [self.view addSubview:frame];
    }
    return self;
}

- (void)addCircle
{
    if (squareDraw.frame.origin.x == 0) {
        squareDraw.frame = CGRectMake(-158, 165, 150, 150);
        [drawer addSubview:squareDraw];
    }else if (diamondDraw.frame.origin.x == 0) {
        diamondDraw.frame = CGRectMake(-158, 165, 150, 150);
        [drawer addSubview:diamondDraw];
    }else if (triangleDraw.frame.origin.x == 0) {
        triangleDraw.frame = CGRectMake(-158, 165, 150, 150);
        [drawer addSubview:triangleDraw];
    }
    
    [UIView animateWithDuration:0.3 delay:0.0 options:
     UIViewAnimationOptionCurveEaseInOut animations:^{
         circleDraw.frame = CGRectMake(-158, 165, 150, 150);
         squareDraw.frame = CGRectMake(drawer.frame.size.width/2-30, 126.4, 60, 60);
         triangleDraw.frame = CGRectMake(drawer.frame.size.width/2-30, 229.6, 60, 60);
         diamondDraw.frame = CGRectMake(drawer.frame.size.width/2-30, 332.8, 60, 60);
     } completion:^(BOOL finished) {
         circleDraw.frame = CGRectMake(0, 0, 150, 150);
         [frame addSubview:circleDraw];

        [UIView animateWithDuration:0.3 delay:0.0 options:
         UIViewAnimationOptionCurveEaseInOut animations:^{
             
             drawer.frame = CGRectMake(self.view.frame.size.width, 44, 75, self.view.frame.size.height-44);
         } completion:^(BOOL finished) {
          }];
     }];
}

- (void)addSquare
{
    if (circleDraw.frame.origin.x == 0) {
        circleDraw.frame = CGRectMake(-158, 165, 150, 150);
        [drawer addSubview:circleDraw];
    }else if (diamondDraw.frame.origin.x == 0) {
        diamondDraw.frame = CGRectMake(-158, 165, 150, 150);
        [drawer addSubview:diamondDraw];
    }else if (triangleDraw.frame.origin.x == 0) {
        triangleDraw.frame = CGRectMake(-158, 165, 150, 150);
        [drawer addSubview:triangleDraw];
    }
    
    [UIView animateWithDuration:0.3 delay:0.0 options:
     UIViewAnimationOptionCurveEaseInOut animations:^{
         circleDraw.frame = CGRectMake(drawer.frame.size.width/2-30, 23.2, 60, 60);
         squareDraw.frame = CGRectMake(-158, 165, 150, 150);
         triangleDraw.frame = CGRectMake(drawer.frame.size.width/2-30, 229.6, 60, 60);
         diamondDraw.frame = CGRectMake(drawer.frame.size.width/2-30, 332.8, 60, 60);
     } completion:^(BOOL finished) {
         squareDraw.frame = CGRectMake(0, 0, 150, 150);
         [frame addSubview:squareDraw];
        
        [UIView animateWithDuration:0.3 delay:0.0 options:
         UIViewAnimationOptionCurveEaseInOut animations:^{
             drawer.frame = CGRectMake(self.view.frame.size.width, 44, 75, self.view.frame.size.height-44);
         } completion:^(BOOL finished) {
    
         }];
     }];
}

- (void)addTriangle
{
    if (circleDraw.frame.origin.x == 0) {
        circleDraw.frame = CGRectMake(-158, 165, 150, 150);
        [drawer addSubview:circleDraw];
    }else if (squareDraw.frame.origin.x == 0) {
        squareDraw.frame = CGRectMake(-158, 165, 150, 150);
        [drawer addSubview:squareDraw];
    }else if (diamondDraw.frame.origin.x == 0) {
        diamondDraw.frame = CGRectMake(-158, 165, 150, 150);
        [drawer addSubview:diamondDraw];
    }
    [UIView animateWithDuration:0.3 delay:0.0 options:
     UIViewAnimationOptionCurveEaseInOut animations:^{
         triangleDraw.frame = CGRectMake(-158, 165, 150, 150);
         squareDraw.frame = CGRectMake(drawer.frame.size.width/2-30, 126.4, 60, 60);
         circleDraw.frame = CGRectMake(drawer.frame.size.width/2-30, 23.2, 60, 60);
         diamondDraw.frame = CGRectMake(drawer.frame.size.width/2-30, 332.8, 60, 60);
     } completion:^(BOOL finished) {
         triangleDraw.frame = CGRectMake(0, 0, 150, 150);
         [frame addSubview:triangleDraw];
         
         [UIView animateWithDuration:0.3 delay:0.0 options:
          UIViewAnimationOptionCurveEaseInOut animations:^{
              
              drawer.frame = CGRectMake(self.view.frame.size.width, 44, 75, self.view.frame.size.height-44);
          } completion:^(BOOL finished) {
          }];
     }];
}

- (void)addDiamond
{
    if (circleDraw.frame.origin.x == 0) {
        circleDraw.frame = CGRectMake(-158, 165, 150, 150);
        [drawer addSubview:circleDraw];
    }else if (squareDraw.frame.origin.x == 0) {
        squareDraw.frame = CGRectMake(-158, 165, 150, 150);
        [drawer addSubview:squareDraw];
    }else if (triangleDraw.frame.origin.x == 0) {
        triangleDraw.frame = CGRectMake(-158, 165, 150, 150);
        [drawer addSubview:triangleDraw];
    }
    [UIView animateWithDuration:0.3 delay:0.0 options:
     UIViewAnimationOptionCurveEaseInOut animations:^{
         diamondDraw.frame = CGRectMake(-158, 165, 150, 150);
         squareDraw.frame = CGRectMake(drawer.frame.size.width/2-30, 126.4, 60, 60);
         triangleDraw.frame = CGRectMake(drawer.frame.size.width/2-30, 229.6, 60, 60);
         circleDraw.frame = CGRectMake(drawer.frame.size.width/2-30, 23.2, 60, 60);
     } completion:^(BOOL finished) {
         diamondDraw.frame = CGRectMake(0, 0, 150, 150);
         [frame addSubview:diamondDraw];
         
         [UIView animateWithDuration:0.3 delay:0.0 options:
          UIViewAnimationOptionCurveEaseInOut animations:^{
              
              drawer.frame = CGRectMake(self.view.frame.size.width, 44, 75, self.view.frame.size.height-44);
          } completion:^(BOOL finished) {
          }];
     }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    [self.view addGestureRecognizer:tap];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];

//    self.navigationItem.hidesBackButton = YES;
    self.navigationController.toolbarHidden = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.view addSubview:drawer];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [drawer removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)singleTap:(UITapGestureRecognizer *)recognizer {
    
    CGPoint location = [recognizer locationInView:[recognizer.view superview]];    
    
    if (CGRectContainsPoint(tapLocation1.frame, location))    {

    [UIView animateWithDuration:0.3 delay:0.0 options:
     UIViewAnimationOptionCurveEaseInOut animations:^{
         
    drawer.frame = CGRectMake(self.view.frame.size.width -75, 44, 75, self.view.frame.size.height-44);
     } completion:^(BOOL finished) {
         
     }];
    }else{
        if (CGRectContainsPoint(tapLocation2.frame, location))    {
            
            [UIView animateWithDuration:0.3 delay:0.0 options:
             UIViewAnimationOptionCurveEaseInOut animations:^{
                 
                 drawer.frame = CGRectMake(self.view.frame.size.width, 44, 75, self.view.frame.size.height-44);
             } completion:^(BOOL finished) {
                 
             }];
        }
    }
}

-(BOOL)prefersStatusBarHidden{return YES;}

@end
